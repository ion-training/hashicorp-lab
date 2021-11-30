name = "nomad1"
datacenter = "dc1"
data_dir = "/opt/nomad"

bind_addr = "192.168.56.71"

server {
  enabled = true
  bootstrap_expect = 1
}

consul {
  address = "127.0.0.1:8500"
#  auth    = "admin:password"
#  token   = "abcd1234"
}


# acl {
#   enabled = true
# }

 
