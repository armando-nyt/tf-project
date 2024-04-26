# loads secrets from local  files
data "local_file" "account_key" {
  filename = "../secrets/aws-key"
}

data "local_file" "account_secret" {
  filename = "../secrets/aws-secret"
}
