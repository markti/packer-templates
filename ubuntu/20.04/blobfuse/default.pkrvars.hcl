location               = "westus"
image_name             = "ubuntu2004-blobfuse"
vm_size                = "Standard_D4s_v5"
gallery_resource_group = "rg-aztf-machine-images-dev"
gallery_name           = "galaztfmachineimagesdev"
replication_regions    = [
                           "West US", 
                           "West US 3",
                           "East US", 
                           "South Central US"
                         ]
blobfuse_config_path   = "/opt/blobfuse2"
blobfuse_mount_dir     = "/mnt/blobfuse"