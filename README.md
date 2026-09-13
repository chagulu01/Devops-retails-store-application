# Devops-retails-store-application

aws eks update-kubeconfig --region us-east-1 --name retail-dev-dev-eks-cluster

kubectl port-forward deploy/catalog 7080:8080

# Topology Endpoint
http://localhost:7080/topology

# Health Endpoint
http://localhost:7080/health

kubectl describe pod <pod-name> | grep Image

# List Deployment Revisions
kubectl rollout history deployment/catalog

# Update the Deployment
kubectl set image deployment/catalog catalog=public.ecr.aws/aws-containers/retail-store-sample-catalog:1.3.0

# List Deployment Revisions
kubectl rollout history deployment/catalog
Verify rollout status:

kubectl rollout status deployment/catalog
You’ll see Pods being updated one by one (rolling update).

Confirm new version:

kubectl get pods -o wide
kubectl describe pod <pod-name> | grep Image
Step-06: Rollback to Previous Version (1.0.0)
If something goes wrong, roll back easily:

# Rollback to previous version
kubectl rollout undo deployment/catalog

# List Deployment Revisions
kubectl rollout history deployment/catalog
or rollback to a specific revision:

# List Deployment Revisions
kubectl rollout history deployment/catalog

# rollback to a specific revision
kubectl rollout undo deployment/catalog --to-revision=<X>

# List Deployment Revisions
kubectl rollout history deployment/catalog
Check the version after rollback:

kubectl describe deployment catalog | grep Image
Step-07: Cleanup
kubectl delete deployment catalog
