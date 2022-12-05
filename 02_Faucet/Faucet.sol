// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract Faucet {
  event SendToken(address indexed Receiver, uint256 indexed Amount);

  uint256 public constant amountAllowed = 100;
  address public immutable tokenContract;
  mapping(address => bool) public requestedAddress;

  constructor(address _tokenContract) {
    tokenContract = _tokenContract;
  }

  function requestTokens() external {
    require(
      requestedAddress[msg.sender] == false,
      "Can't Request Multiple Times!"
    );
    IERC20 token = IERC20(tokenContract);
    require(token.balanceOf(address(this)) > amountAllowed, "Faucet Empty!");

    token.transfer(msg.sender, amountAllowed);
    requestedAddress[msg.sender] = true;

    emit SendToken(msg.sender, amountAllowed);
  }
}
