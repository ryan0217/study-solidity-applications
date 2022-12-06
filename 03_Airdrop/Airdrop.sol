// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./IERC20.sol";

contract Airdrop {
  function getSum(uint256[] calldata _arr) private pure returns (uint256 sum) {
    for (uint256 i = 0; i < _arr.length; i++) {
      sum += _arr[i];
    }
  }

  function multiTransferToken(
    address _token,
    address[] calldata _addresses,
    uint256[] calldata _amounts
  ) external {
    require(
      _addresses.length == _amounts.length,
      "Lengths of Addresses and Amounts NOT EQUAL"
    );

    IERC20 token = IERC20(_token);
    uint _amountSum = getSum(_amounts);
    require(
      token.allowance(msg.sender, address(this)) >= _amountSum,
      "Need Approve ERC20 token"
    );

    for (uint8 i = 0; i < _addresses.length; i++) {
      token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
    }
  }
}
