// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//Importing required contracts and interfaces
import "./WalletInsurance.sol";
import "./CollateralProtection.sol";
import "./IWalletInsurance.sol";
import "./ICollateralProtection.sol";

contract InsuranceProvider {
    address payable admin;
    //Creating Mappings
    mapping(address => IWalletInsurance) internal walletInsurances;
    mapping(address => ICollateralProtection) internal collateralProtections;
    //Interfaces
    IWalletInsurance internal iwalletInsurance;
    ICollateralProtection internal icollateralProtection;

    constructor() {
        admin = payable(msg.sender);
    }
    //Modifiers
    modifier walletInsuranceOpted() {
        require(address(walletInsurances[admin]) != address(0), "Wallet Insurance Not Opted for");
        _;
    }

    modifier collateralProtectionOpted() {
        require(address(collateralProtections[admin]) != address(0), "Collateral Protection Not Opted for");
        _;
    }
    //Wallet Insurance Functions for Interfaces
    function walletBuyInsurance(uint256 _choice) public walletInsuranceOpted {
        iwalletInsurance.buyInsurance(_choice);
    }

    function walletMakePayment() public payable walletInsuranceOpted {
        iwalletInsurance.makePayment{value: msg.value}();
    }

    function walletClaimInsurance() public walletInsuranceOpted {
        iwalletInsurance.claimInsurance();
    }

    //Collateral Protection Functions for Interfaces
    function collateralApplyForLoan(uint256 _loanAmount, uint256 _collateral, uint256 _choice)
        public
        collateralProtectionOpted
    {
        icollateralProtection.applyForLoan(_loanAmount, _collateral, _choice);
    }

    function collateralTakeLoan() public collateralProtectionOpted {
        icollateralProtection.takeLoan();
    }

    function collateralShowRepayAmount() public view collateralProtectionOpted {
        icollateralProtection.showRepayAmount();
    }

    function collateralRepayLoan() public payable collateralProtectionOpted {
        icollateralProtection.repayLoan{value: msg.value}();
    }
    //Creaing Wallet Insurance Interface
    function createWalletInsurance() public {
        require(address(walletInsurances[msg.sender]) == address(0), "Wallet insurance already created");
        WalletInsurance walletInsurance = new WalletInsurance(msg.sender);
        iwalletInsurance = IWalletInsurance(address(walletInsurance));
        walletInsurances[msg.sender] = iwalletInsurance;
    }
    //Creating Collateral Protection Interface
    function createCollateralProtection() public {
        require(address(collateralProtections[msg.sender]) == address(0), "Collateral protection already created");
        CollateralProtection collateralProtection = new CollateralProtection(msg.sender);
        icollateralProtection = ICollateralProtection(address(collateralProtection));
        collateralProtections[msg.sender] = icollateralProtection;
    }
}
