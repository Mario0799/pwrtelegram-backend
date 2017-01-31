#!/bin/bash

dir=$(dirname $0)
[ "$dir" = "." ] && dir=$PWD
echo "Updating pwrtelegram..."
cd $dir
git pull --recurse-submodules; git submodule update --recursive
cd $dir/beta
git pull
composer update
cd $dir/api
git pull
composer update
