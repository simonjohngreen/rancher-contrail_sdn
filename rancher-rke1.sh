aws cloudformation create-stack \
  --capabilities CAPABILITY_IAM \
  --stack-name Rancher \
  --disable-rollback \
  --template-url https://s3-eu-central-1.amazonaws.com/rancher-contrail/rancher-root-rke1.json \
  --parameters \
ParameterKey=VPCCIDR1,ParameterValue="100.72.100.0/22" \
ParameterKey=PrivateSubnetCIDR1,ParameterValue="100.72.100.0/24" \
ParameterKey=PrivateSubnetCIDR2,ParameterValue="100.72.101.0/24" \
ParameterKey=PrivateSubnetCIDR3,ParameterValue="100.72.102.0/24" \
ParameterKey=PublicSubnetCIDR1,ParameterValue="100.72.103.0/24" \
ParameterKey=AvailabilityZone1,ParameterValue="eu-west-1a" \
ParameterKey=AvailabilityZone2,ParameterValue="eu-west-1b" \
ParameterKey=AvailabilityZone3,ParameterValue="eu-west-1c" \
ParameterKey=SiteName,ParameterValue="k8sFederation" \
ParameterKey=ContainerRegistryUserName,ParameterValue="JNPR-FieldUserxxx" \
ParameterKey=ContainerRegistryPassword,ParameterValue="EwRUWxxxxxxGxu" \
ParameterKey=NumberOfNodes,ParameterValue="3"
while [[ $(aws cloudformation describe-stacks --stack-name Rancher --query "Stacks[].StackStatus" --output text) != "CREATE_COMPLETE" ]];
do
     echo "waiting for cloudformation stack to complete."
     sleep 60
done
aws cloudformation describe-stacks --stack-name Rancher --query "Stacks[0].Outputs[]" --output table
echo "All Done"
