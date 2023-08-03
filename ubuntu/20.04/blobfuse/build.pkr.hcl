build {
  sources = [
    "source.azure-arm.vm"
  ]

  ### INSTALL PRE-REQS ###
  provisioner "shell" {
    execute_command = local.execute_command
    pause_before = "30s"
    start_retry_timeout = "5m"
    inline = [
      "echo \"DEBUG####: sudo apt update -y && sleep 30 && sudo apt upgrade -y\"",
      "sudo apt update -y && sleep 30 && sudo apt upgrade -y",
      "export DEBIAN_FRONTEND='noninteractive'"
      ]
  }

  ### INSTALLL BLOBFUSE ###
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "wget https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb", 
      "dpkg -i packages-microsoft-prod.deb",
      "apt-get update",
      "apt-get -y install libfuse3-dev fuse3",
      "apt-get -y install blobfuse2"
    ]
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["mkdir -p ${var.blobfuse_mount_dir}"]
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = ["mkdir -p ${var.blobfuse_config_path}"]
  }
  # Blobfuse v2 config drop - MSI
  provisioner "file" {
    source = "./files/${local.blobfuse_config_msi}"
    destination = "/tmp/${local.blobfuse_config_msi}"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/${local.blobfuse_config_msi} ${var.blobfuse_config_path}/${local.blobfuse_config_msi}"
      ]
  }
  # Blobfuse v2 config drop - ACCOUNT KEY
  provisioner "file" {
    source = "./files/${local.blobfuse_config_key}"
    destination = "/tmp/${local.blobfuse_config_key}"
  }
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "cp /tmp/${local.blobfuse_config_key} ${var.blobfuse_config_path}/${local.blobfuse_config_key}"
      ]
  }

  ### SYSPREP ###
  provisioner shell {
    execute_command = local.execute_command
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only = ["azure-arm"]
  }

}