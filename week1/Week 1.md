---
tags:
  - BMC
  - GCP
  - homework
name: Homework Week 1
week: "1"
---

# Overview

- Homework assignments can be found [here](https://github.com/BalericaAI/SEIR-1/blob/main/weekly_lessons/weeka/weeka_homework.txt).

# Deliverables

[Badge](./badge.txt)
[Gate Results](./gate_result.json)

![[Week1_Homepage.png]]

# Troubleshooting

- How do you handle the error: `Could not get lock /var/lib/dpkg/lock-frontend.`?
  - This error means that another process is already using apt
  - This is likely due to automatic package updates being done on boot
  - It could be some other process

```bash
# add the following to wait until the lock is free before running your apt-get update and install
# fuser will tell yo uwhich processes are using a file, directory or socket
# if a process is using the file fuser will exit with a status of 0
# if it's not in use fuser exits with a non-zero status and the loop ends
# the while loop checks the exit status of fuser
# stdout being sent to /dev/null doesn't affect the loop
# > /dev/null 2>&1 just keeps the logs clean
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do
	echo "Waiting for apt lock..."
	sleep 5
done
```
