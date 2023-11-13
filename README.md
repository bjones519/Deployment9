
#### November 13, 2023
________________________________________________________	

# Two-Tier E-Commerce Application Deployment on EKS

Deployment Contributors:

**Project Manager**: TBD <br />
**Chief Architect**: Belinda Dunu <br />
**System Administrator**: Brittney Jones

## Deployment Overview

In this deployment, we launched a 2-tier(Django Python and React) e-commerce application using Terraform infrastructure as code (IAC) for provisioning and Jenkins for CI/CD automation. We chose this approach in order to enhance consistency, collaboration, security, and ease of maintenance compared to manual deployments.

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
- 2 Ubuntu 18.04 t2.micro EC2 instances
  - Separate instances for Jenkins and app isolation
  - Security groups restricting access
    - Jenkins SG opens ports 22 and 8080
    - App SG opens ports 22 and 8000

## Jenkins Server Setup

- Launched Ubuntu EC2 instance in the public subnet
- Installed Jenkins and created an admin user account
- Dedicated server for CI/CD automation
- Enhanced security with user access controls
- Generated SSH key pair and copied the public key to the app server
  - Allows SSH access from Jenkins without a password

## Jenkins CI/CD Pipeline

- Created GitHub-integrated multibranch pipeline
- Automates build and deploy for all branches
- Jenkinsfile deploy stage executes setup scripts to deploy the latest app code
- Setup scripts install dependencies and start the application
  - Contains necessary steps to deploy the app

## Testing and Deployment

- Updated files in a separate Git branch
- Simulated code change to test pipeline
- Ran build on a new branch using Jenkinsfile
- Validated updated app functionality
- Merged branch to trigger production deploy to main
- Jenkinsfile deploys latest merged code which deploys the application 

## Benefits Achieved

- Collaboration through infrastructure as code
- Security via isolated environments and access controls
- Maintainability with automated CI/CD deployments
- Consistency by defining infrastructure and deployments in code

## Issues Faced:


## System Design


## Optimizations


## Conclusion

