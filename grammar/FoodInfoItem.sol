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
    }

    address private _owner;

    mapping(uint => Food) public _foods;

    modifier onlyOwner() {
        require(msg.sender == _owner);
        _;
    }

    constructor() {
        _owner = msg.sender;
    }

    function addNewFood(
        uint foodId,
        string memory name,
        string memory currentTraceName,
        uint8 quality
    ) public onlyOwner {
        require(_foods[foodId].exists == false, "Food already exists");
        Food storage newFood = _foods[foodId];
        newFood.name = name;
        newFood.status = 0;
        newFood.exists = true;
        newFood.quality = quality;
        newFood.producer = msg.sender;
        newFood.currentTraceName = currentTraceName;
    }

    function getFood(
        uint foodId
    )
        public
        view
        returns (
            string memory name,
            string memory currentTraceName,
            uint8 quality,
            uint8 status,
            address producer
        )
    {
        require(_foods[foodId].exists, "Food does not exists");
        Food memory newFood = _foods[foodId];
        return (
            newFood.name,
            newFood.currentTraceName,
            newFood.quality,
            newFood.status,
            newFood.producer
        );
    }
}
