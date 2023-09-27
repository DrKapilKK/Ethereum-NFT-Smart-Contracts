/**
 *Submitted for verification at Etherscan.io on 2022-10-13
*/

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.16;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract GasF is ERC20 {
    constructor() ERC20("GasFac", "GF") {
        //_mint(msg.sender, 50);
    }

    function mint(uint256 _qty) public{
        _mint(msg.sender, _qty);
    }
}
