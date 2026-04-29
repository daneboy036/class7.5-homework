---
tags:
  - BMC
  - GCP
  - homework
  - static-site
  - gcp-buckets
name: Homework Week 7
week: "7"
---

# Overview

The basic lab involves creating a new GitHub repository as well as a basic VPC and local file using terraform. The steps completed should be documented in the README of the new repository.

The be a man lab is to create a static site in GCP using a GCP bucket

# Deliverables -- Basic

- [x] New repository [class7.5_week7_hw](https://github.com/daneboy036/class7.5_week7_hw)
- [x] Proof of Local File Created with Terraform
      ![Local file](./deliverables/Local%20File%20Created.png)
- [x] Terraform Apply Output
      ![Terraform Apply](./deliverables/Terraform%20Apply%20Output.png)
- [x] [Site](https://storage.googleapis.com/dcbmc75week7ss/index.html) -- working as of 4-29-26

# Deliverables -- Be A Man

# Resources

https://docs.cloud.google.com/storage/docs/hosting-static-website
https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket.html
https://registry.terraform.io/modules/gruntwork-io/static-assets/google/latest/submodules/cloud-storage-static-website
https://mohamadalsalty.medium.com/beyond-the-bucket-building-a-production-ready-static-site-on-gcp-with-terraform-ee573d75e6e9
https://docs.cloud.google.com/storage/docs/locations
https://docs.cloud.google.com/storage/docs/access-control/iam-roles
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam#google_storage_bucket_iam_member
https://docs.cloud.google.com/storage/docs/static-website#tip-api

# Notes

- What happens when you set uniform_bucket_level_access to true?
  - no more object level permissions
  - ACLs are disabled and access is controlled via IAM roles on the bucket itself
  - You still need to give all users the objectView role
- according to https://docs.cloud.google.com/storage/docs/static-website#tip-api, MainPageSuffix and NotFoundPage are only used when requests come through a cname or a redirect. So without the cnmae I think I have to navigate directlty to <mysite>/index.html
