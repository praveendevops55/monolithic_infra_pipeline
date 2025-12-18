rgs = {
  rg1 = {
    rg_name    = "chandra-rg-prod-001"
    location   = "West US"
    managed_by = "terraform"
    tags = {
      environment = "prod"
      owner       = "chandra"
    }
  }
  rg2 = {
    rg_name  = "chandra-rg-prod-002"
    location = "West US"
  }
}


storage_accounts = {
  sa1 = {
    sa_name                  = "chandrastorageaccprod001"
    rg_name                  = "chandra-rg-prod-001"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    min_tls_version          = "TLS1_2"
    tags = {
      environment = "prod"
    }
  }
}

vnets = {
  vnet1 = {
    vnet_name     = "chandra-vnet-prod-001"
    rg_name       = "chandra-rg-prod-001"
    location      = "westus"
    address_space = ["10.0.0.0/16"]
    dns_servers   = ["10.0.0.4", "10.0.0.5"]
    subnets = {
      subnet1 = {
        subnet_name      = "prod-frontend-subnet"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet2 = {
        subnet_name      = "prod-backend-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
    tags = {
      environment = "prod"
    }

  }
}
pips = {
  pip1 = {
    pip_name                = "prod-frontend-pip"
    location                = "westus"
    rg_name                 = "chandra-rg-prod-001"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 30
    tags = {
      environment = "prod"
    }
  }
  pip2 = {
    pip_name                = "prod-backend-pip"
    location                = "westus"
    rg_name                 = "chandra-rg-prod-001"
    allocation_method       = "Static"
    idle_timeout_in_minutes = 30
    tags = {
      environment = "prod"
    }
  }
}

mssql_servers = {
  mssql1 = {
    server_name                  = "chandra-mssql-prod-001"
    rg_name                      = "chandra-rg-prod-001"
    location                     = "westus"
    version                      = "12.0"
    administrator_login          = "sqladminuser"
    administrator_login_password = "P@ssword1234"
    minimum_tls_version          = "1.2"

    tags = {
      environment = "prod"
    }
  }
}

mssql_databases = {
  db1 = {
    db_name      = "chandra_mssql_db_prod_001"
    server_name  = "chandra-mssql-prod-001"
    rg_name      = "chandra-rg-prod-001"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
    tags = {
      environment = "prod"
    }
  }

}

vms = {
  vm1 = {
    vm_name        = "frontend-prod-001"
    rg_name        = "chandra-rg-prod-001"
    location       = "westus"
    vm_size        = "Standard_B1s"
    admin_username = "adminuser"
    admin_password = "P@ssword1234"
    script_name    = "nginx.sh"
    nic_name       = "frontend-nic-prod-001"
    subnet_name    = "prod-frontend-subnet"
    vnet_name      = "chandra-vnet-prod-001"
    pip_name       = "prod-frontend-pip"
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
    vm_name        = "backend-prod-001"
    rg_name        = "chandra-rg-prod-001"
    location       = "westus"
    vm_size        = "Standard_B1s"
    admin_username = "adminuser"
    admin_password = "P@ssword1234"
    script_name    = "nginx.sh"
    nic_name       = "backend-nic-prod-001"
    subnet_name    = "prod-backend-subnet"
    vnet_name      = "chandra-vnet-prod-001"
    pip_name       = "prod-backend-pip"
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
}

nsgs = {
  nsg1 = {
    nsg_name = "prod-frontend-nsg"
    location = "westus"
    rg_name  = "chandra-rg-prod-001"
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
    nsg_name = "prod-backend-nsg"
    location = "westus"
    rg_name  = "chandra-rg-prod-001"
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
    nic_name = "frontend-nic-prod-001"
    nsg_name = "prod-frontend-nsg"
    rg_name  = "chandra-rg-prod-001"
  }
  backend_assoication = {
    nic_name = "backend-nic-prod-001"
    nsg_name = "prod-backend-nsg"
    rg_name  = "chandra-rg-prod-001"
  }
}

kvs = {
  kv1 = {
    kv_name                     = "pradhanjikavault-prod"
    location                    = "westus"
    rg_name                     = "chandra-rg-prod-001"
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


