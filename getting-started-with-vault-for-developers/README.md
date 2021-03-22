# Getting Started With Vault For Developers

## Shipyard

All example patterns in this repository use [Shipyard](https://shipyard.run) to deploy local development environments in order to run the example patterns. 

Shipyard can be installed on MacOS and linux by running the following command:

```sh
curl https://shipyard.run/install | bash
```

Shipyard can be installed on Windows using Chocolatey by running the following command:
```sh
choco install shipyard
```

## Vault CLI

Though all examples use the the Vault API directly, it may be useful to have the CLI locally. The Vault cli is bundled into the Vault binary and can be downloaded directly from the [HashiCorp releases page,](https://releases.hashicorp.com/vault/) and placed on the system PATH.

To install the Vault CLI on MacOS using brew, run the following command:

```sh
brew tap hashicorp/tap && brew install hashicorp/tap/vault
```

To install the Vault CLI on Windows using chocolatey, run the following command:

```sh
choco install vault
```