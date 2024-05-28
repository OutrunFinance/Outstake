// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "./interfaces/IOSUSD.sol";
import "../../blast/GasManagerable.sol";
import "../../utils/Initializable.sol";

/**
 * @title Outrun staked USDB
 */
contract OSUSD is IOSUSD, ERC20, Initializable, Ownable, GasManagerable {
    address private _orUSDStakeManager;

    modifier onlyORUSDStakeManager() {
        if (msg.sender != _orUSDStakeManager) {
            revert PermissionDenied();
        }
        _;
    }

    constructor(address owner, address gasManager) ERC20("Outrun staked USDB", "osUSD") Ownable(owner) GasManagerable(gasManager) {}

    function ORUSDStakeManager() external view override returns (address) {
        return _orUSDStakeManager;
    }

    /**
     * @dev Initializer
     * @param stakeManager_ - Address of orUSDStakeManager
     */
    function initialize(address stakeManager_) external override initializer {
        setORUSDStakeManager(stakeManager_);
    }

    /**
     * @dev Only orUSDStakeManager can mint when the user stake orUSD
     * @param _account Address who stake orUSD 
     * @param _amount The amount of deposited orUSD
     */
    function mint(address _account, uint256 _amount) external override onlyORUSDStakeManager{
        _mint(_account, _amount);
    }

    /**
     * @dev Only orUSDStakeManager can burn when the user redempt the orUSD 
     * @param _account Address who redempt the orUSD
     * @param _amount The amount of redempt orUSD
     */
    function burn(address _account, uint256 _amount) external override onlyORUSDStakeManager {
        _burn(_account, _amount);
    }

    function setORUSDStakeManager(address _stakeManager) public override onlyOwner {
        _orUSDStakeManager = _stakeManager;
        emit SetORUSDStakeManager(_stakeManager);
    }
}