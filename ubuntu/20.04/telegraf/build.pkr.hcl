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

  ### INSTALLL TELEGRAF ###
  # adding influxdata Repo to support installing telegraf
  provisioner "shell" {
    execute_command = local.execute_command
    pause_before = "60s"
    start_retry_timeout = "3m"
    inline = [
      "echo \"DEBUG####: adding influxdata Repo to support installing telegraf\"",
      "wget -qO- https://repos.influxdata.com/influxdata-archive_compat.key | sudo apt-key add -",
      "echo \"deb https://repos.influxdata.com/ubuntu bionic stable\" | sudo tee /etc/apt/sources.list.d/influxdb.list",
      "export DEBIAN_FRONTEND='noninteractive'"
    ]
  }

# performing sudo apt-get update to update all of the repos
  provisioner shell {
    execute_command = local.execute_command
    script = "./scripts/check_lock.sh"
  }
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

  provisioner "shell" {
    execute_command = local.execute_command
    pause_before = "30s"
    start_retry_timeout = "3m"
    inline = [
      "echo \"DEBUG####: installing a few things for ease of troubleshooting\"",
      "sudo apt-get install ncdu htop traceroute jq tree -y",
      "export DEBIAN_FRONTEND='noninteractive'"
      ]
  }

  provisioner "shell" {
    execute_command = local.execute_command
    pause_before = "30s"
    start_retry_timeout = "3m"
    inline = [
      "echo \"DEBUG####: installing a few things for ease of troubleshooting\"",
      "sudo apt-get install telegraf -y",
      "export DEBIAN_FRONTEND='noninteractive'"
      ]
  }

  # make temp dir
  provisioner "shell" {
    execute_command = local.execute_command
    inline = [
      "mkdir -p ${local.telegraf_temp_dir}",
      "chmod 777 ${local.telegraf_temp_dir}"
      ]
  }
  # copy files to temp dir
  provisioner file {
    sources = [ 
      "./files/telegraf.conf",
      "./files/telegraf-default"
    ]
    destination = "${local.telegraf_temp_dir}/"
  }
  # move files into test runner home
  provisioner shell {
    execute_command = local.execute_command
    inline = [
      "cp -f ${local.telegraf_temp_dir}/telegraf.conf /etc/telegraf/telegraf.conf",
      "cp -f ${local.telegraf_temp_dir}/telegraf-default /etc/default/telegraf"
      ]
  }

  ### SYSPREP ###
  provisioner shell {
    execute_command = local.execute_command
    inline = ["/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"]
    only = ["azure-arm"]
  }

}