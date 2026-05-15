# General Notes

- What is a reverse proxy?
  - a server that sits in front of web servers and forwards client requests to those web servers
- What is a forward proxy?
  - sits in front of a group of client machines. those computers make requests to sites and services on the internet, the proxy intercepts those requests and then communicates with the services on behalf of the user acting as a middle man
- VPCs in gpc are global
- Routing mode can be regional or global
  - with regional routes learned stay within the region
  - with global routes learned propogate teh whole vpc
  - this won't matter for making a global load balancer because internally gcp handles getting traffic from the load balancer to the backends regardless of region
- You can add a named port to the MIG for your lb to reference but it worked without one

# Troubleshooting

I got an error like "The zone 'projects/bmc-7dot5/zones/us-central1-a' does not have enough resources available to fulfill the request. Try a different zone, or try again later" so I switched to a regional mig instead of putting it in one zone. that didn't work so I switched from n2-standard-2 to e2-small.

From what I read the ZONE_RESOURCE_POOL_EXHAUSTED could have been a temporary blip or it could have been an issue with with using n2-standard-2 and gcp having trouble provisioning 3 of those across the zones as opposed to the flexible e2

# Resources

[GCP -- Create an External Load Balancer](https://docs.cloud.google.com/load-balancing/docs/https/setup-global-ext-https-compute)
https://www.imperva.com/blog/how-anycast-works/
https://oneuptime.com/blog/post/2026-02-23-how-to-create-gcp-instance-templates-with-terraform/view

https://anant.us/blog/gcp-managed-instance-groups-w-terraform/
