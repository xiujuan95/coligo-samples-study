### Building and deploying the sample

1. Use Docker to build the sample code into a container. To build and push with Docker Hub, run these commands replacing {username} with your Docker Hub username:
- Build the image on your local machine
 ```
  docker build -t {username}/helloworld-go .
 ```
 - Push the image to docker registry
 ```
docker push {username}/helloworld-go
```

2. After the build has completed and the image is pushed to docker hub, you can deploy the app into your cluster:
```
kubectl apply --filename helloworld-ksvc.yaml
```

3. Make a request to your app and see the result, check the node disk usage at the same time
```
curl http://helloworld-go.default.1.2.3.4.xip.io
kubectl get pod
```