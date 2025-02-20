# EKS Auto Mode Tutorial

This repository provides a comprehensive guide to deploying an Amazon Elastic Kubernetes Service (EKS) cluster with Auto Mode enabled using Terraform. EKS Auto Mode simplifies Kubernetes management by automating infrastructure tasks, allowing you to focus on your applications.

## Prerequisites

Before deploying the EKS Auto Mode cluster, ensure you have the following installed and configured:

- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials.
- [kubectl](https://kubernetes.io/docs/tasks/tools/) for Kubernetes cluster management.
- [Terraform](https://www.terraform.io/downloads.html) for infrastructure as code.

## Configuration

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/MaximeMRF/eks-auto-mode-tutorial.git
   cd eks-auto-mode-tutorial
   ```

2. **Review and Modify Variables**:

   - Open the `terraform.tfvars` file and adjust variables to match your requirements, such as changing availability zones.

## Deployment

To deploy the EKS Auto Mode cluster:

1. **Initialize Terraform**:

   ```bash
   terraform init
   ```

2. **Generate Execution Plan**:

   ```bash
   terraform plan
   ```

3. **Apply Configuration**:

   ```bash
   terraform apply -auto-approve
   ```

After deployment, update your `kubectl` configuration to access the cluster:

```bash
aws eks update-kubeconfig --name <your-cluster-name> --region <your-region>
```

Replace `<your-cluster-name>` and `<your-region>` with the values specified in the `terraform.tfvars` file.

## Observing Auto-Scaling

Initially, the cluster may have no nodes since no pods are deployed. To observe node provisioning:

1. **Deploy a Sample Application**:

   Apply the `deploy.yml` file to create a BusyBox container that sleeps indefinitely.

   ```bash
   kubectl apply -f kubernetes-objects/deploy.yml
   ```

2. **Check Nodes**:

   List the nodes to see the newly created node handling the container.

   ```bash
   kubectl get nodes
   ```

As you deploy more pods, EKS Auto Mode will automatically scale nodes to meet application demands.

## Storage Management

EKS Auto Mode simplifies storage management by pre-configuring IAM permissions for the EBS CSI driver. To test persistent storage:

1. **Apply Storage Configuration**:

   Use the preconfigured YAML file in the `kubernetes-objects` folder.

   ```bash
   kubectl apply -f kubernetes-objects/storage.yml
   kubectl apply -f kubernetes-objects/pvc.yml
   ```

2. **Create a Pod**:

   Deploy a pod that writes to and reads from the persistent volume.

   ```bash
   kubectl apply -f kubernetes-objects/write_read_pod.yml
   ```

  And get the logs of the pod to see the content of the file:

  ```bash
  kubectl logs write-read-pod -c reader
  ```

## Cleanup

To remove the deployed resources:

```bash
terraform destroy -auto-approve
```

This will delete the EKS cluster and all associated resources.
