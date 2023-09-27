// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract StackNft is ERC20, ERC721Holder, Ownable {
    IERC721 public nft;
    mapping(uint256 => address) public tokenOwner;
    mapping(uint256 => uint256) public stakedTime;
    uint256 public rewardBase = (100 * 10 ** decimals()) / 1 days;

    constructor(address _nft) ERC20("Stack Reward", "RTK") {
        nft = IERC721(_nft);
    }

    function stake(uint256 tokenId) external {
        nft.safeTransferFrom(msg.sender, address(this), tokenId);
        tokenOwner[tokenId] = msg.sender;
        stakedTime[tokenId] = block.timestamp;
    }

    function calculateTokens(uint256 tokenId) public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - stakedTime[tokenId];
        return timeElapsed * rewardBase;
    }

    function unstake(uint256 tokenId) external {
        require(tokenOwner[tokenId] == msg.sender, "You can't unstake");
        _mint(msg.sender, calculateTokens(tokenId)); // Minting the tokens for staking
        nft.transferFrom(address(this), msg.sender, tokenId);
        delete tokenOwner[tokenId];
        delete stakedTime[tokenId];
    }
}