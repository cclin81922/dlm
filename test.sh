#!/bin/bash

set -eu
set -o pipefail

function _wait() {
    while [ $(screen -ls | grep process | wc -l) -gt 0 ]
    do
        sleep 1
    done
}

# [ case 1 :: without-dlm ]
function nodlm() {
    echo "INFO | $(date)"
    cp data/counter-init.txt data/counter.txt
    cd without-dlm
    for i in `seq 1 100`; do screen -dmS process_$i go run main.go; done
    cd -
    echo "INFO | $(date)"
    
    echo Expected 100
    echo Wait for seconds
    _wait
    echo -n "Result: "
    cat data/counter.txt
    echo
    echo "INFO | $(date)"
}

# [ case 2 :: with-dlm :: etcd ]
function etcd() {
    docker run \
      --rm -d \
      -p 2379:2379 \
      -p 2380:2380 \
      --name etcd-dev quay.io/coreos/etcd:v3.0.17 \
      /usr/local/bin/etcd \
      --data-dir=/etcd-data --name node1 \
      --initial-advertise-peer-urls http://127.0.0.1:2380 --listen-peer-urls http://0.0.0.0:2380 \
      --advertise-client-urls http://127.0.0.1:2379 --listen-client-urls http://0.0.0.0:2379 \
      --initial-cluster node1=http://127.0.0.1:2380
    
    echo "INFO | $(date)"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/etcd
    for i in `seq 1 100`; do screen -dmS process_$i go run main.go; done
    cd -
    echo "INFO | $(date)"
    
    echo Expected 100
    echo Wait for seconds
    _wait
    echo -n "Result: "
    cat data/counter.txt
    echo
    echo "INFO | $(date)"
    
    docker stop etcd-dev
}

# [ case 3 :: with-dlm :: redis ]
function redis() {
    docker run \
      --rm -d \
      -p 6379:6379 \
      --name redis-dev redis:4.0.8
    
    echo "INFO | $(date)"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/redis
    for i in `seq 1 100`; do screen -dmS process_$i go run main.go; done
    cd -
    echo "INFO | $(date)"
    
    echo Expected 100
    echo Wait for seconds
    _wait
    echo -n "Result: "
    cat data/counter.txt
    echo
    echo "INFO | $(date)"
    
    docker stop redis-dev
}

# case 4 :: with-dlm :: consul

function consul() {
    docker run \
      --rm -d \
      -p 8500:8500 \
      -e CONSUL_BIND_INTERFACE=eth0 \
      --name consul-dev consul:1.0.6

    echo "INFO | $(date)"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/consul
    for i in `seq 1 100`; do screen -dmS process_$i go run main.go; done
    cd -
    echo "INFO | $(date)"
    
    echo Expected 100
    echo Wait for seconds
    _wait
    echo -n "Result: "
    cat data/counter.txt
    echo
    echo "INFO | $(date)"

    docker stop consul-dev
}

$1
