namespace=$1

if [ -z "${namespace}" ]
then
    echo "Missing the 'Namespace' parameter. Taking the default one which is 'development'"
    namespace="development"
fi

aws cloudformation deploy \
    --stack-name ${namespace}-iam-policy-inventory-api \
    --template-file iam-policy-app-x-ray.yaml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides \
        Namespace=${namespace}