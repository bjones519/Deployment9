
#### November 17, 2023
________________________________________________________	

# Two-Tier E-Commerce Application Deployment on EKS

Deployment Contributors:

**Project Manager**: Brittney Jones <br />
**Chief Architect**: Belinda Dunu <br />
**System Administrator**: Brittney Jones

## Table of Content
- [Deployment Overview](#deployment-overview)
- [Infrastructure Overview](#deployment-overview)
- [Jenkins Server Setup](#jenkins-server-setup)
- [EKS Server Setup](#eks-server-setup)
- [Jenkins CI/CD Pipeline](#jenkins-cicd-pipeline)
- [Testing and Deployment](#testing-and-deployment)
- [Benefits Achieved](#benefits-achieved)
- [Issues Faced](#issues-faced)
- [System Diagram](#system-design)
- [Optimizations](#optimizations)
- [Conclusion](#conclusion)

## Deployment Overview

In this deployment, we launched a 2-tier(Django python and React) e-commerce application using Terraform infrastructure as code (IAC) for provisioning resources on AWS and Jenkins for CI/CD automation. We chose this approach in order to enhance consistency, collaboration, security, and ease of maintenance compared to manual deployments.

## Infrastructure Overview

- Custom VPC with 10.0.0.0/16 CIDR block
  - Provides isolation and security for the application
- 2 public subnets in separate availability zones
  - Public subnets allow internet access for Jenkins, Agent servers and frontend servers
- 2 private subnets in separate availability zones
  - Servers for the backend of the app will be placed here
- Internet gateway attached to VPC
  - Enables public subnet internet connectivity
- NAT gateway attached to VPC
    - Enables private subnet internet connectivity
- 3 Ubuntu 18.04 t2.medium EC2 instances
  - Separate instances for Jenkins manager and Jenkins agent isolation
  - Security groups restricting access
    - Jenkins Security Group opens ports 22 and 8080
    - Jenkins Agent Security Group opens ports 22
- EKS Cluster
- 2 Nodes on  Amazon Linux t2.medium EC2 instances

## Jenkins Server Setup

- Launched Ubuntu EC2 instance in the public subnet
- Installed Jenkins and created an admin user account
- Dedicated server for CI/CD automation
- Enhanced security with user access controls
- Generated SSH key pair and copied the public key to the app server
  - Allows SSH access from Jenkins without a password


## EKS Cluster Setup

- To create the cluster run
```
eksctl create cluster cluster01  --vpc-private-subnets="your-subnets"  --vpc-public-subnets="your-subnets"--without-nodegroup
```

![Cluster](screenshots/Screen%20Shot%202023-11-16%20at%208.28.36%20AM.png)
![ClusterCreating](screenshots/Screen%20Shot%202023-11-16%20at%208.28.55%20AM.png)

-  After the cluster creates run:
```
eksctl create nodegroup --cluster cluster01 --node-private-networking --node-type t2.medium --nodes 2
```
![NodeCreating](screenshots/Screen%20Shot%202023-11-16%20at%209.04.07%20AM.png)


## Jenkins CI/CD Pipeline

- Created GitHub-integrated multibranch pipeline
- Automates build and deploy for all branches

- Jenkinsfile containerizes the application, logs into Dockerhub, pushes the image to Dockerhub. Then using the Kubernetes manifest files, deploys the application onto an EKS Cluster.
 ![Backend Deployment](screenshots/Screen%20Shot%202023-11-16%20at%208.24.31%20PM.png)
  ![Frontend Deployment](screenshots/Screen%20Shot%202023-11-16%20at%208.26.52%20PM.png)
- Lastly a notification is sent to a Slack channel, letting the channel know if the pipeline completed successfully or failed, using a [Python Script](CICD_SlackNotif.py).
  ![Frontend Deployment](screenshots/Screen%20Shot%202023-11-16%20at%208.26.38%20PM.png)


## Testing and Deployment

- Updated files in a separate Git branch
- Simulated code change to test pipeline
- Ran build on a new branch using Jenkinsfile
- Validated updated app functionality
- Merged branch to trigger production deploy to master
- Jenkinsfile deploys latest merged code on the master branch, which deploys the application 
![Application](screenshots/Screen%20Shot%202023-11-16%20at%208.49.36%20PM.png)

## Benefits Achieved

- Collaboration through infrastructure as code
- Security via isolated environments and access controls
- Maintainability with automated CI/CD deployments
- Consistency by defining infrastructure and deployments in code
- Observability into our cluster through container insights on Cloudwatch
![Cloud Watch](screenshots/Screen%20Shot%202023-11-16%20at%208.30.16%20PM.png)


## Issues Faced:

### 500 Status Code

- **Issue:** After deploying frontend and backend, then navigating to the application we got a 500 error indicating that it was a server error with the backend.
![500](screenshots/Screenshot%202023-11-17%20at%205.42.57%20PM.png)
- **Resolution:** There was a typo in the backend service.yaml, which was fixed then redeployed and the application worked successfully.

### AWS Identity
- **Issue:** When trying to create the EKS Cluster through the CLI, AWS returned the following error:
```
Error: checking AWS STS access - cannot get role ARN for current session: operation error STS: GetCallerIdentity:
```
- **Resolution:** We had to authenticate through AWS using `aws configure`


## System Design
![SystemDesign](screenshots/Screenshot%202023-11-17%20at%2010.07.28%20PM.png)

## Optimizations
- Congifure a Jenkins agent for automated infrastructure provisioning using Terraform
- Set Up Cloud Watch Alarms to be notified when certain thresholds are crossed such as CPU, Memory and when/if nodes, pods or the cluster go offline.
- Add testing for the frontend and backend of the application
- Combine the Kubernetes deployment and service files to include both the frontend and backend

## Conclusion
This project demonstrated using Terraform IAC and Jenkins CI/CD to deploy a 2-tier e-commerce application on AWS EKS. Some key benefits include improved availability through load balancing, automated software deployment, security, consistency, and maintainability of the deployment process. Proactively managing dependencies, resources, connectivity, and configurations is critical for smooth deployments. For future deployments, integrating Terraform with Jenkins, improving observability, and implementing backup/DR(disaster recovery) would further optimize the deployment architecture.