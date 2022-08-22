#!/usr/bin/env bash

cd bin || exit
echo "time (find 10G* -mindepth 0 -maxdepth 1 | xargs -I{} -n 1 -P 20 aws s3 cp {} s3://transfer-large-file-size)"
time (find 10G* -mindepth 0 -maxdepth 1 | xargs -I{} -n 1 -P 20 aws s3 cp {} s3://transfer-large-file-size)