docker build -t momir81/multi-client:latest -t momir81/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t momir81/multi-server:latest -t momir81/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t momir81/multi-worker:latest -t momir81/multi-worker:$SHA -f ./worker/Dockerfile ./workers

docker push momir81/multi-client:latest
docker push momir81/multi-server:latest
docker push momir81/multi-worker:latest

docker push momir81/multi-client:$SHA
docker push momir81/multi-server:$SHA
docker push momir81/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=momir81/multi-client:$SHA
kubectl set image deployments/server-deployment server=momir81/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=momir81/multi-worker:$SHA