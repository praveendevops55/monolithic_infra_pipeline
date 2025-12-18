rgs = {
  rg1 = {
    rg_name    = "chandra-rg-dev-001"
    location   = "West US"
    managed_by = "terraform"
    tags = {
      environment = "dev"
      owner       = "chandra"
    }
  }
  rg2 = {
    rg_name  = "chandra-rg-dev-002"
    location = "West US"
  }
}


storage_accounts = {
  sa1 = {
    sa_name                  = "chandrastorageaccdev001"
    rg_name                  = "chandra-rg-dev-001"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_2"
    tags = {
      environment = "dev"
    }
  }
}

vnets = {
  vnet1 = {
    vnet_name     = "chandra-vnet-dev-001"
    rg_name       = "chandra-rg-dev-001"
    location      = "westus"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["10.0.0.4", "10.0.0.5"]
    subnets = {
      subnet1 = {
        subnet_name      = "dev-frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet2 = {
        subnet_name      = "dev-backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
    tags = {
      environment = "dev"
    }

  }
}
pips = {
  pip1 = {
    pip_name                = "dev-frontend-pip"
    location                = "westus"
    rg_name                 = "chandra-rg-dev-001"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 30
    tags = {
      environment = "dev"
    }
  }
  pip2 = {
    pip_name                = "dev-backend-pip"
    location                = "westus"
    rg_name                 = "chandra-rg-dev-001"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 30
    tags = {
      environment = "dev"
    }
  }
}

mssql_servers = {
  mssql1 = {
    server_name                  = "chandra-mssql-dev-001"
    rg_name                      = "chandra-rg-dev-001"
    location                     = "westus"
    version                      = "12.0"
    administrator_login          = "sqladminuser"
    administrator_login_password = "P@ssword1234"
    minimum_tls_version          = "1.2"

    tags = {
      environment = "dev"
    }
  }
}

mssql_databases = {
  db1 = {
    db_name      = "chandra_mssql_db_dev_001"
    server_name  = "chandra-mssql-dev-001"
    rg_name      = "chandra-rg-dev-001"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    tags = {
      environment = "dev"
    }
  }

}

vms = {
  vm1 = {
    vm_name        = "frontend-dev-001"
    rg_name        = "chandra-rg-dev-001"
    location       = "westus"
    vm_size        = "Standard_F2"
    admin_username = "adminuser"
    admin_password = "P@ssword1234"
    script_name    = "nginx.sh"
    nic_name       = "frontend-nic-dev-001"
    subnet_name    = "dev-frontend-subnet"
    vnet_name      = "chandra-vnet-dev-001"
    pip_name       = "dev-frontend-pip"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
  vm2 = {
    vm_name        = "backend-dev-001"
    rg_name        = "chandra-rg-dev-001"
    location       = "westus"
    vm_size        = "Standard_F2"
    admin_username = "adminuser"
    admin_password = "P@ssword1234"
    script_name    = "nginx.sh"
    nic_name       = "backend-nic-dev-001"
    subnet_name    = "dev-backend-subnet"
    vnet_name      = "chandra-vnet-dev-001"
    pip_name       = "dev-backend-pip"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-LTS"
      version   = "latest"
    }
  }
}

nsgs = {
  nsg1 = {
    nsg_name = "dev-frontend-nsg"
    location = "westus"
    rg_name  = "chandra-rg-dev-001"
    security_rules = {
      sr1 = {
        rule_name                  = "rule1"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

    }

  }
  nsg2 = {
    nsg_name = "dev-backend-nsg"
    location = "westus"
    rg_name  = "chandra-rg-dev-001"
    security_rules = {
      sr2 = {
        rule_name                  = "rule2"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }

    }

  }
}
vm_nsg_associations = {
  frontend_assoication = {
    nic_name = "frontend-nic-dev-001"
    nsg_name = "dev-frontend-nsg"
    rg_name  = "chandra-rg-dev-001"
  }
  backend_assoication = {
    nic_name = "backend-nic-dev-001"
    nsg_name = "dev-backend-nsg"
    rg_name  = "chandra-rg-dev-001"
  }
}

kvs = {
  kv1 = {
    kv_name                     = "pradhanjikavault-dev"
    location                    = "westus"
    rg_name                     = "chandra-rg-dev-001"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"
    access_policies = {
      acc1 = {
        key_permissions = [
          "Get",
        ]

        secret_permissions = [
          "Get",
        ]

        storage_permissions = [
          "Get",
        ]
      }
    }
  }
}


