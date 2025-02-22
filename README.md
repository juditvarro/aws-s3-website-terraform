# Terraform AWS S3 Website Deployment

This repository contains Terraform files to create an AWS S3 bucket to host a static website. It sets up the necessary configurations, including making the bucket public and configuring the bucket for static website hosting.

## Resources

- **S3 Bucket**: Creates an S3 bucket to store the website content.
- **Website Configuration**: Configures the bucket for static website hosting, including setting the `index.html` file as the landing page.
- **Bucket ACL**: Sets the bucket to be publicly accessible with read permissions.
- **Bucket Ownership**: Configures ownership settings for the bucket objects.
- **Bucket Access Control**: Ensures that public access is allowed with specific settings to prevent unauthorized access.
- **Bucket Policy**: Grants public read access to the bucket and enforces HTTPS.

## Usage

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Set up your AWS credentials:**
   Make sure your AWS credentials are configured. You can set them via the AWS CLI or use environment variables.

3. **Configure the bucket name:**
   The name of the required bucket should be provided as `bucket_name` variable and it must be globally unique across all AWS S3 buckets.

4. **Initialize Terraform:**
   Run the following command to initialize the Terraform working directory:
   ```bash
   terraform init
   ```

5. **Apply the Terraform configuration:**
   Apply the configuration to create the S3 bucket and configure the website.
   ```bash
   terraform apply
   ```

6. **Access the website:**
   After the apply is complete, you can access the website via the S3 bucket's website endpoint.

## Cleanup

To destroy the resources created by Terraform:

```bash
terraform destroy
```
