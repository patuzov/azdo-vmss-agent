packer {
}

source "azure-arm" "azdoagent" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id

  managed_image_resource_group_name = var.resource_group_name
  managed_image_name                = "${var.image_name}${var.image_sufix}"

  os_type         = "Linux"
  image_publisher = "Canonical"
  image_offer     = "UbuntuServer"
  image_sku       = var.image_sku

  azure_tags = {
    dept = "engineering"
  }

  location = var.location
  vm_size  = var.vm_size
}

build {
  sources = ["sources.azure-arm.azdoagent"]
  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline_shebang  = "/bin/sh -ex"
    environment_vars = [
      "LC_ALL=C.UTF-8",
      "LANG=C.UTF-8",
      "TZ=Europe/Berlin",
      "DEBIAN_FRONTEND=noninteractive"
    ]
    inline = [
      "apt-get update",
      "apt-get upgrade -y",
      "apt-get install -y apt-transport-https ca-certificates curl",

      "curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg",      
      "echo 'deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main' | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      
      "curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -",      
      "echo 'deb https://baltocdn.com/helm/stable/debian/ all main' | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list",      
      
      "apt-get update",
      
      "apt-get install -y kubectl",      
      "apt-get install -y helm"
    ]
  }
}
