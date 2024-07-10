# terraform-homework4

1. Initialize Terraform: terraform init

2. To deploy in a specific region, use the corresponding `.tfvars` file. For example, to deploy in `us-east-1`:   terraform apply -var-file virginia.tfvars

3. To destroy the resources after deployment:
terraform destroy -var-file virginia.tfvars
 
Repeat the `terraform apply` and `terraform destroy` steps for all four regions by specifying their respective `.tfvars` files.

This setup ensures that you have a reusable and configurable Terraform setup to create, test, and destroy infrastructure across multiple AWS regions.