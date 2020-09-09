# kubectl run db --image=mariadb --env="MYSQL_ALLOW_EMPTY_PASSWORD=true" \
#                               --env="MYSQL_DATABASE=dtapi" \
#                               --env="MYSQL_USER=dtapi" \
#                               --env="MYSQL_PASSWORD=password"

#kubectl exec -i db -- mysql -u root dtapi < database/dtapi_full.sql
#kubectl exec -i db -- mysql -u root dtapi < database/sessions.sql

#kubectl expose pod db --type=ClusterIP --port=3306
kubectl apply -f db-deployment.yaml
kubectl apply -f db-pv.yaml
kubectl apply -f db-service.yaml
#kubectl exec -i db -- mysql -u root dtapi < database/dtapi_full.sql
#kubectl exec -i db -- mysql -u root dtapi < database/sessions.sql

#kubectl create deployment be --image=eu.gcr.io/trainingground-285720/be
#kubectl expose deployment be --type=NodePort --port=80
kubectl apply -f be-deployment.yaml
kubectl apply -f be-service.yaml

#kubectl create deployment fe --image=eu.gcr.io/trainingground-285720/fe
#kubectl expose deployment fe --type=NodePort --port=80
kubectl apply -f fe-deployment.yaml
kubectl apply -f fe-service.yaml

kubectl apply -f ingress.yaml
