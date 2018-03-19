package main

import (
	"io/ioutil"
	"log"
	"strconv"
	"time"
    "github.com/zieckey/etcdsync"
)

func main() {
	time.Sleep(10000 * time.Millisecond)

    // DLM
    m, _ := etcdsync.New("/mylock", 10, []string{"http://127.0.0.1:2379"})
    m.Lock()

    //
	ov, _ := ioutil.ReadFile("../../data/counter.txt")

	ov_int, _ := strconv.Atoi(string(ov))

	nv_int := ov_int + 1

	nv := strconv.Itoa(nv_int)

	log.Printf("new value: %s\n", nv)

	ioutil.WriteFile("../../data/counter.txt", []byte(nv), 0644)
    //

    m.Unlock()
    // End of DLM

	log.Println("End")
}
