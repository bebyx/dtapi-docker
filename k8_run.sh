kubectl run db --image=mariadb --env="MYSQL_ALLOW_EMPTY_PASSWORD=true" \
                               --env="MYSQL_DATABASE=dtapi" \
                               --env="MYSQL_USER=dtapi" \
                               --env="MYSQL_PASSWORD=password"

kubectl exec -i db -- mysql -u root dtapi < dtapi_full.sql
kubectl exec -i db -- mysql -u root dtapi < sessions.sql

kubectl expose pod db --type=ClusterIP --port=3306
