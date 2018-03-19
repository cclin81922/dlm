package main

import (
	"io/ioutil"
	"log"
	"strconv"
	"time"
    "github.com/nladuo/go-zk-lock"
)

func main() {
	time.Sleep(10000 * time.Millisecond)

    // DLM
    var (
        hosts         []string      = []string{"127.0.0.1:2181"} // the zookeeper hosts
        basePath      string        = "/locker"                  //the application znode path
        lockerTimeout time.Duration = 1 * time.Minute            // the maximum time for a locker waiting
        zkTimeOut     time.Duration = 20 * time.Second           // the zk connection timeout
    )
    DLocker.EstablishZkConn(hosts, zkTimeOut)
    locker := DLocker.NewLocker(basePath, lockerTimeout)
    locker.Lock()

    //
	ov, _ := ioutil.ReadFile("../../data/counter.txt")

	ov_int, _ := strconv.Atoi(string(ov))

	nv_int := ov_int + 1

	nv := strconv.Itoa(nv_int)

	log.Printf("new value: %s\n", nv)

	ioutil.WriteFile("../../data/counter.txt", []byte(nv), 0644)
    //

    locker.Unlock()
    DLocker.CloseZkConn()
    // End of DLM

	log.Println("End")
}
