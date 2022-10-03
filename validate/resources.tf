# Get the subnet
data "azurerm_subnet" "packer" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_vnet_name
}

# Create a NIC
resource "azurerm_network_interface" "packer" {
  name                = "nic-packer-${var.image_name}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.packer.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Get the image version
data "azurerm_shared_image_version" "example" {
  name                = var.ima
  image_name          = "my-image"
  gallery_name        = "my-image-gallery"
  resource_group_name = "example-resources"
}

# Create a VM
resource "azurerm_linux_virtual_machine" "packer" {
  name                = "vm-packer-${var.image_name}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = var.image_build_sku
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.packer.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}