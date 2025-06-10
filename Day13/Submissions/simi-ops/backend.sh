aws s3api create-bucket \
    --bucket simi-ops-terraform-state \ 
    --region us-west-2 --create-bucket-configuration \
    LocationConstraint=us-west-2

aws dynamodb create-table \
    --table-name simi-ops-terraform-locks \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
    --region us-west-2