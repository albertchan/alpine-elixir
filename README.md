Erlang/Elixir on Alpine Linux
=============================

Alpine Linux is a lightweight Linux distribution built around **musl** libc and **busybox**.
The main focus of this distribution is security, simplicity and resource efficiency.
All that makes Alpine Linux perfect to work as base images for linux **containers**.

This is based on work for `msaraiva/erlang` but includes an init system for PID 1 and DNS fixes for Alpine's lack of support for `search` in `resolv.conf`.

See [Erlang/Elixir on Alpine Linux](https://github.com/msaraiva/alpine-erlang) to learn more about creating **minimal Erlang/Elixir docker images with Alpine Linux**.

> **Notice:** This image does not contain git, wget, rebar or hex. If you need to download dependencies, see [pmbauer/elixir-dev](https://registry.hub.docker.com/u/pmbauer/elixir-dev/)

The following packages are pre-installed:

- erlang + dependencies
- elixir

> **Notice:** In order to keep images as compact as possible, Erlang libraries for Alpine Linux are split into many different packages. The full list of Erlang packages available can be found [here](https://pkgs.alpinelinux.org/packages?name=erlang%25&repo=all&arch=x86_64&maintainer=all)

## Usage

```
$ docker run --rm -it albertchan/elixir iex
Erlang/OTP 18 [erts-7.1] [source] [64-bit] [async-threads:10] [kernel-poll:false]

Interactive Elixir (1.2.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> IO.puts "Hello there!"
Hello there!
:ok
iex(2)>
```

## Getting started (WIP)

- [Packages](#packages)
  - [What is apk?](#what-is-apk)
  - [Installing packages with apk](#installing-packages)
  - [Building packages](#building-packages)
- [Contributing](#contributing)
- [Credits](#credits)
- [Related Projects](#related-projects)
- [Other Resources and News](#other-resources)

## Packages

In order to keep packages as compact as possible, Erlang libraries for Alpine Linux are split into many different packages. The full list of Erlang packages available can be found [here](https://pkgs.alpinelinux.org/packages?name=erlang%25&repo=all&arch=x86_64&maintainer=all).

### <a name="what-is-apk"></a> What is apk?

The `apk` command is the official tool for package management on Alpine Linux. Something like `apt-get` on Ubuntu. More information about `apk` can be found [here](http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management).

### <a name="installing-packages"></a> Installing packages with apk

Create a Dockerfile

```Dockerfile
FROM alpine:3.5

RUN apk --update add erlang && rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
```

Build the image:

```
$ docker build -t erlang .
```

Run `docker images`. You should see something like:

```
REPOSITORY           TAG           IMAGE ID           CREATED             VIRTUAL SIZE
erlang               latest        d76965a1f753       4 seconds ago       18.3 MB
```

### <a name="building-packages"></a> Building packages

You can see how packages are built by looking at the APKBUILD scripts:

- [Erlang](http://git.alpinelinux.org/cgit/aports/tree/community/erlang/APKBUILD)
- [Elixir](http://git.alpinelinux.org/cgit/aports/tree/community/elixir/APKBUILD)

For more info, see <http://wiki.alpinelinux.org/wiki/APKBUILD_Reference>

### <a name="patches"></a> Patches

If you take a look at the APKBUILD scripts, you'll notice that some patches are applied in order to successfully build the packages.
Some of those patches are related to musl, some to Busybox and some just split or remove stuff to make packages smaller.
 - [Patches for Erlang](http://git.alpinelinux.org/cgit/aports/tree/community/erlang)

## <a name="credits"></a> Credits

- [Marlus Saraiva](https://github.com/msaraiva)
- [Paul Bauer](https://github.com/pmbauer/alpine-elixir)

## <a name="other-resources"></a> Other Resources and News

* <http://www.alpinelinux.org>
* <https://registry.hub.docker.com/u/library/alpine/>
* <https://github.com/gliderlabs/docker-alpine>
