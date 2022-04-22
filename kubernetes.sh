#!/bin/bash

#kubectl delete pods --all 
#kubectl delete deployments --all



kubectl delete all --all

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml

# cd backend
# sleep 15
# kubectl apply -f backend-depl.yaml
# cd ..

kubectl create secret generic jwt-secret --from-literal=JWT_SECRET=majorprojectsecret
kubectl create secret generic jwt-expiration-time --from-literal=JWT_EXPIRATION_TIME=7d
kubectl create secret generic jwt-access-token-secret --from-literal=JWT_ACCESS_TOKEN_SECRET=majorprojectsecret
kubectl create secret generic jwt-access-token-expiration-time --from-literal=JWT_ACCESS_TOKEN_EXPIRATION_TIME=1h
kubectl create secret generic jwt-refresh-token-secret --from-literal=JWT_REFRESH_TOKEN_SECRET=majorprojectsecret
kubectl create secret generic jwt-refresh-token-expiration-time --from-literal=JWT_REFRESH_TOKEN_EXPIRATION_TIME=7d
kubectl create secret generic admin-email --from-literal=ADMIN_EMAIL=admin@sky-ecommerce.com
kubectl create secret generic admin-password --from-literal=ADMIN_PASSWORD=SKY@1234

cd infra/k8s

kubectl apply -f auth-mongo.yaml
kubectl apply -f auth.yaml

kubectl apply -f products-mongo.yaml
kubectl apply -f products.yaml

kubectl apply -f orders-mongo.yaml
kubectl apply -f orders.yaml

kubectl apply -f client.yaml



kubectl apply -f ingress-srv.yaml
sleep 5
kubectl apply -f ingress-srv.yaml
sleep 15
kubectl apply -f ingress-srv.yaml
sleep 25
kubectl apply -f ingress-srv.yaml

export theIPaddress=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

kubectl patch svc ingress-nginx-controller   -n ingress-nginx -p '{"spec": {"type": "LoadBalancer", "externalIPs":["'"$theIPaddress"'"]}}'


#kubectl get ingress
#kubectl describe ingress
#kubectl describe svc ingress-nginx-controller -n ingress-nginx

#https://stackoverflow.com/questions/44110876/kubernetes-service-external-ip-pending
