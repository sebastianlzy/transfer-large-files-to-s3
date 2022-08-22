# transfer-large-files-to-s3

## Objective
1. To understand the use of different parameters in order to maximize transfer speed

## Constrains
1. We are transferring file from EC2 to S3 via S3 VPC gateway endpoint 
2. Bandwidth limit is set at 1000Gbps

## Summary

|         | 1 x 10GB  | 20 x 20 GB | 
|---------|-----------|------------|
| AWS CLI | 1.6 Gbps  | 5.4 Gbps   |
| S5 CMD  | 2.16 Gbps | 19.75 Gbps |



## With AWS CLI

### M5.large (4vCPU) - Transferring 1 x 10G file

**Default S3 configuration**

```
aws configure set default.s3.max_concurrent_requests 10
aws configure set default.s3.multipart_chunksize 8MB
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp ./bin/10G_image_file_size_1661141928.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661141928.jpg to s3://transfer-large-file-size/10G_image_file_size_1661141928.jpg

real    1m12.621s
user    1m15.408s
sys     1m4.615s

```

Data transfer = 10GB = 80Gb
Time lapse = 72 seconds
Real transfer speed = 80/72 = **1.11 Gbps**

**with diff configurations**

```
aws configure set default.s3.max_concurrent_requests 50
aws configure set default.s3.multipart_chunksize 10MB
npm run transfer:large-file

> transfer-large-files-to-s3@1.0.0 transfer:large-file
> . ./transfer-large-file-size.sh

time aws s3 cp ./bin/10G_image_file_size_1661141928.jpg s3://transfer-large-file-size
upload: bin/10G_image_file_size_1661141928.jpg to s3://transfer-large-file-size/10G_image_file_size_1661141928.jpg

real    2m22.707s
user    1m17.685s
sys     1m2.662s

```

Data transfer = 10GB = 80Gb
Time lapse = 142 seconds
Real transfer speed = 80/142 = **0.56 Gbps**


### M5.24xlarge (96vCPU) - Transferring 1 x 10G file

**Default S3 configuration**

```
aws configure set default.s3.max_concurrent_requests 10
aws configure set default.s3.multipart_chunksize 8MB
npm run transfer:large-file

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
Real transfer speed = 80/58 = **1.38 Gbps**

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
Real transfer speed = 80/85 = **0.94 Gbps**

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
Real transfer speed = 80/50 = **1.6 Gbps**

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
Real transfer speed = 80/89 = **0.89 Gbps**

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
Real transfer speed = 80/53 = **1.5 Gbps**

### M5.24xlarge (96vCPU) - Transferring 20 x 10G files concurrently

```
aws configure set default.s3.max_concurrent_requests 50
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder

real    5m36.681s
user    32m40.648s
sys     23m17.732s

```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 336s
Real transfer speed = 1600/336 = **4.7Gbps**

```
aws configure set default.s3.max_concurrent_requests 1000
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder

real    10m21.931s
user    22m41.160s
sys     12m59.069s

```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 294
Real transfer speed = 1600/294 = **5.4Gbps** 

```
aws configure set default.s3.max_concurrent_requests 1000
aws configure set default.s3.multipart_chunksize 100MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder
```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 621
Real transfer speed = 1600/621 = **2.57Gbps**

```
aws configure set default.s3.max_concurrent_requests 100
aws configure set default.s3.multipart_chunksize 1000MB
aws configure get default.s3.multipart_chunksize
aws configure get default.s3.max_concurrent_requests
npm run transfer:large-folder

real    14m18.611s
user    20m46.837s
sys     11m22.615s

```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 858
Real transfer speed = 1600/858 = **1.86Gbps**

## M5.24xlarge (96vCPU) - With S5cmd

**1 x 10 GB file**

```
real    0m37.996s
user    0m0.050s
sys     0m0.019s
```

Data transfer = 1 * 10GB = 80 Gb
Time lapse = 37
Real transfer speed = 80/37 = **2.16 Gbps**

**20 x 10GB files**

```
real    1m21.955s
user    0m0.032s
sys     0m0.056s
```

Data transfer = 20 * 10GB = 1600Gb
Time lapse = 81
Real transfer speed = 1600/81 = **19.75 Gbps**


## FAQ

### What is the difference between real, user and sys ?

Real is wall clock time - time from start to finish of the call. This is all elapsed time including time slices used by other processes and time the process spends blocked (for example if it is waiting for I/O to complete).

User is the amount of CPU time spent in user-mode code (outside the kernel) within the process. This is only actual CPU time used in executing the process. Other processes and time the process spends blocked do not count towards this figure.

Sys is the amount of CPU time spent in the kernel within the process. This means executing CPU time spent in system calls within the kernel, as opposed to library code, which is still running in user-space. Like 'user', this is only CPU time used by the process. See below for a brief description of kernel mode (also known as 'supervisor' mode) and the system call mechanism.


### What is the maximum transfer speed between EC2 and S3?

100 Gbps bandwidth

https://aws.amazon.com/premiumsupport/knowledge-center/s3-maximum-transfer-speed-ec2/#:%7E:text=Traffic%20between%20Amazon%20EC2%20and,IPs%20in%20the%20same%20Region

### How can I improve the transfer speeds for copying data between my S3 bucket and EC2 instance?

https://aws.amazon.com/premiumsupport/knowledge-center/s3-transfer-data-bucket-instance/

### Why is s5cmd faster?

1. Written in a high-performance, concurrent language, Go, instead of Python. This means the application can take better advantage of multiple threads and is faster to run because it is compiled and not interpreted.
2. Better utilization of multiple tcp connections to transfer more data to and from the object store, resulting in higher throughput transfers.

**References**
1. https://joshua-robinson.medium.com/s5cmd-for-high-performance-object-storage-7071352cc09d
2. https://aws.amazon.com/blogs/opensource/parallelizing-s3-workloads-s5cmd/
3. https://github.com/dvassallo/s3-benchmark