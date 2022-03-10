Docker Oracle Linux Systemd
===========================

This Dockerfile can build containers capable to use systemd.

[![Build Oracle linux 7](https://github.com/buluma/oraclelinux/actions/workflows/build-7.yml/badge.svg)](https://github.com/buluma/oraclelinux/actions/workflows/build-7.yml)
[![Build Oracle linux 8](https://github.com/buluma/oraclelinux/actions/workflows/build-8.yml/badge.svg)](https://github.com/buluma/oraclelinux/actions/workflows/build-8.yml)

Branches
--------

This repository has multiple branches that relate to Oracle Linux versions.

Manually starting
-----------------

```
docker run \
  --tty \
  --privileged \
  --volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
  buluma/oraclelinux
```
