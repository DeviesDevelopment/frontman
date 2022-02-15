#!/bin/bash

docker-compose up --detach
cp servers.json ../servers.json
cd ..
make start

A_RESPONSE=$(curl localhost:80/test-a --header "Host: service-a.com" --fail --silent)
echo "Response: $A_RESPONSE"
if [ "$A_RESPONSE" = "Hello from A" ]
then
  echo "Test passed!"
else
  echo "Test failed"
  exit 1
fi

B_RESPONSE=$(curl localhost:80/test-b --header "Host: service-b.com" --fail --silent)
echo "Response: $B_RESPONSE"
if [ "$B_RESPONSE" = "Hello from B" ]
then
  echo "Test passed!"
else
  echo "Test failed"
  exit 1
fi
