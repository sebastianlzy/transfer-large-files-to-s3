#!/usr/bin/env bash


BUCKET_NAME="${BUCKET_NAME:=transfer-large-file-size}"
FILE_NAME="${FILE_NAME:=10G_image_file_size_}"

echo "time aws s3 cp ${FILE_NAME} s3://${BUCKET_NAME}"
time aws s3 cp ${FILE_NAME} s3://${BUCKET_NAME}
