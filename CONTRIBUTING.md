# Contributing

This repository contains 3 directories which need to be deployed in the following sequence:

1. `base`
2. `bootstrap`
3. `applications`

TODO: Replace `bootstrap` with `gitops`.
TODO: Rename `base` as `infrastructure`.

## base

`base` contains initial infrastructure and Kubernetes resources for applications to work.

This covers things like:

- Namespaces
- Workloads / Workload Identity / IAM Permissions
- Databases
- GitOps deployment tool - used for a later deployment stage.

## bootstrap

`bootstrap` contains the initial Kubernetes manifest needed by the GitOps deployment tool to know where to look for
Kubernetes resources and begin deploying them automatically.

Right now, I use Argo CD as the GitOps deployment tool, and I use the "App of Apps" pattern - therefore bootstrap simply
contains an Argo CD `Application` resource, pointing to the `applications` directory of this repo.  
This needs to be separate from `base` because Terraform does not know how to deploy an Argo CD `Application` without
Argo CD and its CRDs already being installed, which occurs as part of the `base`.

## applications

`applications` contains the manifests needed by the GitOps deployment tool to deploy the actual applications.

Right now, I use Argo CD as the GitOps deployment tool - therefore each application is an Argo CD `Application` resource
which points to a Kustomization or a Helm Chart.

## argo-cd

TODO:

- Change over from Argo CD and the bootstrap parent application, to be deployed with Skaffold instead of Terraform.
- Change over from having Kubernetes files deployed via Terraform to either Skaffold (for bootstrapping) or Argo CD. 
- Change `base` to `infrastructure`.
