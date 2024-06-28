variable "bucket" {
    description = "The bucket name where the static website will be hosted."
    type        = string
  
}
variable "default_document" {
    default = "index.html"
    type = string
  
}
variable "error_document" {
    default = "error.html"
    type = string
}
variable "domain" {
    default = "isaacmamman.me"
    type = string
  
}