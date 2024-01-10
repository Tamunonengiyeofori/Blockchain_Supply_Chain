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
- Purchase of crops by processors from farmers, with ownership transfer and balance updates.

## Function Modifiers

The contract includes function modifiers to restrict access to specific accounts/entities, such as only allowing farmers to register crops and only allowing processors to purchase crops.

## Publicly Accessible Variables

The contract exposes publicly accessible variables to store the count of created struct entities, including the number of registered farmers, processors, and crops.

## Usage

To use this smart contract, deploy it to a compatible blockchain network and interact with it using Ethereum accounts. The contract provides functions for registering farmers, processors, and crops, as well as purchasing crops.

## License

This smart contract is released under the MIT License.
