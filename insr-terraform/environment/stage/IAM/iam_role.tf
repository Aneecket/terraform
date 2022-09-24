module "Stage-AWSServiceRoleForAmazonEKS" {
  source               = "../../../../modules/iam/iam-role/"
  role_name            = "stage-AWSServiceRoleForAmazonEKS-stage"
  assume_role_policy   = <<POLICY
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      }
    }
  ],
  "Version": "2012-10-17"
}
POLICY
  description          = "Allows Amazon EKS to call AWS services on your behalf."
  managed_policy_arns  = ["arn:aws:iam::aws:policy/AmazonEKSServicePolicy", "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"]
  max_session_duration = "3600"
  role_path            = "/stage-eks/"
  tags                 = {}
  inline_policy        = []
}

