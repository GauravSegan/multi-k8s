docker build -t drumster88/multi-client:latest -t drumster88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t drumster88/multi-server:latest -t drumster88/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t drumster88/multi-worker:latest -t drumster88/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push drumster88/multi-client:latest
docker push drumster88/multi-server:latest
docker push drumster88/multi-worker:latest

docker push drumster88/multi-client:$SHA
docker push drumster88/multi-server:$SHA
docker push drumster88/multi-worker:$SHA
## can use same kubectl command here since kubectl is already configured in GCP in .travis

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=drumster88/multi-server:$SHA
kubectl set image deployments/client-deployment client=drumster88/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=drumster88/multi-worker:$SHA