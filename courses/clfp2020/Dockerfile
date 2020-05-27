FROM ubuntu:latest

ENV TZ=Europe/Kiev

ENV DEBIAN_FRONTEND=noninteractive

# Setup timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime 
        && echo $TZ > /etc/timezone

# Generic dependencies.
RUN apt-get update && apt-get install -y software-properties-common git

# Common Lisp environment.
RUN apt-add-repository ppa:kelleyk/emacs \
        && apt-get update \
        && apt-get install -y sbcl emacs26

COPY .emacs /root/.emacs

RUN emacs --batch --eval '(load-file "~/.emacs")'
