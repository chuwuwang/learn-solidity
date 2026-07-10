// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract FoodInfoItem {

    struct Food {
        string name;
        string currentTraceName;
        uint8 quality;
        uint8 status;
        address producer;
        
        bool exists;

        TraceInfo[] traceInfos;
        mapping(address => bool) purchasedUsers;
    }

    struct TraceInfo {
        uint timestamp;
        string traceName;
        address traceAddress;
        uint8 traceQuality;
    }

    address public _owner;

    mapping(uint => Food) public _foods;

    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function addNewFood(uint foodId, string memory name, string memory currentTraceName, uint8 quality) public onlyOwner {
        require(_foods[foodId].exists == false, "Food already exists");
        Food storage newFood = _foods[foodId];
        newFood.name = name;
        newFood.status = 0;
        newFood.exists = true;
        newFood.quality = quality;
        newFood.producer = msg.sender;
        newFood.currentTraceName = currentTraceName;
    }

    function getFood(uint foodId) public view returns (string memory name, string memory currentTraceName, uint8 quality, uint8 status, address producer) {
        require(_foods[foodId].exists, "Food does not exists");

        Food storage newFood = _foods[foodId];
        
        return (newFood.name, newFood.currentTraceName, newFood.quality, newFood.status, newFood.producer);
    }

    function addTraceInfoByDistributor(uint foodId, string memory traceName, address distributor, uint8 quality) public onlyOwner returns (bool) {
        require(_foods[foodId].exists, "Food does not exist");
        require(quality <= 10, "Quality exceeds the limit of quality");

        Food storage food = _foods[foodId];

        require(food.status == 0, "The product is already produced");

        TraceInfo memory traceInfo = TraceInfo(block.timestamp, traceName, distributor, quality);
        food.traceInfos.push(traceInfo);
        food.currentTraceName = traceName;
        food.status = 1;
        return true;
    }
    
}