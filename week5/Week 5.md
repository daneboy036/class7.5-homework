---
tags:
  - BMC
  - GCP
  - homework
name: Homework Week 5
week: "5"
---

# Deliverables

- [x] Terraform Init
      ![Terraform Init](./terraform-init.png)
- [x] Terraform Validate
      ![Terraform Validate](./terraform-validate.png)
- [x] Terraform Plan
      ![Terraform Plan](./terraform-plan.png)
- [x] Terraform Plan Output
      ![Terraform Plan Output](./terraform-plan-output.png)
- [x] Terraform Apply
      ![Terraform Apply](./terraform-apply.png)
- [x] Google Console: Main VPC Exists
      ![Google Console: Main VPC Exists](./in-google-vpc.png)
- [x] Google Console: Subnet Exists
      ![Google Console: Subnet Exists](./in-google-subnets.png)
- [x] Google Console: Router Exists
      ![Google Console: Router Exists](./in-google-router.png)
- [x] Terraform Destroy
      ![Terraform Destroy](./terraform-destroy.png)
- [x] date && hostname && whoami
      ![Date/Hostname/Whoami](./date-hostname-whoami.png)
- [x] Google Console: Main VPC Destroyed
      ![Google Console: Main VPC Destroyed ](./main-vpc-gone.png)

# Homework Walkthrough

1. Create the terraform files (see week5/terraform directory)
2. Execute the terraform commands below

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

3. Go to the [Google Cloud Console](https://console.cloud.google.com/) and verify that the following resources were created:
   - a vpc called main
   - a subnet for the vpc
   - a router
4. Execute the following commands from your terminal

```bash
terraform destroy
date && hostname && whoami
```

5. Manually verify in the [Google Cloud Console](https://console.cloud.google.com/) that your resources have been deleted
6. Go to your backend bucket and find your state file
