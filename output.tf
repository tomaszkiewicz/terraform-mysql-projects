output "passwords" {
  description = "Map of users and their password"
  value = {
    for k, v in random_password.password : k => v.result
  }
  sensitive = true
}
