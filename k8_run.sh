# Deploy database
kubectl apply -f db-deployment.yaml
kubectl apply -f db-pv.yaml
kubectl apply -f db-service.yaml

# Deploy backend
kubectl apply -f be-deployment.yaml
kubectl apply -f be-service.yaml

# Deploy frontend
kubectl apply -f fe-deployment.yaml
kubectl apply -f fe-service.yaml

# Apply ingress
kubectl apply -f ingress.yaml
