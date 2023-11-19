// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Wallet Insurance Interface
interface IWalletInsurance {
    function buyInsurance(uint256 _choice) external payable;
    function makePayment() external payable;
    function claimInsurance() external;
}
