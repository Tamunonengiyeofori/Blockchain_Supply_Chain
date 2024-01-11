# Supply Chain Smart Contract

This Solidity smart contract is designed to create and manage entities on the blockchain network for a supply chain system. It allows for the registration of farmers, processors, and crops, as well as the purchase of crops by processors from farmers.

## Contract Overview

- The contract has a `supplyChain` name and is written in Solidity version 0.8.11.
- It includes the necessary state variables, data structures, mappings, and events to manage the registration and ownership of farmers, processors, and crops.
- The contract owner is set to the account that deploys the smart contract.
- Events are used to log function calls and allow subscription from the user end of the blockchain.

## Entities and Data Structures

- The contract defines the following data structures:
  - `Farmer`: Represents a farmer entity with an ID, name, location, Ethereum address, and balance.
  - `Processor`: Represents a processor entity with an ID, name, location, Ethereum address, and balance.
  - `Crop`: Represents a registered crop with a product ID, name, description, ownership history, owner, creation time, registration status, and cost.

## Functionality

The contract provides the following functionality:
- Registration of farmers and processors with their respective details and Ethereum addresses.
- Registration of crops by farmers, including the product details and cost.
- Purchase of crops by processors from farmers, with ownership transfer and balance updates for purchase costs.

The Live test Links for the smart contract deployed on the Sepolia Eth network are shown below;
- Deploy Smart Contract: https://sepolia.etherscan.io/tx/0x706f422e61240d65c30e6e8a0bb4c3d5b99563ff818a7fdff2cea7a364488e64
- Farmer Registration: https://sepolia.etherscan.io/tx/0x339ddb37054f01780d78c5c1e43fa741943f0bd2b07a5b27c0201437ec62f0b8
- Duplicate Registration Failed: https://sepolia.etherscan.io/tx/0xe9a561d11b493f355a6643d712c8470b10324d2a04832fe27e0398798e4576d8
- Processor Registration: https://sepolia.etherscan.io/tx/0xb5505e75a1f82d1afae739c9db122f48c048114b6cd4d193117be25816967048
- ---------------------: https://sepolia.etherscan.io/tx/0x304edc1469cd6115080b2a089c861e308e89d4810d9d057c0087575cf713a4b3
- Duplicate Registration Failed: https://sepolia.etherscan.io/tx/0xfce255b17a8b10f1112a139684631a273a24db38917e22bfe704f7056eb953af
- Farmer Crop Registration: https://sepolia.etherscan.io/tx/0x2fc6d931ada041b4c743eb9d7b987536f6bd733408080c29744c72a6892b8e57
- Unauthorization Crop Registration: https://sepolia.etherscan.io/tx/0x3200afef8d97757eb0136ab37e81b566c4a9e1ae6d7710342308dfdca3ce9ee4
- Processor Purchase From Farmer: https://sepolia.etherscan.io/tx/0x77b79c451c044e653dbd51c3bd2216abffe7ef37c3f2fc6443be49d53c1dc8f9
- Unauthorized Purchase Fail: https://sepolia.etherscan.io/tx/0xeb4c2d7468c24fa9a5c85adc9d2897ab0f564acda1b4d4c14819248e76234f2e
- Insufficient Funds Fail: https://sepolia.etherscan.io/tx/0xf63440a45a5ecb4b5916ca58747c82ebf67b7d55433549fe57dd477b6f259932


## Function Modifiers

The contract includes function modifiers to restrict access to specific accounts/entities, such as only allowing farmers to register crops and only allowing processors to purchase crops.

## Publicly Accessible Variables

The contract exposes publicly accessible variables to store the count of created struct entities, including the number of registered farmers, processors, and crops.

## Usage

To use this smart contract, deploy it to a compatible blockchain network and interact with it using Ethereum accounts. The contract provides functions for registering farmers, processors, and crops, as well as purchasing crops.

## License

This smart contract is released under the MIT License.
