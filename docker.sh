#!/bin/bash

docker login -u 9398320218 -p Sai@12345


cd auth
docker build -t 9398320218/mp_auth .
docker push 9398320218/mp_auth
cd ..


cd products
docker build -t 9398320218/mp_products .
docker push 9398320218/mp_products
cd ..


cd orders
docker build -t 9398320218/mp_orders .
docker push 9398320218/mp_orders
cd ..


cd client
docker build -t 9398320218/mp_client .
docker push 9398320218/mp_client
cd ..