FROM ubuntu:latest

# Generic dependencies.
RUN apt-get update && apt-get install -y software-properties-common git

# Common Lisp environment.
RUN apt-add-repository ppa:kelleyk/emacs \
        && apt-get update \
        && apt-get install -y sbcl emacs26

COPY .emacs /root/.emacs

RUN emacs --batch --eval '(load-file "~/.emacs")'
