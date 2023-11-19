// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract CollateralProtection {
    enum LoanCoverage {
        Partial,
        Full
    }
    // Loan taken by User
    struct Loan {
        uint256 loanAmount;
        loanStructure typeOfLoanTaken;
    }
    // Strucure of loan
    struct loanStructure {
        LoanCoverage loanCover;
        uint256 interestRate;
    }
    // Variables and mappings
    uint256 loanAmount;
    uint256 collateral;
    uint256 limit;
    uint256 repayAmount;

    Loan public loanIssued;
    LoanCoverage public cover;
    address payable public policyholder;
    mapping(address => Loan) public loans;

    // AggregatorV3Interface internal priceFeed;
    // constructor(address _policyholder) payable  {
    //     policyholder = payable(_policyholder);
    //     priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);// SEPOLIA ETH/USD
    // }

    constructor(address _policyholder) payable {
        policyholder = payable(_policyholder);
    }
    //Modifiers
    modifier loanExists() {
        require(loanIssued.loanAmount != 0, "No loan in progress");
        _;
    }

    modifier loanNotInProgress() {
        require(loanIssued.loanAmount == 0, "Loan already in progress");
        _;
    }

    modifier collateralValueDropped() {
        require(getValueInUSD(collateral) <= limit, "Collateral value has not dropped enough");
        _;
    }

    modifier collateralValueHigherThanLoan(uint256 _loanAmount, uint256 _collateral) {
        require(_collateral > _loanAmount, " Loan Value greater than Collateral Provided");
        _;
    }

    modifier validChoice(uint256 _choice) {
        require(_choice == 1 || _choice == 2, " Invalid choice");
        _;
    }
    //Function to Apply for Loan
    function applyForLoan(uint256 _loanAmount, uint256 _collateral, uint256 _choice)
        public
        collateralValueHigherThanLoan(_loanAmount, _collateral)
        validChoice(_choice)
    {
        loanAmount = _loanAmount;
        if (_choice == 1) cover = LoanCoverage.Partial;
        else if (_choice == 2) cover = LoanCoverage.Full;

        uint256 collateralVal = getValueInUSD(_collateral);
        collateral = _collateral;
        limit = (collateralVal * 9) / 10; // Setting limit to be 90% of original value
    }

    function getValueInUSD(uint256 _valueToConvert) public pure returns (uint256) {
        return _valueToConvert;
    }
    // User can take Loan if collateral value drops enough
    function takeLoan() public loanNotInProgress collateralValueDropped {
        loanStructure memory loanToTake;
        if (cover == LoanCoverage.Partial) {
            loanAmount = (loanAmount * 75) / 100; //75%
            loanToTake = loanStructure(LoanCoverage.Partial, 5);
        } else if (cover == LoanCoverage.Full) {
            //loanAmount = loanAmount; 100%
            loanToTake = loanStructure(LoanCoverage.Full, 10);
        }
        loanIssued = Loan(loanAmount, loanToTake);
        loans[policyholder] = loanIssued;
        payable(policyholder).transfer(loanAmount);
        repayAmount = loanIssued.loanAmount * ((100 + loanIssued.typeOfLoanTaken.interestRate) / 100);
    }
    // Repay loan
    function repayLoan() public payable loanExists {
        require(msg.value == repayAmount, "Not equal to Amount to be repaid");
        policyholder.transfer(repayAmount);
        delete loans[policyholder];
    }
    //Show repay amount
    function showRepayAmount() public view returns (uint256) {
        return repayAmount;
    }

    //        function getLatestEthToUsdPrice() public view returns (int) {
    //        ( ,  int price, , ,) = priceFeed.latestRoundData();
    //        return price;
    //    }

    //       function convertWeiToUsd(uint256 amountInWei) public view returns (uint256) {
    //        int ethToUsdPrice = getLatestEthToUsdPrice();
    //        uint256 amountInEth = amountInWei / 1e18; // 1e18 because 1 ETH = 1e18 Wei
    //        uint256 amountInUsd = uint256(ethToUsdPrice) * amountInEth;
    //        return amountInUsd;
    //    }

    function lowerVal() public {
        collateral = limit;
    }
}
