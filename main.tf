resource "mysql_database" "projects" {
  for_each = toset(var.projects)
  name     = each.value
}

resource "mysql_user" "user" {
  for_each = {
    for x in var.users : x.login => x
  }

  user               = each.key
  host               = each.value.host
  plaintext_password = random_password.password[each.key].result
}

resource "mysql_grant" "dependent" {
  for_each = mysql_user.user

  user       = each.key
  host       = each.value.host
  database   = "app"
  privileges = ["SELECT", "UPDATE"]
}

resource "random_password" "password" {
  for_each = toset([for x in var.users : x.login])

  length           = 16
  special          = true
  override_special = "_%@"
}
