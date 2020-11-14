docker build -t yxlee245/multi-client:latest -t yxlee245/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yxlee245/multi-server:latest -t yxlee245/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yxlee245/multi-worker:latest -t yxlee245/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yxlee245/multi-client:latest
docker push yxlee245/multi-server:latest
docker push yxlee245/multi-worker:latest

docker push yxlee245/multi-client:$SHA
docker push yxlee245/multi-server:$SHA
docker push yxlee245/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yxlee245/multi-server:$SHA
kubectl set image deployments/client-deployment client=yxlee245/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yxlee245/multi-worker:$SHA