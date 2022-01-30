# Copyright (C) Micro Focus 2018. All rights reserved. 

FROM rhel7/rhel:latest
  
# PRODUCT_VERSION is product version associated with this Dockerfile
# SETUP_EXE is the build-arg name for the name of installer
# ACCEPTEULA is the build-arg name for the acceptance of the end user license agreement
# MFLICFILE is the build-arg name for the license filename
ARG PRODUCT_VERSION=4.0.00
ARG SETUP_EXE=setup_ent_server_for_docker_4.0_redhat_x64
ARG ACCEPTEULA
ARG MFLICFILE
ARG LOGFILE=EnterpriseServer4.0.log
ARG ESADM_UID=500
ARG ESADM_GID=500
ARG ESADM_USER=esadm
ARG ESADM_SHELL=/bin/bash
  
LABEL vendor="Micro Focus" \
      com.microfocus.name="Enterprise Server" \
      com.microfocus.version="$PRODUCT_VERSION" \
      com.microfocus.eula.url="https://supportline.microfocus.com/licensing/agreements.aspx" \
      com.microfocus.is-base-image="true"
  
ENV MFPRODBASE=/opt/microfocus/EnterpriseDeveloper
ENV MFLICBASE=/var/microfocuslicensing
 
# install ed, pax and glibc-devel.x86_64 as these are a pre-req for the installer
# note: disablerepo is used to avoid "HTTPS Error 403 - Forbidden" error
RUN yum -y --disablerepo=rhel-7-server-rt-beta-rpms install ed pax glibc-devel.x86_64 file
  
# copy the installer from the local machine to the container
COPY ${SETUP_EXE} /tmp/
  
# Create admin user
RUN groupadd -f -g $ESADM_GID $ESADM_USER && \
    useradd -u $ESADM_UID -g $ESADM_GID -m -s $ESADM_SHELL $ESADM_USER
  
# ensure the setup exe has execute permissions and execute the setup
RUN chmod +x ./tmp/${SETUP_EXE} && \
    (/tmp/${SETUP_EXE} -${ACCEPTEULA} -ESadminID=$ESADM_USER || (echo ${LOGFILE} contains && touch ${LOGFILE} && cat ${LOGFILE} && exit 1)) && \
    rm -f /tmp/${SETUP_EXE} && \
    echo "$MFPRODBASE/lib" >>/etc/ld.so.conf && \
    ldconfig
  
# install a license and remove the license file
COPY ${MFLICFILE} /tmp/
RUN cd /tmp && $MFLICBASE/bin/MFLicenseAdmin -install "${MFLICFILE}" && rm -f "${MFLICFILE}"
#
# clean up for containers that use -network:host
#
RUN  $MFLICBASE/bin/clean_guid_file
