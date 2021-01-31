module "eks" {
  source = "github.com/binbashar/terraform-aws-eks.git?ref=v14.0.0"

  create_eks      = true
  cluster_name    = data.terraform_remote_state.shared-eks-vpc.outputs.cluster_name
  cluster_version = var.cluster_version
  enable_irsa     = false

  #
  # Network configurations
  #
  vpc_id  = data.terraform_remote_state.shared-eks-vpc.outputs.vpc_id
  subnets = data.terraform_remote_state.shared-eks-vpc.outputs.private_subnets

  #
  # Security: public vs private access (and private access rules)
  #
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_create_endpoint_private_access_sg_rule = var.cluster_create_endpoint_private_access_sg_rule
  cluster_endpoint_private_access_cidrs = [
    data.terraform_remote_state.shared-vpc.outputs.vpc_cidr_block
  ]

  #
  # Managed Nodes Default Settings
  #
  node_groups_defaults = {
    # Managed Nodes cannot specify custom AMIs, only use the ones allowed by EKS
    ami_type       = "AL2_x86_64"
    disk_size      = 50
    instance_types = ["t2.medium"]
    k8s_labels     = local.tags
  }

  #
  # List of Managed Node Groups
  #
  node_groups = {
    sample = {
      desired_capacity = 1
      max_capacity     = 3
      min_capacity     = 1
    }
  }

  #
  # Auth: Kubeconfig
  #
  kubeconfig_name                              = var.kubeconfig_name
  write_kubeconfig                             = var.write_kubeconfig
  config_output_path                           = var.config_output_path
  kubeconfig_aws_authenticator_additional_args = ["--cache"]
  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE                 = var.profile,
    AWS_CONFIG_FILE             = "$HOME/.aws/${var.project}/config",
    AWS_SHARED_CREDENTIALS_FILE = "$HOME/.aws/${var.project}/credentials"
  }

  #
  # Auth: aws-iam-authenticator
  #
  manage_aws_auth = var.manage_aws_auth
  map_roles       = var.map_roles
  map_accounts    = var.map_accounts
  map_users       = var.map_users

  #
  # Logging: which log types should be enabled and how long they should be kept for
  #
  cluster_enabled_log_types = [
    # "api",
    # "audit",
    # "authenticator",
    # "controllerManager",
    # "scheduler"
  ]
  cluster_log_retention_in_days = 7

  #
  # Tags
  #
  tags = local.tags
}