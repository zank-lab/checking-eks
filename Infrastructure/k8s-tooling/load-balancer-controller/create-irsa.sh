helm repo add eks https://aws.github.io/eks-charts

service_account_name="aws-load-balancer-controller-iam-service-account"
aws_load_balancer_iam_policy=$(aws iam list-policies --query "Policies[?PolicyName=='aws-load-balancer-iam-policy'].Arn | [0]" --output text --no-paginate)

eksctl create iamserviceaccount --name ${service_account_name} \
    --namespace kube-system \
    --cluster eks-acg \
    --attach-policy-arn ${aws_load_balancer_iam_policy} --approve

helm upgrade --install \
  -n kube-system \
  --set clusterName=eks-acg \
  --set serviceAccount.create=false \
  --set serviceAccount.name=${service_account_name} \
  aws-load-balancer-controller eks/aws-load-balancer-controller

