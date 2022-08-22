# transfer-large-files-to-s3

## Objective
1. To understand the use of different parameters in order to maximize transfer speed

## Constrains
1. We are transferring file from EC2 to S3 via S3 VPC gateway endpoint 
2. Bandwidth limit is set at 1000Gbps

## With AWS CLI

### M5.large (4vCPU)

#### Single S3 file transfer





### M5.24xlarge (96vCPU)

**Default S3 configuration**

```
aws configure set default.s3.max_concurrent_requests 10
aws configure set default.s3.multipart_chunksize 8MB
```

```
> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp bin/10G_image_file_size_1661139028.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661139028.jpg to s3://transfer-large-file-size/10G_image_file_size_1661139028.jpg

real    0m58.259s
user    0m55.519s
sys     0m32.133s
```

Data transfer = 10GB = 80Gb
Time lapse = 58 seconds
Real transfer speed = 80/58 = 1.38 Gbps

**with diff configurations**

```
aws configure set default.s3.max_concurrent_requests 30
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp bin/10G_image_file_size_1661139028.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661139028.jpg to s3://transfer-large-file-size/10G_image_file_size_1661139028.jpg

real    1m47.526s
user    2m17.264s
sys     1m29.630s
```

Data transfer = 10GB = 80Gb
Time lapse = 85 seconds
Real transfer speed = 80/85 = 0.94 Gbps

```
aws configure set default.s3.max_concurrent_requests 50
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp bin/10G_image_file_size_1661139028.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661139028.jpg to s3://transfer-large-file-size/10G_image_file_size_1661139028.jpg

real    0m50.222s
user    1m8.638s
sys     0m45.625s

```

Data transfer = 10GB = 80Gb
Time lapse = 50 seconds
Real transfer speed = 80/50 = 1.6 Gbps

```
aws configure set default.s3.max_concurrent_requests 100
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp bin/10G_image_file_size_1661139028.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661139028.jpg to s3://transfer-large-file-size/10G_image_file_size_1661139028.jpg

real    1m29.507s
user    2m16.783s
sys     1m31.479s

```

Data transfer = 10GB = 80Gb
Time lapse = 89 seconds
Real transfer speed = 80/89 = 0.89 Gbps

```
aws configure set default.s3.max_concurrent_requests 50
aws configure set default.s3.multipart_chunksize 200MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp bin/10G_image_file_size_1661139028.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661139028.jpg to s3://transfer-large-file-size/10G_image_file_size_1661139028.jpg

real    0m53.104s
user    1m12.826s
sys     0m47.690s
```

Data transfer = 10GB = 80Gb
Time lapse = 53 seconds
Real transfer speed = 80/53 = 1.5 Gbps

**Transferring 20 10G file concurrently**

```
aws configure set default.s3.max_concurrent_requests 50
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder



```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 
Real transfer speed = 1600/ = 

```
aws configure set default.s3.max_concurrent_requests 10
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder

```

Data transfer = 20 * 10GB = 1600Gb
Time lapse =
Real transfer speed = 1600/ =


## With S5cmd



## FAQ

### What is the difference between real, user and sys ?

Real is wall clock time - time from start to finish of the call. This is all elapsed time including time slices used by other processes and time the process spends blocked (for example if it is waiting for I/O to complete).

User is the amount of CPU time spent in user-mode code (outside the kernel) within the process. This is only actual CPU time used in executing the process. Other processes and time the process spends blocked do not count towards this figure.

Sys is the amount of CPU time spent in the kernel within the process. This means executing CPU time spent in system calls within the kernel, as opposed to library code, which is still running in user-space. Like 'user', this is only CPU time used by the process. See below for a brief description of kernel mode (also known as 'supervisor' mode) and the system call mechanism.