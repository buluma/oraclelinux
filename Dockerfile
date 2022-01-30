FROM oraclelinux:8

# COPY ol8-temp.repo /etc/yum.repos.d/ol8-temp.repo
# COPY ol8-temp.repo /etc/yum.repos.d/ol8-epel.repo

# Install oraclelinux-release-el8
# RUN yum install oraclelinux-release-el8

# RUN dnf makecache
# RUN dnf repolist all
RUN yum update -y

# RUN dnf list –installed | grep oraclelinux-release
RUN dnf info oracle-epel-release-el8.x86_64

RUN dnf install oracle-epel-release-el8

RUN dnf repolist

CMD ["/bin/bash"]
