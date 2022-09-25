# Create the image definition
resource "azurerm_shared_image" "image" {
  name                = var.image_name
  gallery_name        = var.gallery_name
  resource_group_name = var.rg_name
  location            = var.location
  os_type             = var.image_type
  hyper_v_generation  = "V2"

  identifier {
    publisher = var.src_image_publisher
    offer     = var.src_image_offer
    sku       = var.src_image_sku
  }
}