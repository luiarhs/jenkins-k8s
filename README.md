# Jenkins on Kubernetes with Persistent Storage

Jenkins Agents with Kubernetes

This project sets up Jenkins on a Kubernetes cluster with persistent storage using a Persistent Volume (PV) and Persistent Volume Claim (PVC). It also includes a sample Jenkins pipeline configuration.

## Project Structure

- **manifests/**: Kubernetes YAML files for Jenkins deployment.
  - `jenkins-pv.yaml`: Defines a Persistent Volume for Jenkins data.
  - `jenkins-pvc.yaml`: Defines a Persistent Volume Claim for Jenkins to use the PV.
  - `jenkins-deployment.yaml`: Deploys Jenkins with the PVC mounted to `/var/jenkins_home`.
  - `jenkins-service.yaml`: Exposes Jenkins on port 8080 via a NodePort service.
  
- **jenkins-config/**: Jenkins pipeline configuration.
  - `Jenkinsfile`: Example Jenkins pipeline with Kubernetes-based agents.

## Getting Started

### 1. Deploy Jenkins to Kubernetes

To deploy Jenkins with persistent storage on Kubernetes, apply the manifests:

```bash
kubectl apply -f manifests/jenkins-pv.yaml
kubectl apply -f manifests/jenkins-pvc.yaml
kubectl apply -f manifests/jenkins-deployment.yaml
kubectl apply -f manifests/jenkins-service.yaml
