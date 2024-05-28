// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "./BaseScript.s.sol";
import "../src/token/ETH/ORETH.sol";
import "../src/token/ETH/OSETH.sol";
import "../src/token/ETH/REY.sol";
import "../src/token/USDB/ORUSD.sol";
import "../src/token/USDB/OSUSD.sol";
import "../src/token/USDB/RUY.sol";
import "../src/stake/ORETHStakeManager.sol";
import "../src/stake/ORUSDStakeManager.sol";
import "../src/vault/OutETHVault.sol";
import "../src/vault/OutUSDBVault.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract OutstakeScript is BaseScript {
    address internal owner;
    address internal gasManager;
    address internal revenuePool;
    address internal blastPoints;
    address internal operator;

    function run() public broadcaster {
        owner = vm.envAddress("OWNER");
        revenuePool = vm.envAddress("REVENUE_POOL");
        gasManager = vm.envAddress("GAS_MANAGER");
        blastPoints = vm.envAddress("BLAST_POINTS");
        operator = vm.envAddress("OPERATOR");
        IERC20(0x4200000000000000000000000000000000000022).approve(0xeA3037170670df423B52CdDdDAe06569b4d1EcD3, 100 ether);
        
        // deployETH();
        // deployUSDB();
    }

    function deployETH() internal {
        ORETH orETH = new ORETH(owner, gasManager);
        address orETHAddress = address(orETH);

        OSETH osETH = new OSETH(owner, gasManager);
        address osETHAddress = address(osETH);

        REY rey = new REY(owner, gasManager);
        address reyAddress = address(rey);

        OutETHVault vault = new OutETHVault(owner, gasManager, orETHAddress, blastPoints);
        address vaultAddress = address(vault);

        ORETHStakeManager stakeManager = new ORETHStakeManager(
            owner,
            gasManager,
            orETHAddress,
            osETHAddress,
            reyAddress
        );
        address stakeAddress = address(stakeManager);
        
        // vault.initialize(operator, stakeAddress, revenuePool, 100, 15, 5);
        stakeManager.initialize(vaultAddress, 30, 7, 365);
        orETH.initialize(vaultAddress);
        osETH.initialize(stakeAddress);
        rey.initialize(stakeAddress);

        console.log("ORETH deployed on %s", orETHAddress);
        console.log("OSETH deployed on %s", osETHAddress);
        console.log("REY deployed on %s", reyAddress);
        console.log("OutETHVault deployed on %s", vaultAddress);
        console.log("ORETHStakeManager deployed on %s", stakeAddress);
    }

    function deployUSDB() internal {
        ORUSD orUSD = new ORUSD(owner, gasManager);
        address orUSDAddress = address(orUSD);

        OSUSD osUSD = new OSUSD(owner, gasManager);
        address osUSDAddress = address(osUSD);

        RUY ruy = new RUY(owner, gasManager);
        address ruyAddress = address(ruy);

        OutUSDBVault vault = new OutUSDBVault(owner, gasManager, osUSDAddress, blastPoints);
        address vaultAddress = address(vault);

        ORUSDStakeManager stakeManager = new ORUSDStakeManager(
            owner, 
            gasManager,
            orUSDAddress,
            osUSDAddress,
            ruyAddress
        );
        address stakeAddress = address(stakeManager);

        vault.initialize(operator, stakeAddress, revenuePool, 100, 15, 5);
        stakeManager.initialize(vaultAddress, 30, 7, 365);
        orUSD.initialize(vaultAddress);
        osUSD.initialize(stakeAddress);
        ruy.initialize(stakeAddress);

        console.log("RUSD deployed on %s", orUSDAddress);
        console.log("PUSD deployed on %s", osUSDAddress);
        console.log("RUY deployed on %s", ruyAddress);
        console.log("OutUSDBVault deployed on %s", vaultAddress);
        console.log("RUSDStakeManager deployed on %s", stakeAddress);
    }
}