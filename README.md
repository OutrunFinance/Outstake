[Gitbook](https://outrundao.gitbook.io/outrun/ "OutrunDao Official Doc")  
**Read this in chinese: [中文](README.cn.md)**  
# Outrun -- Not Only Blast L2 Native Yield Stake Protocol
_The first LSDFi protocol live on Blast._   
_The first concentrated liquidity AMM with native yield._  
_The first decentralized algorithmic stablecoin pegged to ETH and USDB yields._ 

## What's Blast? 
In Blast [Official Doc](https://docs.blast.io/about-blast "Blast Official Doc"), we can see.
> Blast is the only Ethereum L2 with native yield for ETH and stablecoins.
Blast yield comes from ETH staking and RWA protocols. The yield from these decentralized protocols is passed back to Blast users automatically. The default interest rate on other L2s is 0%. On Blast, it’s 4% for ETH and 5% for stablecoins.This yield makes it possible to create new business models for Dapps that aren’t possible on other L2s.

Based on the description above, we can understand that as long as users cross-chain their ETH to Blast, their EOA wallets will automatically start generating native yield. Similarly, smart contracts can also generate native yield, but in this case, the yield is controlled by the smart contract, and developers can withdraw the yield through Blast's interface.

## How to use native yield ?
Blast provides an interface for contracts to control the native revenue generated by assets within the contract. Detail：https://docs.blast.io/building/guides/eth-yield

For example, when developing a decentralized exchange (DEX), users establish liquidity pools by adding ETH-TOKEN liquidity to the liquidity contract address. In this contract address, the ETH will also start yielding. Developers can choose to keep the native yield for themselves, return it all to the users, distribute it to holders of their protocol token, or build more complex DeFi products. The key point here is that developers control these native yields.

## Why choose Outrun?
Native Yield is an intriguing feature that enables the possibility of constructing many new business models. However, behind this lies an overlooked aspect – whether users are willing to let developers control their native yields. What if users want to control these native yields themselves?

The emergence of Outrun addresses this issue. Outrun is a leading native yield staking solution that allows users to control the native yields generated by their assets. By staking with Outrun, users can retain control over the native yields produced by their assets. Additionally, users' tokens can maintain liquidity and be utilized across a range of DeFi applications, thereby earning additional rewards.

## Stake ETH
In the Outrun ecosystem, ETH exists in two forms:  
- RETH (Outrun Ether)
- PETH (Principal Ether)

Additionally  
- REY (RETH YieldToken) will be introduced to represent the yield rights of the staked RETH.

### RETH
RETH is a stablecoin pegged to ETH, which can be obtained at a 1:1 ratio by pledging ETH to the OutETHVault.

Therefore, 1 RETH always represents 1 ETH, and the circulating supply of RETH matches the amount of ETH in the Outrun ETH system. Users can convert RETH to ETH at any time.

Holding RETH alone does not yield native rewards generated by staking; it should be considered analogous to holding ETH.

The RETH pegging rate is defined to fluctuate within 1% on each side of the 1.00 exchange rate. This means that holding 1 RETH may exchange for ETH within the range of 1.01 to 0.9900 ETH.  

### PETH
PETH is the principal token minted by staking RETH to the RETHStakeManager, aiming to accumulate native yields and release liquidity for the staked tokens.

When users stake RETH, they need to specify a lock-up period to mint PETH and YieldToken. The quantity of PETH is not minted at a 1:1 ratio with the staked RETH. Instead, it is calculated using the following interest voucher ratio algorithm.

<div align="center">
    <img src="https://github.com/OutrunDao/Outrun/assets/32949831/1da8d6fa-3d16-4f9e-9c39-e34736fa9dd5" width="850" height="50">  
</div>

Over time, the OutETHVault can continuously generate native staking yields, and a corresponding amount of RETH is minted and added to the YieldPool. The newly staked RETH will result in a slight reduction in the minted PETH. However, regardless of the quantity of PETH minted, users can destroy the PETH minted at that time to fully redeem their staked RETH when the lock-up period expires. This design ensures that the price of PETH is better anchored to the price of ETH.

Note: PETH serves as the principal token for staking, while the staking yields generated by RETH are owned by holders of YieldToken. The design of using dual tokens aims to maximize the staking yields for RETH, as not all RETH tokens will be staked.

### REY
RETH YieldToken (REY) represents the yield rights of staked RETH, obtained by staking RETH and specifying a lock-up period. REY separates the staking yields of RETH and can be traded on secondary markets as well as used to construct other DeFi Lego pieces.

Unlike YieldTokens from other protocols currently on the market, which are typically NFTs or special FTs, they are non-fungible. This characteristic leads to a lack of liquidity for YieldTokens and reduces the protocol's composability.

Outrun's RETH YieldToken is a genuinely fungible token (FT), offering excellent liquidity and strong composability. For every 1 RETH staked for 1 day, 1 REY is minted. If _x_ RETH is staked for _y_ days, _xy_ REY will be minted. Therefore, theoretically, 1 REY is anchored to the native yield generated by staking 1 RETH for 1 day.

REY can be freely traded and can be instantly destroyed and redeemed for the accumulated native yield in the YieldPool without restrictions. When destroyed, the native yield generated is redeemed proportionally based on the number of REY destroyed compared to the total REY supply.

The existence of REY helps long-term stakers earn more income. While there might be impermanent loss (_IL_) incurred when destroying REY due to the proportional redemption of native yield based on the number of REY destroyed compared to the total REY supply, the corresponding impermanent profit (_IP_) is distributed to long-term stakers, thereby increasing their income.

### The mathematical model of REY
Although REY appears straightforward, the fact that it can be freely traded and any user holding REY can redeem native yields at any time introduces a highly complex game theory process, thereby necessitating an extremely intricate mathematical model.

The following, we construct a minimal model to calculate impermanent profit and losses.

Let's assume the current accumulated native yield in the YieldPool is 0. We denote the native yield generated by staking 1 REY for 1 day as _y_. 

User _A_ stakes _a_ amount of RETH and locks it up for _m_ days, resulting in the minting of _am_ REY tokens. We can consider the other users as a collective entity, represented by user _B_, who stakes _b_ amount of RETH and locks it up for _n_ days, resulting in the minting of _bn_ REY tokens.

After _t_ days:

<div align="center">
    <img src="https://github.com/OutrunDao/Outrun-Stake/assets/32949831/a56994fd-b2d0-42df-9e29-65ae70e68da3" width="450" height="225">  
</div>


The Impermanent Profit and Loss Ratio (_IPLR_) can be obtained by dividing the actual earnings by the expected earnings and then subtracting 1.  
_IPLR_ = (Actual Earnings / Expected Earnings) - 1

<div align="center">
    <img src="https://github.com/OutrunDao/Outrun-Stake/assets/32949831/64da270a-3fbb-42b3-a3cf-939c784e4e34" width="270" height="135">  
</div>

The impermanent profit and loss (_IPL_) can be obtained by multiplying each user's impermanent profit and loss ratio (_IPLR_) by their respective expected earnings.  
IPL_A = IPLR_A * Expected Profit_A  
IPL_B = IPLR_B * Expected Profit_B  

<div align="center">
    <img src="https://github.com/OutrunDao/Outrun-Stake/assets/32949831/ec9ea667-228f-4027-b7f3-3942fa240ee3" width="320" height="160">  
</div>

From the above figure, we can deduce that there is an impermanent profit and loss conservation between User _A_ and User _B_. If User _A_ and User _B_ lock up their assets for the same duration, both parties would experience no impermanent profit or loss. In other words, an individual user's impermanent profit and loss are correlated with the weighted average duration of other users in the staking pool.

Of course, the above is just a minimal model. The actual situation will be more complex due to the influence of multiple players in the game. Therefore, we will set a maximum lock-up time limit -- _MaxLockInterval_. The closer the user's lock-up time is to _MaxLockInterval_, the smaller the _IL_ and the larger the _IP_. Additionally, users can reduce _IL_ and obtain more _IP_ by redeeming their principal immediately upon the expiration of the lock-up period and then staking to mint REY again. When the user's lock-up time is _MaxLockInterval_, there will definitely be no _IL_.

Based on the model presented above, Outrun can help long-term stakers earn more income. We believe that ETH staking itself aims to make Ethereum more decentralized and secure. Therefore, users who contribute to the long-term protection of Ethereum should be rewarded more generously.

### Broader prospects
REY is not just a tool to help ETH long-term stakers earn more income, it is a truly fungible Yield Token and also the first decentralized algorithmic stablecoin anchored to the ETH staking yield rate in Web3. In the market dynamics, REY remains linked to the ETH staking yield rate. In the future, Outrun will leverage this feature along with the community to build more interesting products.

## Stake USDB
The native yield staking solution for USDB is similar to that of ETH, and documentation will be further improved in the future.

# OutSwap
We will enhance the concentrated liquidity automated market maker Uniswap V3 by distributing the native yield generated by trading pairs to the utilized liquidity, thereby increasing the earnings of liquidity providers.

# FF LaunchPad
Did you remember the inscription Summer from some time ago?

Imagine combining the FairLaunch feature of inscription with LaunchPad.

Issuing ERC20 tokens like inscription, users can mint tokens by paying a fee. During the minting process, the fee will be combined with a portion of the tokens reserved in the contract to form LP (liquidity provider tokens), which will be added to liquidity on Outswap. Users can set custom trade fees. The LP will be locked for a period, and after expiration, users can withdraw their minting fees and the tokens reserved to form the LP. The funds raised by the project team are the trade fees and the YieldTokens generated from the locked LP.

This model is more fair and investor-friendly. Investors essentially receive the project team's tokens for free. It also helps prevent project teams from raising a large amount of funds through traditional IDOs and then not continuing to develop the product. Developers would need to continuously iterate on the product during the LP lock-up period to attract users willing to trade their tokens, thereby incentivizing further investment.
