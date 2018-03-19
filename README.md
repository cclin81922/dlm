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

Sample output of `export N=15; bash test.sh nodlm; bash test.sh etcd; bash test.sh redis; bash test.sh consul; bash test.sh zookeeper`

```

***** [ case :: no dlm ] *****

INFO |  Mon Mar 19 22:43:53 CST 2018 | Launching

real    0m0.314s
user    0m0.043s
sys 0m0.044s

INFO | Mon Mar 19 22:43:53 CST 2018 | Waiting

real    0m12.324s
user    0m0.138s
sys 0m0.132s

INFO | Mon Mar 19 22:44:06 CST 2018 | Finished

Expect 15
Result 14

***** [ case :: with etcd dlm ] *****

INFO | Mon Mar 19 22:44:07 CST 2018 | Launching

real    0m0.440s
user    0m0.042s
sys 0m0.042s

INFO | Mon Mar 19 22:44:07 CST 2018 | Waiting

real    0m20.899s
user    0m0.191s
sys 0m0.205s

INFO | Mon Mar 19 22:44:28 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with redis dlm ] *****

INFO | Mon Mar 19 22:44:30 CST 2018 | Launching

real    0m0.294s
user    0m0.042s
sys 0m0.044s

INFO | Mon Mar 19 22:44:30 CST 2018 | Waiting

real    0m13.322s
user    0m0.146s
sys 0m0.132s

INFO | Mon Mar 19 22:44:44 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with consul dlm ] *****

INFO | Mon Mar 19 22:44:45 CST 2018 | Launching

real    0m0.339s
user    0m0.042s
sys 0m0.042s

INFO | Mon Mar 19 22:44:46 CST 2018 | Waiting

real    0m19.425s
user    0m0.199s
sys 0m0.179s

INFO | Mon Mar 19 22:45:05 CST 2018 | Finished

Expect 15
Result 15

***** [ case :: with zookeeper dlm ] *****

INFO | Mon Mar 19 22:45:07 CST 2018 | Launching

real    0m0.320s
user    0m0.042s
sys 0m0.042s

INFO | Mon Mar 19 22:45:07 CST 2018 | Waiting

real    0m13.341s
user    0m0.143s
sys 0m0.132s

INFO | Mon Mar 19 22:45:21 CST 2018 | Finished

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
