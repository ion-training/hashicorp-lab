# hashicorp-lab

Topology
```
  xxxxxxxxxxxxxxxxxx            xxxxxxxxxxxxxxxxxx
  x                x            x                x
  x    nomad1      x            x    consul1     x
  x                x            x                x
  xxxxxxxxxxxxxxxxxx            xxxxxxxxxxxxxxxxxx
          |.71                          |.81
          |-----------------------------|
                          |
                          | 192.168.56.0/24
                          |
          |-----------------------------|
          |.91                          |.92
  xxxxxxxxxxxxxxxxxx            xxxxxxxxxxxxxxxxxx
  x                x            x                x
  x    client1     x            x   client2      x
  x                x            x                x
  xxxxxxxxxxxxxxxxxx            xxxxxxxxxxxxxxxxxx
```

# How to use this repo

Copy the repo and cd into it
```
git clone https://github.com/ion-training/hashicorp-lab.git && cd hashicorp-lab
```

Start the LAB
```
vagrant up --provision
```

Destroy the LAB
```
vagrant destroy -f
```

# GUI access:
- Nomad: [http://192.168.56.71:4646/](http://192.168.56.71:4646/)
- Consul: [http://192.168.56.81:8500/](http://192.168.56.81:8500/)
