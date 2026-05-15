# Q and A

## Load Balancers

- How does load balancing contribute to Fault tolerance? What about high availability?

```text
Generally when you use a load balancer you will include health checks. Those health checks allow you to detect instances that are failing or not working as expected. The early/on time detection allows the load balancer to redirect traffic (hopefully) before there are negative service impacts.

Load balancers help with high availability by allowing you to distribute traffic across instances. With load balancing a single instance shouldn't become a bottleneck. The load balancer when coupled with autoscaling can also help to ensure that if an instance goes down or has to be taken out of service then another replaces it.
```

- Do global load balancers decrease latency for end users? Why or why not?

```text
Yes. Global load balancers use an anycast address. With an anycast address incoming requests are generally routed nearest data center (multiple servers share the same IP). By using anycast, the requests are sent to the. nearest node in Google's network and then to the backend services.
```

- What are LB health checks for? Do we always need them? Is a LB different from a reverse proxy?

```text
Load balancer health checks allow the load balancer to know which instances are healthy. This allows the load balancer to only send traffic to instances that are healthy.

While health checks aren't required by all load balancers, it's a best practice to use them. AFAIK you cannot create a functioning load balancer in GCP or AWS without using health checks.

A load balancer is the same as a reverse proxy. Users send traffic to the load balancer and it distributes that traffic out to instances. From the user's perspective they only sent the traffic to the load balancers and aren't concerned with where the load balancer sent the traffic to or got a response from.

```

- What are LB routing rules and URL maps for? Give an example or two of them in use.

```text
Routing rules and URL maps allow the load balancer to determine which backend to send traffic to.

You may for example have a rule that says anyone passing the `X-ON-PREMISE` header is forwarded to a certain backend.

Another example is that you might have direct all traffic with the path `/tokyo/*` to a backend in the Tokyo region and all traffic with the path `/nyc/*` to the New York region
```

- Explain what an anycast IP address is used for in the context of a global load balancer.

```text
The anycast address is used to ensure that when a user sends traffic to your load balancer then that traffic is sent to the closest edge location. With anycast, a single IP address is used to represent multiple edge locations and a user's traffic will be sent to the nearest one.
```

## Cloud Armor

- What does cloud armor offer?

```text
Cloud Armor offers DDoS protection as well as a web application firewall. For example, Cloud Armor can be used to help mitigate the OWASP top 10 attacks.
```

- Why is it used in the first place?

```text
Cloud Armor is used for a variety of reasons. One reason is that it can provide a consistent security posture across your backend applications. Additionally, it may be faster to respond to security incidents (DDoS attacks, people doing SQL injections...) by altering Cloud Armor rules than hardening or changing an application.

Cloud Armor, unlike a network firewall, offers protection at layer 7 (the application layer). This allows for the evaluation or rules based on things like URL and HTTP headers.

```

- What layer in the OSI model does it operate at? Why is this important and how is this firewall different from VPC firewall rules?

```text
Cloud Armor operates at the application layer but it's DDoS protection works at layers 3 and 4.

Operating at layer 7 is important because it allows CloudArmor to make decisions using layer 7 information like url. Operating at layer 7 allows CloudArmor to mitigate many OWASP top 10 attacks like cross site scripting.
```

- What are rate based rules for?

```text
Rate based rules are used to throttle or stop traffic based on volume. This is helpful for DDoS protection, bot protection or even for enforcing API usage limits.
```

- What is reCAPTCHA and how does it relate to this service?

```text
reCAPTCHA is one of the Internet's biggest time sucks...

Seriously though, reCAPTCHA is a way to allegedly distinguish between real users and bots. By giving users a test (ex: identify all pictures that have a bike), reCAPTCHA hopes to stop bots or non-human traffic from proceeding.

CloudArmor can use reCAPTCHA to protect your backend against bot traffic. reCAPTCHA can be one component of the risk score CloudArmor assigns to traffic when making the decision to forward, block or throttle it.

```

## Cloud CDN

- What are POPs used for?

```text
POP AKA point of presence is an edge location. These are the locations where your data will be cached. By leveraging POPs your users can be served traffic that's closer to them often resuling in a better experience. You can also reduce the amount of requests on your backend since data will be cached.
```

- What kind of files are served with Cloud CDN?

```text
CloudCDN can serve a variety of files from images to html. This includes both static content and content dynamically created by the backend services.
```

- What services can be used with cloud CDN for the source of content (the origin)?

```text
The following services can be used with Cloud CDN:
- cloud buckets
- managed/unmanaged instance groups

**You cannot directly connect a vm to Cloud CDN
```

- Does Cloud CDN help protect against any types of malicious actors or cyberattacks? Explain.

```text
Yes, Cloud CDN can protect against malicous actors reducing load on origins/backends (cache traffic so the origin isn't called everytime). CloudArmor can also be used with Cloud CDN. Lastly, attackers would only know the address of the Cloud CDN and not the address(es) of your actual instances.
```

- Should an enterprise always use cloud CDN? Why or why not?

```text
No. Cloud CDN isn't necesssary for internal applications, if you don't need the additional protections, when you don't have a lot of cacheable content...
```

- What is TTL and how does it control content “freshness”?

```text
TTL is time to live and determines how long an object will remain cached. If an object is changed before the TTL is over then you'd need to invalidate it or risk users seeing the old version until the TTL was up.
```
