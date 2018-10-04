docker build -t daern91/multi-client:latest -t daern91/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t daern91/multi-server:latest -t daern91/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t daern91/multi-worker:latest -t daern91/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push daern91/multi-client:latest
docker push daern91/multi-server:latest
docker push daern91/multi-worker:latest

docker push daern91/multi-client:$GIT_SHA
docker push daern91/multi-server:$GIT_SHA
docker push daern91/multi-worker:$GIT_SHA

kubectl apply -f k8s/
kubectl set image deployments/client-deplyment client=daern91/multi-client:$GIT_SHA
kubectl set image deployments/server-deplyment server=daern91/multi-server:$GIT_SHA
kubectl set image deployments/worker-deplyment worker=daern91/multi-worker:$GIT_SHA