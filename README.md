# Ansible Role: Terraform Project

Ansible Role that wraps around and builds a workflow for [Hashicorp Terraform](https://www.terraform.io/) projects.

[![CI](https://github.com/PyratLabs/ansible-role-terraform-project/actions/workflows/ci.yml/badge.svg)](https://github.com/PyratLabs/ansible-role-terraform-project/actions/workflows/ci.yml)

## Requirements

This role has been tested on Ansible 2.7.0+ against the following Linux Distributions:

  - Amazon Linux 2
  - CentOS 8
  - CentOS 7
  - Debian 10
  - Ubuntu 18.04 LTS
  - Ubuntu 20.04 LTS

## Disclaimer

If you have any problems please create a GitHub issue, I maintain this role in
my spare time so I cannot promise a speedy fix delivery.

## Role Variables


| Variable                  | Description                                                                    | Default Value |
|---------------------------|--------------------------------------------------------------------------------|---------------|
| `terraform_min_version`   | Specify a minimum version of Terraform, eg. `0.11.0`. Specify `false` to skip. | `false`       |
| `terraform_max_version`   | Specify a maximum version of Terraform, eg. `0.12.0`. Specify `false` to skip. | `false`       |
| `terraform_binary_path`   | Path to Terraform binary. Specify `false` to use Terraform in `${PATH}`.       | `false`       |
| `terraform_exec_projects` | List of Terraform projects to plan/apply. See example below.                   | []            |
| `terraform_destroy_all`   | Destroy all projects listed in `terraform_exec_projects` - Use with caution!   | `false`       |

## Dependencies

No dependencies on other roles.

## Example Playbook

The aim of this role is to create a workflow in Ansible that supports Terraform
workflow of "plan, then apply". It also supports ensuring that the minimum and
maximum versions of Terraform are met. (eg. If you have a pre Terraform 0.12
project that cannot be updated).


```yaml
---

- hosts: control_hosts
  become: true
  vars:
    terraform_min_version: 0.11.0
    terraform_max_version: 0.12.0
    terraform_exec_projects:
      - project_path: project/       # Required
        state: present               # Optional, default: present
        plan_file: project.tfplan    # Optional, default: project.tfplan
        state_file: project.tfstate  # Optional, default: project.tfstate
        workspace: default           # Optional, workspace to use.
        purge_workspace: false       # Optional, delete workspace on destroy?
        lock: true                   # Optional, state file locking if supported.
        lock_timeout: 300            # Optional, how long to lock if supported.
        force_init: true             # Optional
        backend_config_files:        # Optional, list of files containing backend config
          - config.hcl
        backend_config:              # Optional, key-values to provide at init stage.
          region: "eu-west-1"
          bucket: "some-bucket"
          key: "random.tfstate"
        targets:                     # Optional, list of specific resources to plan/apply to.
          some_target
        variables_file: dev.tfvars   # Optional, path to variables file.
        variables:                   # Optional, key-values for variables.
          vm_size: t3.large
  roles:
    - role: xanmanning.terraform_project
```

## License

[BSD 3-clause](LICENSE.txt)

## Author Information

[Xan Manning](https://xan.manning.io/)
