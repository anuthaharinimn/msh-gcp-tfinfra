#!/bin/bash

PROJECT_NAME=""

# Validate project_name
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: project_name is not set. Exiting."
  exit 1  # Fail the script if project_name is empty
fi

# Check if tflint is installed
if ! command -v tflint &> /dev/null; then
  echo "tflint not found, installing..."
  
  # For macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # Install tflint on macOS using Homebrew
    brew install tflint
  # For Linux
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Install tflint on Linux using curl
    curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
  fi
else
  echo "tflint is already installed."
fi

# Check if tfsec is installed
if ! command -v tfsec &> /dev/null; then
  echo "tfsec not found, installing..."
  
  # For macOS
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # Install tfsec on macOS using Homebrew
    brew install tfsec
  # For Linux
  elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Install tfsec on Linux using curl
    curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/get.sh | bash
  fi
else
  echo "tfsec is already installed."
fi

# Set the location of your tf-statefile directory
TF_STATEFILE_DIR="./assessment_gcp/tf-env/us-central/tfstatefile"

# Run terraform init to initialize the backend configuration
echo "Running terraform init..."
cd $TF_STATEFILE_DIR
terraform init 
tflint
tfsec .


# Move back to the correct directory
cd ../../../../

# Set the location of your tf-env directory
TF_ENV_DIR="./assessment_gcp/tf-env/us-central/env"

cd $TF_ENV_DIR
# Run terraform init to initialize the backend configuration in the tf-env directory
echo "Running terraform init in tf-env directory..."
terraform init 

echo "TFLint code quality check...."
tflint

echo "Security vulnerabilities check....."
tfsec .


