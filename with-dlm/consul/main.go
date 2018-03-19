package main

import (
	"io/ioutil"
	"log"
	"strconv"
	"time"
    "github.com/hashicorp/consul/api"
)

func main() {
	time.Sleep(10000 * time.Millisecond)

    // DLM
    client, _ := api.NewClient(&api.Config{Address: "127.0.0.1:8500"})
    lock, _ := client.LockKey("webhook_receiver/1")
    stopCh := make(chan struct{})
    lock.Lock(stopCh)

    //
	ov, _ := ioutil.ReadFile("../../data/counter.txt")

	ov_int, _ := strconv.Atoi(string(ov))

	nv_int := ov_int + 1

	nv := strconv.Itoa(nv_int)

	log.Printf("new value: %s\n", nv)

	ioutil.WriteFile("../../data/counter.txt", []byte(nv), 0644)
    //

    lock.Unlock()
    // End of DLM

	log.Println("End")
}
