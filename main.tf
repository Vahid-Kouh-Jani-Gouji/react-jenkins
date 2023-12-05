module "s3" {
  source = "./modules/s3"

  bucket_name               = "jenkins-vahid-1234567890"
  bucket_encryption_enabled = true
}

module "ec2" {
  source = "./modules/ec2"

  instance_profile = module.role.instance_role_name
  instance_userdata = base64encode(templatefile("bootstrap.sh.tpl", { s3 = module.s3.s3_bucket_name}))

}


module "role" {
  source = "./modules/iam"

  role_name        = "MyEC2InstanceRole"
  policy_actions   = ["s3:*"]
  policy_effect    = "Allow"
  policy_resources = [module.s3.bucket_arn, "${module.s3.bucket_arn}/*"]
}