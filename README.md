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

go get -u github.com/samuel/go-zookeeper/zk
go get -u github.com/nladuo/go-zk-lock
docker pull zookeeper:3.4.11
bash test.sh zookeeper
```

Sample output of `export N=15; bash test.sh nodlm; bash test.sh etcd; bash test.sh redis; bash test.sh consul`

```

***** [ case :: no dlm ] *****

INFO |  Mon Mar 19 20:51:05 CST 2018 | Launching

real    0m0.397s
user    0m0.047s
sys 0m0.059s

INFO | Mon Mar 19 20:51:06 CST 2018 | Waiting

real    0m13.562s
user    0m0.152s
sys 0m0.148s

INFO | Mon Mar 19 20:51:19 CST 2018 | Finished

Expect 15
Result 14

***** [ case :: with etcd dlm ] *****

INFO | Mon Mar 19 20:51:21 CST 2018 | Launching

real    0m0.306s
user    0m0.042s
sys 0m0.043s

INFO | Mon Mar 19 20:51:21 CST 2018 | Waiting

real    0m24.787s
user    0m0.226s
sys 0m0.252s

INFO | Mon Mar 19 20:51:46 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with redis dlm ] *****

INFO | Mon Mar 19 20:51:48 CST 2018 | Launching

real    0m0.274s
user    0m0.043s
sys 0m0.043s

INFO | Mon Mar 19 20:51:49 CST 2018 | Waiting

real    0m12.778s
user    0m0.133s
sys 0m0.124s

INFO | Mon Mar 19 20:52:01 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with consul dlm ] *****

INFO | Mon Mar 19 20:52:03 CST 2018 | Launching

real    0m0.352s
user    0m0.044s
sys 0m0.045s

INFO | Mon Mar 19 20:52:03 CST 2018 | Waiting

real    0m14.702s
user    0m0.146s
sys 0m0.141s

INFO | Mon Mar 19 20:52:18 CST 2018 | Finished

Expect 15
Result 15
```

# Acknowledge 1

etcd version is powered by https://github.com/zieckey/etcdsync

# Acknowledge 2

redis version is powered by https://github.com/amyangfei/redlock-go

# Acknowledge 3

consul version is powered by https://distributedbydefault.com/distributed-locks-with-consul-and-golang-c4eccc217dd5

# Acknowlede 4

zookeeper version is powered by https://github.com/nladuo/go-zk-lock

# Related resources

* redlock https://redis.io/topics/distlock
* against redlock https://martin.kleppmann.com/2016/02/08/how-to-do-distributed-locking.html
