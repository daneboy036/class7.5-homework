# FAQ for Junior Engineers

- What is the difference between high availability and fault tolerance? Which is best to strive for?
  <br >
  High availability concerns making sure that a system can recover when something goes wrong. As an example, if you have 3 VMs spread across zones and one zone goes down then you still have two instances to serve traffic. Fault tolerance concerns keeping the system running even when something goes wrong. As an example, you store your photos on a NAS and sync data between two drives. If one drive goes down then you can get photos from the other with no interruption.

It's best to strive for both but fault tolerance will often be more expensive.

- Explain the difference between autoscaling and elasticity.
  <br >

Elasticity is the ability of your system to grow and/or shrink on demand. The elasticity will generally be triggered based on load or demand. Autoscaling is automatically adjusting your resources.

While they seem similar, you can be elastic without having autoscaling because you can manually grow/shrink resources. With autoscaling, the system shrinks or expands automatically in response to something.

- What is vertical and horizontal autoscaling?
  <br >

Vertical scaling is the process of throwing more hardware at a problem. For example, you notice that during peak shopping hours, the memory on your server is at 90% so you add more RAM.

Horizontal scaling is adding more resources. To build on the example above, instead of adding more ram, you'd add a second computer to help offset the load.

- Is one better?
  <br >

Horizontal scaling will generally be more efficient and may be more cost efficient. The ability to vertically scale is capped by things like how much ram a system can use or limitations on processors. The ability to horizontally scale is less capped.

- Are they feasible on prem?
  <br >

How feasible they are depends on the sitaution, the company and the budget. A company that runs their servers under someone's desk may find it easier to buy more ram than to add a second server for example. For horizontal and vertical scaling, on premise loads will hit a ceiling sooner than cloud loads.

A huge advantage of the cloud is the ability to scale on demand. In the cloud, you can add more instances on black Friday and remove them after. On premise, if you add more servers or buy more hardware then you're generally stuck with the purchases.

- Explain what the difference between managed and unmanaged instance groups is.
  <br >

  An instance group can be thought of as a collection of VMs.

  With a managed instance group, GCP handles a lot of the heavy lifting like scaling, healing and creating VMs for you. With a managed instance group you can define your desired state and GCP will handle managing to get you there.

  With an unmanged instance group, you still have a collection of VMs but GCP will not manage them for you. You will be responisbile for scaling, terminating bad instances...If you have two VMs that you want to load balance across and don't need autoscaling, healing...then unmanaged instances can be an option.

- Explain the different use cases for health checks used by applications (in instance groups) and health checks used by load balancers. Can they be the same? Are they different API calls? Should they be the same?
  <br >

  Health checks within the instance group help to determine if an instance is still healthy. Health checks used by the load balancer only determine if traffic will be sent to the instance. The load balancer won't replace an instance simply because it's unhealthy.

  You can use the same endpoint for the load balancer and an instance group health check.

  Should they be the same depends on your use case. Some load balancers may only support http/https health checks for example. Also, you might have different criteria for when the instance itself is considered unhealthy vs when it should receive traffic. For example, an instance that can serve a webpage but not connect to redis may be unhealthy and a candidate for recreation, but you may still want to send traffic to it.

- Explain in a few sentences what the 3 tier architecture is and how it relates to what you are learning.
  <br >

  In three tier architecture you break your application up into distinct tiers. The common example is that a company creates web app for selling candles. Initially, the database, front end and backend services all live on one computer. You then create a separate database server, containers for the backend services and you put the front end app in a CDN.

  Splitting into tiers has many advantages including scaling parts separately, limiting access to certain tiers (ex: database doesn't need to be available on the Internet) and making it easier to deploy only the services that have actually changed.

  This relates to what we're learning because cloud providers make it easy to separate architectures into tiers at a reasonable cost.
