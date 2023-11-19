// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Collateral Protection Interface
interface ICollateralProtection {
    function applyForLoan(uint256 _loanAmount, uint256 _collateral, uint256 _choice) external;
    function takeLoan() external;
    function repayLoan() external payable;
    function showRepayAmount() external view returns (uint256);
}
