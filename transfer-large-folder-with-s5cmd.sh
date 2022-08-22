#!/usr/bin/env bash
echo "time docker run --rm -v $(pwd):/aws -v ~/.aws:/root/.aws peakcom/s5cmd --stat --numworkers 512 cp ./bin/ s3://transfer-large-file-size"
time docker run --rm -v $(pwd):/aws -v ~/.aws:/root/.aws peakcom/s5cmd --stat --numworkers 512 cp ./bin/ s3://transfer-large-file-size