# Location to deploy the validation VM
variable "location" {
  type = string
}

# RG name
variable "rg_name" {
  type = string
}

# Name of the gallery where the image is located
variable "gallery_name" {
  type = string
}

# Name of the image
variable "dst_image_name" {
  type = string
}

# Type of image
variable "image_type" {
  type = string
}

# RG name of the vnet
variable "rg_vnet_name" {
  type = string
}

# Vnet name
variable "vnet_name" {
  type = string
}

# Subnet name
variable "subnet_name" {
  type = string
}

# VM sku to use
variable "image_build_sku" {
  type = string
}

# Version of the image
variable "image_version" {
  type = string
}

# VM password
variable "vm_password" {
  type = string
}