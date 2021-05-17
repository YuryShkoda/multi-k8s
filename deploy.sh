docker build -t yuryshkoda/multi-client:latest -t yuryshkoda/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t yuryshkoda/multi-server:latest -t yuryshkoda/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t yuryshkoda/multi-worker:latest -t yuryshkoda/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push yuryshkoda/multi-client:latest
docker push yuryshkoda/multi-server:latest
docker push yuryshkoda/multi-worker:latest

docker push yuryshkoda/multi-client:$SHA
docker push yuryshkoda/multi-server:$SHA
docker push yuryshkoda/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yuryshkoda/multi-server:$SHA
kubectl set image deployments/client-deployment client=yuryshkoda/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yuryshkoda/multi-worker:$SHA