# pintos-dev-env-kaist [![Build Status](https://travis-ci.org/hangpark/pintos-dev-env-kaist.svg?branch=master)](https://travis-ci.org/hangpark/pintos-dev-env-kaist.svg?branch=master)
Dockerizing Pintos developement environment for KAIST CS330 course

This repository provides a Docker image of an environment for Pintos
development. The envrionment is set to be similar to the one KAIST CS330 course
uses. With this envrionment, you can develop and test your Pintos on your local.

## Introduction

Pintos for KAIST CS330 course is emulated in old version of environments:

- Ubuntu 8.04 (Hardy Heron)
- GCC 3.4
- Bochs 2.2.6
- QEMU 0.15.0

You can choose `Bochs` or `QEMU` to emulate Pintos. We provides all of two
emulators.

This repository consits of following files:

- `pintos.tar.gz` is the initial Pintos source code for this course.
- `Dockerfile` for the Docker image provides environment to develop Pintos.
- `pintos.sh` lets you manage your project with simple commands.
- `pintos-travis.yml` is the Travis CI config file for your project.

- `.travis.yml` is to build and deploy Docker image in this repository.
- `README.md`
- `LICENSE`

## Install

Initial Pintos source code for this course is compressed as `pintos.tar.gz`.
Unzip it into your local.

Then you can simply run the Docker image by pulling from
[DockerHub](https://hub.docker.com/r/hangpark/pintos-dev-env-kaist) with
following commands:

```bash
$ sudo docker pull hangpark/pintos-dev-env-kaist
$ sudo docker run -t -d -v <your-pintos-dir>:/pintos --name <container-name> hangpark/pintos-dev-env-kaist
```

or build from the `dockerfile`:

```bash
$ git clone https://github.com/hangpark/pintos-dev-env-kaist.git
$ sudo docker build --tag hangpark/pintos-dev-env-kaist pintos-dev-env-kaist
$ sudo docker run -t -d -v <your-pintos-dir>:/pintos --name <container-name> hangpark/pintos-dev-env-kaist
```

(It might take a long time)

**Note:** Make sure that `src` is not `<your-pintos-dir>`, but the directory
contains `src` directory directly is.

## Run

To run Pintos, use following command:

```bash
$ sudo docker exec -i -t <container-name> /bin/bash -c \
> "cd <target-dir> && pintos <pintos-cmd>"
```

If you just want to build (or check, grade) your Pintos, for example in
`threads`, input:

```bash
$ sudo docker exec -i -t <container-name> /bin/bash -c \
> "cd threads && make [check|grade]"
```

**Note:** `<target-dir>` is a relative path from the `src` directory, such as
`threads` for `pintos/src/threads`.

### Run via Shell Script

We offer you to use the simple shell script, `pintos.sh`, in our repository.
Move `pintos.sh` to `/usr/local/bin` or somewhere added to `PATH`.

Edit `PINTOS_CONTAINER` to your `<container-name>`. And then you
can use

- `sudo pintos start` (Starts the Docker container)
- `sudo pintos stop` (Stops the Docker container)
- `sudo pintos build <target-dir>`
- `sudo pintos check <target-dir>`
- `sudo pintos grade <target-dir>`
- `sudo pintos clean <target-dir>`
- `sudo pintos run <target-dir> "<pintos-cmd>"`

in anywhere without accessing to docker directly.

For example, if you want to see a grade for `userprog` project, just do:

```bash
$ sudo pintos grade userprog && vim <your-pintos-dir>/src/userprog/build/grade
```

**Note:** `pintos help` would print the help message.

**Note:** Adding your account to `docker` group makes you can use this without
`sudo`.

## Continuous Integration

You can also use [Travis CI](https://travis-ci.org)
([here](https://travis-ci.com) for private repos) to manage your project with
continuous integration. It might be useful for co-working with your team
members.

`pintos-travis.yml` is the configuration file, move it to the root directory of
your project. (If you use Git, it would be where `.git` is located.) Rename it
to `.travis.yml`.

Before applying this, you should configure Travis CI settings in the website as
you want, especially you **should add an environment variable**
`TARGET_DIRECTORY` as one of `threads`, `userprog`, `vm`, or etc. You can change
it whenever you starts a new project, such as change it from `threads` to
`userprog` when you start to implement user program features.
