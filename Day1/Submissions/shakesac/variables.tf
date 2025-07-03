variable "environment" {
  # Invalid: Missing type
  description = "Environment name"
}

variable "bucket_name" {
  type = string
  # Invalid: Missing description
  default = 123  # Invalid: Type mismatch (number for string)
}

variable "tags" {
  type = map
  # Invalid: Malformed default value
  default = {
    Environment = 
    Project = TerraformChallenge
  }
}

# Invalid: Malformed variable block
variable "owner" 
  type = "string"  # Invalid: Deprecated type syntax
  default = "shakesac"
} 