// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract PiggyBank {

    event Deposit(uint amount);

    event Withdraw(uint amount);

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not onwer");
        uint amount = address(this).balance;
        emit Withdraw(amount);
        payable(owner).transfer(amount);
    }
    
}
