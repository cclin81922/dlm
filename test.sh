#!/bin/bash

set -eu
set -o pipefail

N=${N:-10}

function _wait() {
    while [ $(screen -ls | grep process | wc -l) -gt 0 ]
    do
        sleep 1
    done
}

function _launch() {
    for i in `seq 1 $N`; do screen -dmS process_$i go run main.go; done
}

# [ case 1 :: without-dlm ]
function nodlm() {
    echo
    echo "***** [ case :: no dlm ] *****"
    echo

    echo "INFO |  $(date) | Launching"
    cp data/counter-init.txt data/counter.txt
    cd without-dlm
    time _launch
    cd - > /dev/null
    echo

    echo "INFO | $(date) | Waiting"    
    time _wait
    echo

    echo "INFO | $(date) | Finished"
    echo
    echo Expect $N
    echo -n "Result "
    cat data/counter.txt
    echo
}

# [ case 2 :: with-dlm :: etcd ]
function etcd() {
    echo
    echo "***** [ case :: with etcd dlm ] *****"
    echo

    docker run \
      --rm -d \
      -p 2379:2379 \
      -p 2380:2380 \
      --name etcd-dev quay.io/coreos/etcd:v3.0.17 \
      /usr/local/bin/etcd \
      --data-dir=/etcd-data --name node1 \
      --initial-advertise-peer-urls http://127.0.0.1:2380 --listen-peer-urls http://0.0.0.0:2380 \
      --advertise-client-urls http://127.0.0.1:2379 --listen-client-urls http://0.0.0.0:2379 \
      --initial-cluster node1=http://127.0.0.1:2380 > /dev/null
    
    echo "INFO | $(date) | Launching"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/etcd
    time _launch
    cd - > /dev/null
    echo

    echo "INFO | $(date) | Waiting"    
    time _wait
    echo

    echo "INFO | $(date) | Finished"
    echo
    echo Expect $N
    echo -n "Result "
    cat data/counter.txt
    echo
    
    docker stop etcd-dev > /dev/null
}

# [ case 3 :: with-dlm :: redis ]
function redis() {
    echo
    echo "***** [ case :: with redis dlm ] *****"
    echo

    docker run \
      --rm -d \
      -p 6379:6379 \
      --name redis-dev redis:4.0.8 > /dev/null
    
    echo "INFO | $(date) | Launching"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/redis
    time _launch
    cd - > /dev/null
    echo

    echo "INFO | $(date) | Waiting"    
    time _wait
    echo

    echo "INFO | $(date) | Finished"
    echo
    echo Expect $N
    echo -n "Result "
    cat data/counter.txt
    echo
    
    docker stop redis-dev > /dev/null
}

# case 4 :: with-dlm :: consul

function consul() {
    echo
    echo "***** [ case :: with consul dlm ] *****"
    echo

    docker run \
      --rm -d \
      -p 8500:8500 \
      -e CONSUL_BIND_INTERFACE=eth0 \
      --name consul-dev consul:1.0.6 > /dev/null

    echo "INFO | $(date) | Launching"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/consul
    time _launch
    cd - > /dev/null
    echo

    echo "INFO | $(date) | Waiting"    
    time _wait
    echo

    echo "INFO | $(date) | Finished"
    echo
    echo Expect $N
    echo -n "Result "
    cat data/counter.txt
    echo

    docker stop consul-dev > /dev/null
}

# case 5 :: with-dlm :: zookeeper

function zookeeper() {
    echo
    echo "***** [ case :: with zookeeper dlm ] *****"
    echo

    docker run \
      --rm -d \
      -p 2181:2181 \
      -p 2888:2888 \
      -p 3888:3888 \
      --name zookeeper-dev zookeeper:3.4.11 > /dev/null

    echo "INFO | $(date) | Launching"
    cp data/counter-init.txt data/counter.txt
    cd with-dlm/zookeeper
    time _launch
    cd - > /dev/null
    echo

    echo "INFO | $(date) | Waiting"    
    time _wait
    echo

    echo "INFO | $(date) | Finished"
    echo
    echo Expect $N
    echo -n "Result "
    cat data/counter.txt
    echo

    docker stop zookeeper-dev > /dev/null
}

$1
