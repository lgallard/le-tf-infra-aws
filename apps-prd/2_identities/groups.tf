#
# Groups
#
module "iam_group_auditors" {
  source = "github.com/binbashar/terraform-aws-iam.git//modules/iam-group-with-policies?ref=v2.9.0"
  name = "auditors"

  group_users = [
    module.user_auditor_ci.this_iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess",
  ]
}
