pm_api_url = "https://10.1.3.2:8006/api2/json"
pm_user = "root@pam"
pve_node = "pve"

vmconfig = {
    dns = {
        name = "DNS"
        vmid = 8002
        desc = "Pi-hole and unbound dns service"
        clone = "ubuntu-22.04-cloudimage"
        full_clone = true
        os_type = "cloud-init"
        cpu = "host"
        cores = 2
        memory = 2048
        balloon = 1024
        ipconfig0 = "ip=10.1.3.11/24,gw=10.1.3.1"
        ipconfig1 = "ip=10.1.7.11/24"
        disksize = "20G"
        onboot = true
        agent = 1
        tags = "dns;telegraf;ubuntu"
    }
    services = {
        name = "Services"
        vmid = 8003
        desc = "Docker containers server"
        clone = "ubuntu-22.04-cloudimage"
        full_clone = true
        os_type = "cloud-init"
        cpu = "host"
        cores = 4
        memory = 8192
        balloon = 1024
        ipconfig0 = "ip=10.1.3.12/24,gw=10.1.3.1"
        ipconfig1 = "ip=10.1.7.12/24"
        disksize = "64G"
        onboot = true
        agent = 1
        tags = "proxy;services;telegraf;ubuntu"
    }
    watcher = {
        name = "Watcher"
        vmid = 8004
        desc = "Monitor and loging"
        clone = "ubuntu-22.04-cloudimage"
        full_clone = true
        os_type = "cloud-init"
        cpu = "host"
        cores = 2
        memory = 4096
        balloon = 1024
        ipconfig0 = "ip=10.1.3.13/24,gw=10.1.3.1"
        ipconfig1 = "ip=10.1.7.13/24"
        disksize = "20G"
        onboot = true
        agent = 1
        tags = "telegraf;ubuntu;watcher"
    }
}