docker build -t entropyscourge/multi-client-k8s:latest -t entropyscourge/multi-client-k8s:$GITHUB_SHA -f ./client/Dockerfile ./client
docker build -t entropyscourge/multi-server-k8s:latest -t entropyscourge/multi-server-k8s:$GITHUB_SHA -f ./server/Dockerfile ./server
docker build -t entropyscourge/multi-worker-k8s:latest -t entropyscourge/multi-worker-k8s:$GITHUB_SHA -f ./worker/Dockerfile ./worker

docker push entropyscourge/multi-client-k8s:latest
docker push entropyscourge/multi-server-k8s:latest
docker push entropyscourge/multi-worker-k8s:latest

docker push entropyscourge/multi-client-k8s:$GITHUB_SHA
docker push entropyscourge/multi-server-k8s:$GITHUB_SHA
docker push entropyscourge/multi-worker-k8s:$GITHUB_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=entropyscourge/multi-server-k8s:$GITHUB_SHA
kubectl set image deployments/client-deployment client=entropyscourge/multi-client-k8s:$GITHUB_SHA
kubectl set image deployments/worker-deployment worker=entropyscourge/multi-worker-k8s:$GITHUB_SHA