#project Directory palo-alto-test

In this example, we:

Configure the Google Cloud provider.
Create a GKE cluster.
Define a node pool.
Create a Kubernetes Deployment called "nginx-deployment" with three replicas.
Specify the NGINX container image to use (in this case, "nginx:latest").
Replace <YOUR_SERVICE_ACCOUNT_KEY_FILE> and <YOUR_PROJECT_ID> with your actual service account key file and project ID.

After creating this Terraform configuration file, you can run terraform init, terraform plan, and terraform apply to deploy the NGINX container in your GKE cluster. Make sure you've authenticated with Google Cloud using the gcloud command-line tool before running Terraform. Additionally, ensure we have Terraform and the Google Cloud SDK installed and configured on the machine.
