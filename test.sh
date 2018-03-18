#!/bin/bash

cp data/counter-init.txt data/counter.txt
for i in `seq 1 100`; do screen -dmS process_$i go run main.go; done

echo Expected 100
echo Wait for 15 seconds
sleep 15
echo -n "Result: "
cat data/counter.txt
