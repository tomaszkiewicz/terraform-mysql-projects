variable "projects" {
  type        = list(string)
  description = "List of projects, the module will create databases based on that list"
}

variable "users" {
  description = "List of user objects"
  type = list(object({
    login = string,
    host  = string,
  }))
}
