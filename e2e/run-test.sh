#!/bin/bash

docker-compose up --detach
cp servers.json ../servers.json
cd ..
make start

# Try to reach service A endpoint in service A
echo "Running Service A Test"
A_RESPONSE=$(curl localhost:80/test-a --header "Host: service-a.com" --fail --silent)
echo "Response from Service A: $A_RESPONSE"
if [ "$A_RESPONSE" = "Hello from A" ]
then
  echo "Test passed!"
else
  echo "Test failed"
  exit 1
fi

# Try to reach service B endpoint in service B
echo "Running Service B Test"
B_RESPONSE=$(curl localhost:80/test-b --header "Host: service-b.com" --fail --silent)
echo "Response from Service B: $B_RESPONSE"
if [ "$B_RESPONSE" = "Hello from B" ]
then
  echo "Test passed!"
else
  echo "Test failed"
  exit 1
fi

# Try to reach service A endpoint in service B, should return 404.
echo "Running Negative Test"
NEGATIVE_RESPONSE_CODE=$(curl --write-out '%{http_code}' localhost:80/test-b --header "Host: service-a.com" --fail --silent)
if [ "$NEGATIVE_RESPONSE_CODE" = 404 ]
then
  echo "Test passed!"
else
  echo "Test failed"
  exit 1
fi