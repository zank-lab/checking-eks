helm repo add eks https://aws.github.io/eks-charts

helm upgrade --install \
  -n kube-system \
  --set clusterName=eks-acg \
  --set serviceAccount.create=true \
  aws-load-balancer-controller eks/aws-load-balancer-controller

aws iam create-policy \
    --policy-name aws-load-balancer-iam-policy \
    --policy-document file://iam-policy.json
