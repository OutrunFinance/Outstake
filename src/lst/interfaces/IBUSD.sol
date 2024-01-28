// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

 /**
  * @title IBUSD interface
  */
interface IBUSD is IERC20 {
    function mint(address _account, uint256 _amount) external;

    function burn(address _account, uint256 _amount) external;

    function setUSDBStakeManager(address _address) external;

    function USDBStakeManager() external returns (address);

    event SetUSDBStakeManager(address indexed _address);
}