docker build -t khjomaa/multi-client:latest -t khjomaa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t khjomaa/multi-server:latest -t khjomaa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t khjomaa/multi-worker:latest -t khjomaa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push khjomaa/multi-client:latest
docker push khjomaa/multi-server:latest
docker push khjomaa/multi-worker:latest

docker push khjomaa/multi-client:$SHA
docker push khjomaa/multi-server:$SHA
docker push khjomaa/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=khjomaa/multi-server:$SHA
kubectl set image deployments/client-deployment client=khjomaa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=khjomaa/multi-worker:$SHA