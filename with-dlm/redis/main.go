package main

import (
	"io/ioutil"
	"log"
	"strconv"
	"time"
    "github.com/bsm/redis-lock"
    "github.com/go-redis/redis"
)

func main() {
	time.Sleep(10000 * time.Millisecond)

    // DLM
    client := redis.NewClient(&redis.Options{
        Network:    "tcp",
        Addr:       "127.0.0.1:6379",
    })
    lock, _ := lock.Obtain(client, "lock.foo", nil)

    //
	ov, _ := ioutil.ReadFile("../../data/counter.txt")

	ov_int, _ := strconv.Atoi(string(ov))

	nv_int := ov_int + 1

	nv := strconv.Itoa(nv_int)

	log.Printf("new value: %s\n", nv)

	ioutil.WriteFile("../../data/counter.txt", []byte(nv), 0644)
    //

    lock.Unlock()
    client.Close()
    // End of DLM

	log.Println("End")
}
