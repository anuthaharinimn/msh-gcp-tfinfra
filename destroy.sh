#!/bin/bash

PROJECT_NAME=""

# Validate project_name
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project_name is not set. Exiting."
  exit 1  # Fail the script if project_name is empty
fi

# Set the location of your tf-env directory
TF_ENV_DIR="./assessment_gcp/tf-env/us-central/env"

cd $TF_ENV_DIR
# Run terraform init to initialize the backend configuration in the tf-env directory
echo "Running terraform init in tf-env directory..."
terraform init

# Run terraform apply to apply the changes in the tf-env directory
echo "Running terraform apply in tf-env directory..."
terraform destroy -auto-approve

rm -rf .terraform

cd ../../../../
sed -i '' "s|$PROJECT_NAME|projectrunner|" "$TF_ENV_DIR/backend.tf"
sed -i '' "s|$BUCKET_NAME|bucketreplace|" "$TF_ENV_DIR/backend.tf"

# Set the location of your tf-statefile directory
TF_STATEFILE_DIR="./assessment_gcp/tf-env/us-central/tfstatefile"

cd $TF_STATEFILE_DIR
terraform init 

# Run terraform apply to apply the changes
echo "Running terraform apply..."
terraform destroy -auto-approve

rm -rf .terraform
cd ../../../../
sed -i '' "s|$PROJECT_NAME|projectrunner|" "$TF_STATEFILE_DIR/main.tf"
sed -i '' "s|$PROJECT_NAME|projectrunner|" "$TF_STATEFILE_DIR/output.tf"