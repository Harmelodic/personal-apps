# personal-apps

Central repo for the deployment of Personal Applications.

This is a central point for a GitOps tool (Argo CD) to start at when looking for Applications to deploy, as part of my
Personal projects.

## Repo structure

This repository contains 3 directories which need to be deployed in the following sequence:

1. `infrastructure`
2. `gitops-argo-cd`
3. `manifests`

### infrastructure

`infrastructure` contains initial infrastructure for applications to work.

This covers things like:

- Namespaces
- Workloads / Workload Identity / IAM Permissions
- Databases
- GitOps deployment tool - used for a later deployment stage.

### gitops-argo-cd

`gitops-argo-cd` contains the initial Kubernetes manifests needed to run a Kubernetes-GitOps tool (in this case: Argo
CD) to get up and running, and some kind of "bootstrap" mechanism to trigger that tool to deploy all other resources to
Kubernetes.

To do this bootstrapping, I use the "App of Apps" pattern. This involves setting a "parent" Argo CD `Application`
resource, which points to the `manifests` directory of this repo.

This is deployed using Skaffold, as deploying Kubernetes / Helm from Terraform is not reliable or a good developer
experience.

### manifests

`manifests` contains the manifests needed by the GitOps deployment tool to deploy the actual applications.

Right now, I use Argo CD as the GitOps deployment tool - therefore each application is an Argo CD `Application` resource
which points to a Kustomization or a Helm Chart.

- TODO: Refactor manifests to have environments, rather than the entire directory be "prod".
