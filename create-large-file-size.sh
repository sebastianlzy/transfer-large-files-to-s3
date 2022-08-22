#!/usr/bin/env bash

FILE_SIZE="${FILE_SIZE:=10G}"
RANDOM_NUMBER="$(date +%s)"

echo "creates ./bin/${FILE_SIZE}_image_file_size_${RANDOM_NUMBER}.jpg"
fallocate -l ${FILE_SIZE} "./bin/${FILE_SIZE}_image_file_size_${RANDOM_NUMBER}.jpg"