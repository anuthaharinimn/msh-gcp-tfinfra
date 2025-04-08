#!/bin/bash

PROJECT_NAME=""

# Validate project_name
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project_name is not set. Exiting."
  exit 1  # Fail the script if project_name is empty
fi

# Set the location of your tf-statefile directory
TF_STATEFILE_DIR="./assessment_gcp/tf-env/us-central/tfstatefile"

# Update project_name in main.tf
echo "Updating project_name in main.tf..."
sed -i '' "s|projectrunner|$PROJECT_NAME|" "$TF_STATEFILE_DIR/main.tf"
sed -i '' "s|projectrunner|$PROJECT_NAME|" "$TF_STATEFILE_DIR/output.tf"

# Run terraform init to initialize the backend configuration
echo "Running terraform init..."
cd $TF_STATEFILE_DIR
terraform init 

# Run terraform apply to apply the changes
echo "Running terraform apply..."
terraform apply -auto-approve

# Move back to the correct directory
cd ../../../../

# Set the location of your tf-env directory
TF_ENV_DIR="./assessment_gcp/tf-env/us-central/env"

# Fetch the project name and bucket name from the tf-statefile outputs
PROJECT_NAME=$(terraform output -state="$TF_STATEFILE_DIR/terraform.tfstate" project_name)
BUCKET_NAME=$(terraform output -state="$TF_STATEFILE_DIR/terraform.tfstate" state_bucket_name)

# Check if the project_name and bucket_name were fetched successfully
if [ -z "$PROJECT_NAME" ] || [ -z "$BUCKET_NAME" ]; then
  echo "Error: Could not fetch project_name or bucket_name from tf-statefile outputs."
  exit 1
fi

echo "Fetched project_name: $PROJECT_NAME"
echo "Fetched bucket_name: $BUCKET_NAME"

# Update the backend.tf in the tf-env directory with the fetched values
echo "Updating backend.tf with project_name and bucket_name..."
sed -i '' "s|projectrunner|$PROJECT_NAME|" "$TF_ENV_DIR/backend.tf"
sed -i '' "s|bucketreplace|$BUCKET_NAME|" "$TF_ENV_DIR/backend.tf"

cd $TF_ENV_DIR
# Run terraform init to initialize the backend configuration in the tf-env directory
echo "Running terraform init in tf-env directory..."
terraform init 

# Run terraform apply to apply the changes in the tf-env directory
echo "Running terraform apply in tf-env directory..."
terraform apply -auto-approve 

echo "Terraform init and apply completed."