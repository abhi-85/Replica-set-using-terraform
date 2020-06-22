provider "kubernetes"{ 
  config_context_cluster = "minikube" 
}

resource "kubernetes_deployment" "myrs1" { 
  metadata { 
    name = "myreplicset" 
    labels = { 
      test = "replicasettest" 
    } 
  } 
  spec { 
    replicas = 1 
    selector { 
      match_labels = { 
        env = "dev" 
        dc = "IN" 
        app = "webserver" 
      } 
      match_expressions {  
        key = "dc" 
        operator = "In" 
        values = [ "IN" , "US" ] 
      } 
      match_expressions { 
        key = "env" 
        operator = "In" 
        values = [ "dev" ] 
      } 
      match_expressions { 
        key = "app" 
        operator = "In" 
        values = [ "webserver" ] 
      }
  } 
template { 
  metadata { 
    name = "pod1" 
    labels = { 
      dc = "IN" 
      env = "dev" 
      app = "webserver" 
    } 
  } 
  spec { 
    container { 
      image = "mysql:5.7" 
      name = "rc1" 
      env {
        name  = "MYSQL_ROOT_PASSWORD"
        value = "redhat"
      }
        env {
        name  = "MYSQL_DATABASE"
        value = "mydb"
      }
        env {
        name  = "MYSQL_USER"
        value = "abhi"
      }
        env {
        name  = "MYSQL_PASSWORD"
        value = "abhipass"
      }
    } 
  } 
} 
}
}

resource "kubernetes_deployment" "myrs2" { 
  metadata { 
    name = "myreplicsetwp" 
    labels = { 
      test = "replicasettest" 
    } 
  }
   spec { 
    replicas = 1 
    selector { 
      match_labels = {  
          env: "dev"
          app: "wp"
      }
      match_expressions { 
        key = "env" 
        operator = "In" 
        values = [ "dev" ] 
      } 
      match_expressions { 
        key = "app" 
        operator = "In" 
        values = [ "wp" ] 
      }
  } 
  template { 
    metadata { 
      name = "pod1" 
      labels = {  
      env = "dev" 
      app = "wp" 
    } 
  } 
  spec { 
    container { 
      image = "wordpress:5.1.1" 
      name = "rc2" 
    }
  }
}
}
}