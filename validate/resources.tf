# Create the resource group
resource "azurerm_resource_group" "rg_image" {
  name     = "rg-packer-validate-${var.dst_image_name}"
  location = var.location
}

# Get the subnet
data "azurerm_subnet" "packer" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_vnet_name
}

# Create a NIC
resource "azurerm_network_interface" "packer" {
  name                = "nic-packer-${var.dst_image_name}"
  location            = azurerm_resource_group.rg_image.location
  resource_group_name = azurerm_resource_group.rg_image.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.packer.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Get the image version
data "azurerm_shared_image_version" "packer" {
  name                = var.image_version
  image_name          = var.dst_image_name
  gallery_name        = var.gallery_name
  resource_group_name = var.rg_name
}

# Create a VM
resource "azurerm_linux_virtual_machine" "packer" {
  name                = "vm-packer-${var.dst_image_name}"
  resource_group_name = azurerm_resource_group.rg_image.name
  location            = azurerm_resource_group.rg_image.location
  size                = var.image_build_sku
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.packer.id,
  ]
  disable_password_authentication = false
  admin_password = var.vm_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = azurerm_shared_image_version.packer.id
}

# Get the IP address
output "vm_ip_addr" {
  value = azurerm_network_interface.packer.private_ip_address
}