# Creating an External Load Balancer with ClickOps

The result of completing the steps below will be a working and fully configured `External Application Global Load Balancer` created with ClickOps. Your Global Load Balancer will use a Managed Instance Group as its backend and will include Health Checks.

_Unlike an internal application load balancer, your load balancer will be able to receive traffic from the internet. As a global, not regional, load balancer, the backend can be in any region._

## Prerequisites

1. You need to be able to access the GCP console
1. You need to have a VPC (the default is fine)
1. Firewall rules that allow traffic on HTTP (TCP port 80)
1. You need to configure a [Managed Instance Group](../../week8//docs/runbook.md)
1. The compute engine API must be enabled for your user

## Creating the External Load Balancer

1. Log into GCP
2. From the search bar look for "Load balancer", click the result and click the "Create load Balancer" button
   ![create load balancer](../images/create-load-balancer.png)
3. Alternatively, navigate to [Create Load Balancer](https://console.cloud.google.com/net-services/loadbalancing/add)
4. Choose "Application Load Balancer" then click Next
   ![app lb](../images/app-load-balancer.png)
5. Choose "Public facing (external)"
   ![public facing](../image/public-facing.png) then click Next
6. Choose "Best for global workloads" then click Next
   ![global](../images/global.png)
7. Choose "Global external Application Load Balancer" then click Next
   ![global external](../images/global-external.png)
8. Click Configure
   ![configure](../images/configure.png)
9. Give your Load Balancer a name
10. For front end, enter a name and leave the default values then click "Backend Configuration"
    ![front end](../images/front-end.png)
11. Click the `Backend services & backend buckets` square, choose Create backend service
    ![create backend](../images/create-backend.png)
12. For the backend configuration make sure to choose your Health Check, your Instance Group, 80 for the port, disable cloud CDN then click Create
    ![backend1](../images/backend1.png)
    ![backend2](../images/backend2.png)
13. Now you should see your backend checked in the dialog so click OK
    ![backend confirmation](../images/backend-confirm.png)
14. Click the Routing rules link and confirm that your backend is selected along with Simple host and path rule
    ![routing rules](../images/routing-rules.png)
15. Click Review and finalize then verify and confirm your settings then click Create
    ![finalize](../images/review-and-finalize.png)
16. Wait for your load balancer to be created and for your MIG to create instances (this can take a while, be patient) \***Once the load balancer is created, you'll want to check your MIG to see that your instances are healthy**
17. From the load balancer's details page find the public IP and enter that into your browser
    ![lb ip](../images/lb-ip.png)

## Teardown

1. Delete the load balancer (make sure to check the box to also remove the backend services)
   ![delete lb](../images/delete-lb.png)
1. Check to make sure that your [Cloud Armor policy ](https://console.cloud.google.com/net-security/securitypolicies/list)was removed. If it was not then remove it
1. Verify that your [backend](https://console.cloud.google.com/net-services/loadbalancing/list/backends) was deleted
1. Verify that the [IP Address](https://console.cloud.google.com/networking/addresses/list) for your load balancer was removed
1. Remove your MIG and associated resources if desired

## Notes

- Your backend is where the load balancer will send traffic. You can have backend services as well as backend buckets
