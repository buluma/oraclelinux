FROM oraclelinux:8

# COPY ol8-temp.repo /etc/yum.repos.d/ol8-temp.repo
# COPY ol8-temp.repo /etc/yum.repos.d/ol8-epel.repo

# Install oraclelinux-release-el8
# RUN yum install oraclelinux-release-el8

RUN dnf makecache
# RUN dnf repolist all

RUN dnf list –installed | grep oraclelinux-release

CMD ["/bin/bash"]
