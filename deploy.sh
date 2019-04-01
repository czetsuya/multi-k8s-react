docker build -t czetsuya/multi-docker-react-client:latest -t czetsuya/multi-docker-react-client:$SHA -f ./client/Dockerfile ./client
docker build -t czetsuya/multi-docker-react-server:latest -t czetsuya/multi-docker-react-server:$SHA -f ./server/Dockerfile ./server
docker build -t czetsuya/multi-docker-react-worker:latest -t czetsuya/multi-docker-react-worker:$SHA -f ./worker/Dockerfile ./worker

docker push czetsuya/multi-docker-react-client:latest
docker push czetsuya/multi-docker-react-server:latest
docker push czetsuya/multi-docker-react-worker:latest

docker push czetsuya/multi-docker-react-client:$SHA
docker push czetsuya/multi-docker-react-server:$SHA
docker push czetsuya/multi-docker-react-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=czetsuya/multi-docker-react-server:$SHA
kubectl set image deployments/client-deployment client=czetsuya/multi-docker-react-client:$SHA
kubectl set image deployments/worker-deployment worker=czetsuya/multi-docker-react-worker:$SHA
