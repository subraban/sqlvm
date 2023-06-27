# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "sqlvm" {
  boot_disk {
    auto_delete = true
    device_name = "sqlvm"

    initialize_params {
      image = "projects/groovy-karma-388506/global/images/image-1"
      size  = 50
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-standard-2"
   metadata = {
    windows-startup-script-ps1 = "echo \"script execution in progress\"\nStart-Sleep -s 30\ninvoke-sqlcmd -serverinstance sqlserver\\sql2017 -u sa -p \"Prakash@123\" -database master -query \"CREATE DATABASE [DB1]\n CONTAINMENT = NONE\n ON  PRIMARY \n( NAME = N'DB1', FILENAME = N'C:\\Program Files\\Microsoft SQL Server\\MSSQL14.SQL2017\\MSSQL\\DATA\\DB1.mdf' , SIZE = 524288KB , FILEGROWTH = 65536KB )\n LOG ON \n( NAME = N'DB1_log', FILENAME = N'C:\\Program Files\\Microsoft SQL Server\\MSSQL14.SQL2017\\MSSQL\\DATA\\DB1_log.ldf' , SIZE = 262144KB , FILEGROWTH = 65536KB )\nGO\nALTER DATABASE [DB1] SET COMPATIBILITY_LEVEL = 140\nGO\nALTER DATABASE [DB1] SET ANSI_NULL_DEFAULT OFF \nGO\nALTER DATABASE [DB1] SET ANSI_NULLS OFF \nGO\nALTER DATABASE [DB1] SET ANSI_PADDING OFF \nGO\nALTER DATABASE [DB1] SET ANSI_WARNINGS OFF \nGO\nALTER DATABASE [DB1] SET ARITHABORT OFF \nGO\nALTER DATABASE [DB1] SET AUTO_CLOSE OFF \nGO\nALTER DATABASE [DB1] SET AUTO_SHRINK OFF \nGO\nALTER DATABASE [DB1] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)\nGO\nALTER DATABASE [DB1] SET AUTO_UPDATE_STATISTICS ON \nGO\nALTER DATABASE [DB1] SET CURSOR_CLOSE_ON_COMMIT OFF \nGO\nALTER DATABASE [DB1] SET CURSOR_DEFAULT  GLOBAL \nGO\nALTER DATABASE [DB1] SET CONCAT_NULL_YIELDS_NULL OFF \nGO\nALTER DATABASE [DB1] SET NUMERIC_ROUNDABORT OFF \nGO\nALTER DATABASE [DB1] SET QUOTED_IDENTIFIER OFF \nGO\nALTER DATABASE [DB1] SET RECURSIVE_TRIGGERS OFF \nGO\nALTER DATABASE [DB1] SET  DISABLE_BROKER \nGO\nALTER DATABASE [DB1] SET AUTO_UPDATE_STATISTICS_ASYNC OFF \nGO\nALTER DATABASE [DB1] SET DATE_CORRELATION_OPTIMIZATION OFF \nGO\nALTER DATABASE [DB1] SET PARAMETERIZATION SIMPLE \nGO\nALTER DATABASE [DB1] SET READ_COMMITTED_SNAPSHOT OFF \nGO\nALTER DATABASE [DB1] SET  READ_WRITE \nGO\nALTER DATABASE [DB1] SET RECOVERY FULL \nGO\nALTER DATABASE [DB1] SET  MULTI_USER \nGO\nALTER DATABASE [DB1] SET PAGE_VERIFY CHECKSUM  \nGO\nALTER DATABASE [DB1] SET TARGET_RECOVERY_TIME = 60 SECONDS \nGO\nALTER DATABASE [DB1] SET DELAYED_DURABILITY = DISABLED \nGO\nUSE [DB1]\nGO\nALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;\nGO\nALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;\nGO\nALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;\nGO\nALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;\nGO\nALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;\nGO\nALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;\nGO\nALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;\nGO\nALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;\nGO\nUSE [DB1]\nGO\nIF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DB1] MODIFY FILEGROUP [PRIMARY] DEFAULT\nGO\nCREATE TABLE CUSTOMERS(\n   ID   INT              NOT NULL,\n   NAME VARCHAR (20)     NOT NULL,\n   AGE  INT              NOT NULL,\n   ADDRESS  CHAR (25) ,\n   SALARY   DECIMAL (18, 2),       \n   PRIMARY KEY (ID)\n)\nGO\n\"\necho \"script has been executed successfully\""
  }
  name         = "sqlvm"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/groovy-karma-388506/regions/us-central1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "101674418114-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-central1-a"
}
