FROM oraclelinux:8

COPY ol8-temp.repo /etc/yum.repos.d/ol8-temp.repo

# Install oraclelinux-release-el8
RUN yum install oraclelinux-release-el8

CMD ["/bin/bash"]
