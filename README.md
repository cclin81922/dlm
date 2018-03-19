# Usage

```
bash test.sh nodlm

go get -u github.com/zieckey/etcdsync
bash test.sh etcd

go get -u github.com/fzzy/radix/redis
go get -u github.com/amyangfei/redlock-go
bash test.sh redis

go get -u github.com/hashicorp/consul/api
bash test.sh consul

```

Sample output of `bash test.sh nodlm; bash test.sh etcd; bash test.sh redis; bash test.sh consul`

```
/Users/cclin/go/src/github.com/cclin81922/dlm
Expected 100
Wait for 30 seconds
Result: 89
9595556da8e93a52648eb2a82ff6bd25be30d7ee1ea71d5a8f90948c546b8b14
/Users/cclin/go/src/github.com/cclin81922/dlm
Expected 100
Wait for 30 seconds
Result: 100
etcd-dev
aac03382b4b3745a537bb7f5974ba83c4df12acf9e99bb716573ae7e4a620306
/Users/cclin/go/src/github.com/cclin81922/dlm
Expected 100
Wait for 30 seconds
Result: 100
redis-dev
ea703efc6db66c1eee1ec4ce27da3a4b11f91bc508ba1972d3f12ff46776ed03
/Users/cclin/go/src/github.com/cclin81922/dlm
Expected 100
Wait for 30 seconds
Result: 100
consul-dev
```


# Acknowledge 1

etcd version is powered by https://github.com/zieckey/etcdsync

# Acknowledge 2

redis version is powered by https://github.com/amyangfei/redlock-go

# Acknowledge 3

consul version is powered by https://distributedbydefault.com/distributed-locks-with-consul-and-golang-c4eccc217dd5

# Related resources

* etcd version https://github.com/jagregory/locker
* redis version https://github.com/go-redsync/redsync
* redis version https://github.com/bsm/redis-lock (x)
