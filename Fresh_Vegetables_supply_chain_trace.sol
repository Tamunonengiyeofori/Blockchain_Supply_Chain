// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "hardhat/console.sol";

//create a contract for creating entities on the blockchain network
contract supplyChain{
    address owner;
    // create public state variables to store status of registered farmers and Processors on the blockchain network
    mapping(address => bool) public registeredFarmers;
    mapping(address => bool) public registeredProcessors;
    // add a constructor to set the contract owner to the account that deploys the smart contract
    constructor(){
        owner = msg.sender;
    }
    // Create events to log function calls and allow subscription from the user end of the blokchain
    // This approach is cheaper then using storage/memory and required less gas for execution because the states of the smart contracts are not changed/modified on the blockchain network
    // The data from logs is included in the transaction receipt and stored in the transaction log. 
    // Tracking function calls is cost effective
    event farmerRegistered(uint indexed farmerId, string farmerName, string farmerLocation, address indexed newAddress);
    event processorRegistered(uint indexed processorId, string processorName, string processorLocation, address indexed newAddress);
    event ownershipChecked(address indexed newAddress);
    event cropRegistered(uint indexed id, string name, string description, address indexed owner, uint createTime);
    event cropPurchased(uint indexed id, address indexed previousOwner, address indexed newOwner);
    // create a data type to model the farmer entity
    struct Farmer{
        uint _id;
        string _name ;
        string _location;
        address _authid;
        uint _balance ;
    }
    // create a data type to model the processor entity
    struct Processor{
        uint _id;
        string _name;
        string _location;
        address _authid;
        uint balance;
        // Crop[] _purchasedCrops;
    }
    // create a data type to model created/registered Crops
    struct Crop {
        uint _productId;
        string _name;
        string _description;
        address[] _ownershipHistory;
        address _owner;
        uint _createTime;
        bool _registered;
        uint _cost;
    }
    // Store farmer and Processor object instances using an unsigned integer in a associative array(mapping)
    mapping(address => Farmer) public farmers;
    mapping(address => Processor) public processors;
    mapping(uint => Crop) public crops;

    // create publicly accessible variables to store the count of created struct entities
    uint public farmerCount = 0;
    uint public processorCount = 0;
    uint public cropCount = 0;
    // create a function modifier to limit function execution to specific accounts/entities
    // modifier onlyOwner(){
    //     require(msg.sender == owner, "Only the contract owner can Register this entity");
    //     _;
    // }
    modifier farmerExist(address _newAddress){
        require(registeredFarmers[_newAddress] == false, "Farmer with this account address already exists");
        _;
    }
    modifier onlyFarmer(address _owner){
        // require(farmers[_id]._authid == msg.sender, "Only a Farmer can Register Crops");
        require(registeredFarmers[_owner] == true, "Only a Registered Farmer can Register Crops");
        _;
    }
    modifier onlyProcessor(address _owner){
        // require(processors[_id]._authid == msg.sender, "Only a registered processor can purchase a crop");
        require(registeredProcessors[_owner] == true, "Only Registered Processors can buy crops from Farmers");
        _;
    }
    modifier processorExist(address _newAddress){
    require(registeredProcessors[_newAddress] == false, "Processor with this account address already exists");
    _;
    }
    modifier isRegistered(uint _cropId){
        require(crops[_cropId]._registered == true, "The crop must be registered");
        _;
    }
    // create functions to allow for the registration of the farmer and processor entities.
    // This function also sets the address of the created entities
    function registerFarmer(string memory _farmerName, string memory _farmerLocation, address _newAddress, uint _balance) public farmerExist(_newAddress) {
        // Create new object instance of farmer Struct
        farmers[_newAddress] = Farmer(farmerCount, _farmerName, _farmerLocation, _newAddress, _balance);
        // update the mapping storing regsitered Farmers with new farmer address
        registeredFarmers[_newAddress] = true;
        // log registerFarmer event
        emit farmerRegistered(farmerCount, _farmerName, _farmerLocation, _newAddress);
        farmerCount += 1;
    }
    function registerProcessor(string memory _name, string memory _location, address _newAddress, uint _balance) public processorExist(_newAddress){
        // Create new object instance of Processor Struct
        processors[_newAddress] = Processor(processorCount, _name, _location, _newAddress, _balance);
        // update the public array storing regsitered Processors with new processor address
        registeredProcessors[_newAddress] = true;
        // log processorRegistered event
        emit processorRegistered(processorCount, _name, _location, _newAddress);
        processorCount += 1;
    }
    // Create a function that registers crops and is limited to only farmer entities using the "onlyFarmer" modifier
    function registerCrop(string memory _name, string memory _description, uint _cost) public onlyFarmer(msg.sender) {
        crops[cropCount] = Crop(cropCount, _name, _description, new address[](0), msg.sender,block.timestamp, true, _cost);
        crops[cropCount]._ownershipHistory.push(msg.sender);
        // log resgisterCrop event
        emit cropRegistered(cropCount, _name, _description, msg.sender, block.timestamp);
        cropCount += 1;
    }
    // create a function that allows registered Processors to buy crops from farmers
    function purchaseCrop(uint _cropId) public onlyProcessor(msg.sender) isRegistered(_cropId){
        require(processors[msg.sender].balance > crops[_cropId]._cost, "You Don't gave sufficient funds to Purchase this crop");
        // calculate the balance of the transaction
        uint Transbalance = processors[msg.sender].balance - crops[_cropId]._cost;
        // console.log(Transbalance);
        //Deduct the amount spent from the Processor's Balance
        processors[msg.sender].balance = Transbalance;
        // Add the Product cost to the account of the Farmer who owns the purchased Crop
        address _owner = crops[_cropId]._owner;
        farmers[_owner]._balance += crops[_cropId]._cost;
        // call internal function to transfer ownership of the crop to Processor
        changeOwnership(_cropId);
        // log cropPurchased event
        emit cropPurchased(_cropId, crops[_cropId]._owner, msg.sender);
    }
    // Create a function to change the ownership of a Crop and update its ownership history
    function changeOwnership(uint _cropId) internal {
        // transfer ownership of the crop to the Processor
        crops[_cropId]._owner = msg.sender;
        // update the ownership history of the Crop
        crops[_cropId]._ownershipHistory.push(msg.sender);
    }
    // Create a publicly available function to check the ownership status of a Crop
    function checkCropOwnership(uint _cropId) public view returns (address) {
        // Ensure that the Crop exists
        require(_cropId < cropCount, "Invalid crop ID");
        return crops[_cropId]._owner;
    }
    // Create a function to view the ownership history of a Crop as an array of previous owner's Ethereum addresses
    function viewOwnershipHistory(uint _cropId) public view returns (address[] memory) {
        require(registeredProcessors[msg.sender] == true, "Only Processors can view the crop History");
        // Ensure that the Crop exists
        require(_cropId < cropCount, "Invalid crop ID");
        return crops[_cropId]._ownershipHistory;
    }

}



