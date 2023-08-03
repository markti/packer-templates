locals {
  execute_command     = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"  
  blobfuse_config_msi = "blobfuse-msi-config.yaml"
  blobfuse_config_key = "blobfuse-key-config.yaml"
}