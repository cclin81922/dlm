# Usage

```
bash test.sh nodlm

go get -u github.com/zieckey/etcdsync
docker pull quay.io/coreos/etcd:v3.0.17
bash test.sh etcd

go get -u github.com/fzzy/radix/redis
go get -u github.com/amyangfei/redlock-go
docker pull redis:4.0.8
bash test.sh redis

go get -u github.com/hashicorp/consul/api
docker pull consul:1.0.6
bash test.sh consul

```

Sample output of `export N=15; bash test.sh nodlm; bash test.sh etcd; bash test.sh redis; bash test.sh consul`

```

***** [ case :: no dlm ] *****

INFO |  Mon Mar 19 20:45:31 CST 2018 | Launching

real	0m0.335s
user	0m0.044s
sys	0m0.055s

INFO | Mon Mar 19 20:45:32 CST 2018 | Waiting

real	0m14.370s
user	0m0.138s
sys	0m0.145s

INFO | Mon Mar 19 20:45:46 CST 2018 | Finished

Expect 15
Result 12

***** [ case :: with redis dlm ] *****

INFO | Mon Mar 19 20:45:47 CST 2018 | Launching

real	0m0.315s
user	0m0.041s
sys	0m0.042s

INFO | Mon Mar 19 20:45:48 CST 2018 | Waiting

real	0m14.370s
user	0m0.141s
sys	0m0.146s

INFO | Mon Mar 19 20:46:02 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with consul dlm ] *****

INFO | Mon Mar 19 20:46:04 CST 2018 | Launching

real	0m0.579s
user	0m0.043s
sys	0m0.045s

INFO | Mon Mar 19 20:46:05 CST 2018 | Waiting

real	0m17.490s
user	0m0.177s
sys	0m0.187s

INFO | Mon Mar 19 20:46:22 CST 2018 | Finished

Expect 15
Result 15
```

# Acknowledge 1

etcd version is powered by https://github.com/zieckey/etcdsync

# Acknowledge 2

redis version is powered by https://github.com/amyangfei/redlock-go

# Acknowledge 3

consul version is powered by https://distributedbydefault.com/distributed-locks-with-consul-and-golang-c4eccc217dd5

# Related resources

* redlock https://redis.io/topics/distlock
* against redlock https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html
