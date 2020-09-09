# kubectl run db --image=mariadb --env="MYSQL_ALLOW_EMPTY_PASSWORD=true" \
#                               --env="MYSQL_DATABASE=dtapi" \
#                               --env="MYSQL_USER=dtapi" \
#                               --env="MYSQL_PASSWORD=password"

#kubectl exec -i db -- mysql -u root dtapi < database/dtapi_full.sql
#kubectl exec -i db -- mysql -u root dtapi < database/sessions.sql

#kubectl expose pod db --type=ClusterIP --port=3306
kubectl create -f db-deployment.yaml
kubectl create -f db-pv.yaml
kubectl create -f db-service.yaml
#kubectl exec -i db -- mysql -u root dtapi < database/dtapi_full.sql
#kubectl exec -i db -- mysql -u root dtapi < database/sessions.sql

#kubectl create deployment be --image=eu.gcr.io/trainingground-285720/be
#kubectl expose deployment be --type=NodePort --port=80
kubectl create -f be-deployment.yaml
kubectl create -f be-service.yaml

#kubectl create deployment fe --image=eu.gcr.io/trainingground-285720/fe
#kubectl expose deployment fe --type=NodePort --port=80
kubectl create -f fe-deployment.yaml
kubectl create -f fe-service.yaml

kubectl create -f ingress.yaml
