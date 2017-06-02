# ERC-20 Token Standard REST services on Quorum

## Introduction

This sample environment provides RESTful services for creating and managing
[ERC-20 tokens](https://github.com/ethereum/EIPs/issues/20) on top of 
[Quorum](https://github.com/jpmorganchase/quorum). 

It provides a 3 node Quorum environment and RESTful service endpoints for 
interacting with each of those nodes over HTTP. These services are provided 
via the [erc20-rest-service](https://github.com/blk-io/erc20-rest-service)
which uses [web3j](https://web3j.io) and 
[Spring Boot](https://projects.spring.io/spring-boot/).

Full transaction privacy is supported.


## Usage

If you're using the [Azure VM Image](), this will configure and start both the Quorum network and the ERC-20 services:

```bash
cd ~/erc20-quorum-vm-example
./init.sh
```

Alternatively, if you have an fresh Ubuntu host (username must be *ubuntu*):

```bash
git clone https://github.com/blk-io/erc20-quorum-vm-example.git
cd erc20-quorum-vm-example
sudo ./bootstrap.sh
./init.sh
```

You will be able to access the following endpoints for interacting with 
the network (please substitute hostnames for your own):

* http://blk-io-erc20-quorum.australiaeast.cloudapp.azure.com:8080/swagger-ui.html
* http://blk-io-erc20-quorum.australiaeast.cloudapp.azure.com:8081/swagger-ui.html
* http://blk-io-erc20-quorum.australiaeast.cloudapp.azure.com:8082/swagger-ui.html

Should you wish to manage the individual environments, you can use 
the following scripts.

Quorum:

```bash
cd ~/3nodes-quorum
./raft-start.sh
# or
./stop.sh
```

REST services:

```bash
cd ~/3nodes-service
./service-start.sh
# or
./service-stop.sh
```


## Quorum node configuration

To facilitate the sending of private transactions between any 
combination of nodes, a dedicated REST service runs associated with each 
node.

| Node | Address                                    | Enclave Key                                  | Quorum Node Port | REST Service Port |
|------|--------------------------------------------|----------------------------------------------|------------------|-------------------|
| 1    | 0xed9d02e382b34818e88b88a309c7fe71e65f419d | BULeR8JyUWhiuuCMU/HLA0Q5pzkYT+cHII3ZKBey3Bo= | 22000            | 8080              |
| 2    | 0xca843569e3427144cead5e4d5999a3d0ccf92b8e | QfeDAys9MPDs2XHExtc84jKGHxZg/aj52DTh0vtA3Xc= | 22001            | 8081              |
| 3    | 0x0fbdc686b912d7722dc86510934589e0aaf3b55a | 1iTZde/ndBHvzhcl7V68x44Vx7pl8nwx9LqnM/AfJUg= | 22002            | 8082              |

The *privateFor* HTTP request header should be used for specifying the
nodes that a transaction is private between parties. Swagger provides 
support for specifying this field in addition to the request body 
attributes.


## Azure VM

An Azure VM is available at **<insert link here>** with this environment 
pre-configured.

It is recommended that you use this to run this example.


## Azure VM setup

Should you wish to setup this environment from scratch in the Azure Cloud, 
detailed instructions are below.


Install Azure command line tools:

```bash
curl -L https://aka.ms/InstallAzureCli | bash
```

*Note:* If issues with urllib see https://github.com/Azure/azure-cli/issues/3498 to resolve

Login to Azure:

```bash
az login
```
Create a resource group (use `az account list-locations` to see avilable locations):

```bash
az group create -n "erc20-quorum-group" -l australiaeast
```

Create ssh keys:

```bash
ssh-keygen -t rsa -b 2048 
```

Create an Azure VM:

```bash
az vm create -n erc20-quorum-vm -g erc20-quorum-group --image UbuntuLTS --size Standard_DS1_v2 --public-ip-address-dns-name erc20-quorum --admin-username ubuntu --ssh-key-value ~/.ssh/azure_rsa.pub
```

Open ports for Swagger UI:

```bash
az vm open-port --port 8080 --resource-group erc20-quorum-group --name erc20-quorum-vm --priority 900
az vm open-port --port 8081 --resource-group erc20-quorum-group --name erc20-quorum-vm --priority 901
az vm open-port --port 8082 --resource-group erc20-quorum-group --name erc20-quorum-vm --priority 902
```

*Note:* Operation may report failure, but in fact succeed


## VM installation

```bash
git clone https://github.com/blk-io/erc20-quorum-vm-example.git
cd erc20-quorum-vm-example
sudo ./bootstrap.sh
```

## Troubleshooting

I get the following message after running *init.sh*:

```bash
[*] Starting Constellation nodes
[*] Starting node 1
[*] Starting node 2
[*] Starting node 3
[*] Waiting for nodes to start
[*] Sending test transaction against each node
Fatal: Unable to attach to remote geth: dial unix qdata/dd1/geth.ipc: connect: no such file or directory
```

Occasionally startup fails, please try re-running *init.sh*.

