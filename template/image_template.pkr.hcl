source "azure-arm" "vm" {
    image_offer                       = var.src_image_offer
    image_publisher                   = var.src_image_publisher
    image_sku                         = var.src_image_sku
    location                          = var.location
    managed_image_name                = var.image_name
    managed_image_resource_group_name = var.rg_name
    os_type                           = var.image_type
    vm_size                           = var.image_build_sku
  }
  
  build {
    sources = ["source.azure-arm.vm"]
  
    provisioner "shell" {
      execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
      inline          = ["apt-get update", "apt-get upgrade -y", "apt-get -y install nginx", "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
      inline_shebang  = "/bin/sh -x"
    }
  
  }