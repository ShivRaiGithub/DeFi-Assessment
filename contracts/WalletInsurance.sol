// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract WalletInsurance {
    enum InsurancePackage {
        Small,
        Regular,
        Large
    }

    struct Policy {
        InsurancePackage insurancePackage;
        uint256 nextPaymentDue;
        uint256 totalAmountPaid;
    }

    address payable policyholder;

    mapping(address => Policy) policies;

    mapping(InsurancePackage => uint256) insuranceAmountToPay;

    constructor(address _policyholder) payable {
        policyholder = payable(_policyholder);
        insuranceAmountToPay[InsurancePackage.Small] = 1000;
        insuranceAmountToPay[InsurancePackage.Regular] = 10000;
        insuranceAmountToPay[InsurancePackage.Large] = 100000;
    }

    modifier insuranceExists() {
        require(policies[policyholder].nextPaymentDue != 0, "No insurance bought");
        _;
    }

    modifier insuranceCanBeBought() {
        require(policies[policyholder].nextPaymentDue == 0, "Insurance already bought");
        _;
    }

    modifier paymentDue() {
        require(policies[policyholder].nextPaymentDue < block.timestamp, "Payment not yet due");
        _;
    }

    modifier canBeClaimed() {
        require(policies[policyholder].nextPaymentDue <= block.timestamp, "Claim not yet possible");
        _;
    }

    modifier validChoice(uint256 _choice) {
        require(_choice > 0 && _choice < 4, "Not a valid choice");
        _;
    }

    function buyInsurance(uint256 _choice) external payable insuranceCanBeBought validChoice(_choice) {
        InsurancePackage insurancePackage;
        if (_choice == 1) {
            insurancePackage = InsurancePackage.Small;
        } else if (_choice == 2) {
            insurancePackage = InsurancePackage.Regular;
        } else {
            insurancePackage = InsurancePackage.Large;
        }
        uint256 amount = insuranceAmountToPay[insurancePackage];
        require(msg.value >= amount, "Not enough Ether provided.");
        policies[policyholder] = Policy(
            insurancePackage,
            block.timestamp, // + 28 days
            msg.value
        );
        policyholder.transfer(msg.value);
    }

    function makePayment() external payable insuranceExists paymentDue {
        uint256 amount = insuranceAmountToPay[policies[policyholder].insurancePackage];
        require(msg.value >= amount, "Not enough Ether provided.");
        policies[policyholder].nextPaymentDue = block.timestamp; //+ 28 days;
        policies[policyholder].totalAmountPaid += msg.value;
        policyholder.transfer(msg.value);
    }

    function claimInsurance() external insuranceExists canBeClaimed {
        payable(policyholder).transfer(policies[policyholder].totalAmountPaid * 2);
        delete policies[policyholder];
    }
}
