## Prerequisites

Make sure you have the following installed and configured:

- **gcloud**: Google Cloud SDK for interacting with GCP.
- **Terraform**: For managing infrastructure as code.
- **tflint**: For Terraform code quality checks.
- **tfsec**: For Terraform security vulnerabilities checks.

Scripts
1. deploy.sh
This script provisions the GCP infrastructure. It will:

Create a Cloud Storage Bucket to store the Terraform state.

Set up Cloud Functions.

Create a Load Balancer.

2. destroy.sh
This script will destroy all resources that were created by deploy.sh. This is useful for cleaning up your GCP project after the infrastructure is no longer needed.

3. secure_check.sh
This script runs code quality checks with tflint and security vulnerability checks with tfsec on the Terraform code in the project.

How to Use
Step 1: Set the Project Name
For all scripts (deploy.sh, destroy.sh, secure_check.sh), you will need to specify your project_name. Set the project name by modifying the project_name variable in each of the scripts.

Update inside the script
PROJECT_NAME="your-project-id"

Step 2: Running the Scripts
Deploying the Infrastructure:

Run the deploy.sh script to create the infrastructure:

./deploy.sh

Wait for 5mins and run below command
curl http://load_balancer_url 

Destroying the Infrastructure:

When you're done and want to destroy the infrastructure, run the destroy.sh script:

./destroy.sh
Running Security and Code Quality Checks:

Run the secure_check.sh script to ensure the Terraform code adheres to quality and security standards:

./secure_checks.sh



Folder structure for TF Code

├── assessment_gcp
│   ├── tf-env
│   │   └── us-central
│   │       ├── env
│   │       │   ├── backend.tf
│   │       │   ├── main.tf
│   │       │   ├── output.tf
│   │       │   └── variables.tf
│   │       └── tfstatefile
│   │           ├── main.tf
│   │           ├── output.tf
│   └── tf-modules
│       ├── cf
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       ├── lb
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── storage
│           ├── main.tf
│           ├── outputs.tf
│           └── variables.tf


Terraform execution path written in deploy script.
