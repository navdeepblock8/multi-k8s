docker build -t navdeepduvedi/multi-client:latest -t navdeepduvedi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t navdeepduvedi/multi-server:latest -t navdeepduvedi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t navdeepduvedi/multi-worker:latest -t navdeepduvedi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push navdeepduvedi/multi-client:latest 
docker push navdeepduvedi/multi-server:latest
docker push navdeepduvedi/multi-worker:latest

docker push navdeepduvedi/multi-client:$SHA
docker push navdeepduvedi/multi-server:$SHA
docker push navdeepduvedi/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployments/server-deployment server=navdeepduvedi/multi-server:$SHA
kubectl set image deployments/client-deployment client=navdeepduvedi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=navdeepduvedi/multi-worker:$SHA