locals {
  execute_command     = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
  telegraf_temp_dir   = "/tmp/telegraf-config"
}