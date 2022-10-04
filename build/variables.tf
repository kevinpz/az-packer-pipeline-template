# Location to deploy the image definition
variable "location" {
  type = string
}

# RG name for the compute image gallery
variable "rg_name" {
  type = string
}

# Name of the compute image gallery
variable "gallery_name" {
  type = string
}

# Name of the image
variable "dst_image_name" {
  type = string
}

# Type of image to build
variable "image_type" {
  type = string
}

# Publisher for the image in the compute image gallery
variable "dst_image_publisher" {
  type = string
}

# Offer for the image in the compute image gallery
variable "dst_image_offer" {
  type = string
}

# SKU for the image in the compute image gallery
variable "dst_image_sku" {
  type = string
}