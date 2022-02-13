// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Library {
    struct Thing {
        uint256 _id;
        string _description;
        Category _category;
    }

    struct ThingItem {
        uint256 _id;
        uint256 _thing;
        address _holder;
    }

    enum Category { DIY, Adventure }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    string public name;
    address owner;

    uint256 public thingsCount = 0;
    uint256 public inventoryCount = 0;

    mapping(uint256 => Thing) public things;
    mapping(uint256 => ThingItem) public inventory;
    mapping(address => mapping(uint256 => uint256)) public borrowedItems;

    constructor(string memory _name) {
        name = _name;
        owner = msg.sender;
    }

    function addThing(string memory _description, Category _category) public onlyOwner returns (Thing memory) {
        Thing memory thing = Thing(thingsCount, _description, _category);
        things[thingsCount] = thing;
        thingsCount += 1;
        return thing;
    }

    function removeThing(uint256 _id) public onlyOwner {
        delete things[_id];
        thingsCount -= 1;
    }

    function addItem(uint256 _thing) public onlyOwner {
        inventory[inventoryCount] = ThingItem(inventoryCount, _thing, owner);
        inventoryCount += 1;
    }

    function removeItem(uint256 _id) public onlyOwner {
        delete inventory[_id];
        inventoryCount -= 1;
    }

    function borrowItem(uint256 _id) public {
        inventory[_id]._holder = msg.sender;
        borrowedItems[msg.sender][_id] = block.timestamp;
    }

    function returnItem(uint256 _id) public {
        inventory[_id]._holder = owner;
        delete borrowedItems[msg.sender][_id];
    }
}