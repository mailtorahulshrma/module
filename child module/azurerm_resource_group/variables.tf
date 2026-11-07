variable "rgs" {
  description = "Resource groups keyed by a stable identifier."
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  default = {}
}
