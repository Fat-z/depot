#!/bin/sh
sed -i '/source/d' Gemfile
sed -i '1 i source "https://rubygems.org/"' Gemfile
