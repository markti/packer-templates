build {
  sources = [
    "source.azure-arm.vm"
  ]

  ### INSTALL PRE-REQS ###
  provisioner shell {
    execute_command = local.execute_command
    inline = ["apt update && apt upgrade -y"]
  }

  ### SYSPREP ###
  provisioner shell {
    execute_command = local.execute_command
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only = ["azure-arm"]
  }

}