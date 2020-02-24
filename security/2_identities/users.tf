#
# AWS IAM Users (alphabetically ordered)
#

#==========================#
# User: Alfredo Pardo      #
#==========================#
module "user_alfredo_pardo" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "alfredo.pardo"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/alfredo.pardo")}"
}

#==========================#
# User: Diego Ojeda        #
#==========================#
module "user_diego_ojeda" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "diego.ojeda"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/diego.ojeda")}"
}

#==========================#
# User: Exequiel Barrirero #
#==========================#
module "user_exequiel_barrirero" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "exequiel.barrirero"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/exequiel.barrirero")}"
}

#==========================#
# User: Gonzalo Martinez   #
#==========================#
module "user_gonzalo_martinez" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "gonzalo.martinez"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/gonzalo.martinez")}"
}

#==========================#
# User: Marcos Pagnucco    #
#==========================#
module "user_marcos_pagnuco" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "marcos.pagnucco"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = true
  create_iam_access_key         = false
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/marcos.pagnucco")}"
}

#
# Machine / Automation Users
#
#==========================#
# User: CircleCI           #
#==========================#
module "user_circle_ci" {
  source = "git::git@github.com:binbashar/terraform-aws-iam.git//modules/iam-user?ref=v2.6.0"

  name                    = "circle.ci"
  force_destroy           = true
  password_reset_required = true

  create_iam_user_login_profile = false
  create_iam_access_key         = true
  upload_iam_user_ssh_key       = false

  pgp_key = "${file("keys/circle.ci")}"
}
