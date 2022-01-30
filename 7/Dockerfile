FROM oraclelinux:7
LABEL maintainer="Michael Buluma"

RUN yum install DNF -y
# Check Repolist before
RUN dnf repolist
RUN yum update -y

RUN dnf info oracle-epel-release-el7.x86_64

RUN dnf install oracle-epel-release-el7 -y

# Check Repolist after
RUN dnf repolist

RUN dnf install sudo which ansible initscripts -y && ansible --version

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

CMD ["/bin/bash"]
