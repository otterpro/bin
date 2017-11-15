#!/bin/sh
cd ~/blog-hugo/
# clean existing public dir for now

rm -rf public/*
rm -rf content/posts/*
# copy source content
rsync -av --del ~/notes/*.md content/posts/

# todo: remotely run hugo build
# however, currently doing locally
hugo

