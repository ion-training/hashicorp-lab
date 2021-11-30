name = "client2"
datacenter = "dc1"
data_dir = "/opt/nomad"

bind_addr = "192.168.56.92"

client {
  enabled = true
  servers = ["192.168.56.71"]
  server_join {
    retry_join = [ "192.168.56.71"]
  }
}

consul {
  address = "127.0.0.1:8500"
#  auth    = "admin:password"
#  token   = "abcd1234"
}
