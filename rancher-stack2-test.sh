  --capabilities CAPABILITY_IAM \
  --stack-name Rancher-Stack2 \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/rancher-contrail/microk8s-stack2.json \
  --parameters \
ParameterKey=ContainerRegistryUserName,ParameterValue="JNPR-FieldUserxxx" \
ParameterKey=ContainerRegistryPassword,ParameterValue="EwRxxxxxxxxxxu" \
ParameterKey=idPublicSubnet1,ParameterValue="subnet-03e5902443a424933" \
ParameterKey=idPrivateSubnet1,ParameterValue="subnet-0088390d56c9154cf" \
ParameterKey=idVPC,ParameterValue="vpc-037ceaca64c6428b5" \
ParameterKey=NumberOfClusters,ParameterValue="1"
aws cloudformation create-stack \
