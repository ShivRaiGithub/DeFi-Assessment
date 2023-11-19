"use client";
// Importing the useState hook from React
import { useState } from 'react';

// Importing the WalletInsurance and CollateralProtection components
import WalletInsurance from './walletInsurance.js';
import CollateralProtection from './collateralProtection.js';

// Exporting the Page function as a default export
export default function Page() {
  // Declaring a state variable isWalletConnected with initial value false
  const [isWalletConnected, setIsWalletConnected] = useState(false);

  // Declaring a state variable buttonClicked with initial value null
  const [buttonClicked, setButtonClicked] = useState(null);

  // Function to handle wallet connection
  const connectWallet = () => {
    // Logic to handle wallet connection goes here
    console.log("Connecting wallet...");
    setIsWalletConnected(true);
  };

  // Function to handle wallet insurance button click
  const handleWalletInsurance = () => {
    setButtonClicked('walletInsurance');
  };

  // Function to handle collateral protection button click
  const handleCollateralProtection = () => {
    setButtonClicked('collateralProtection');
  };

  // Returning the JSX for the component
  return (
    <div>
      {/* If the wallet is not connected, render the Connect Wallet button */}
      {!isWalletConnected && <button onClick={connectWallet} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Connect Wallet</button>}

      {/* If the wallet is connected, render the Wallet Insurance and Collateral Protection buttons */}
      {isWalletConnected && (
        <>
          {/* If no button has been clicked, render the Wallet Insurance and Collateral Protection buttons */}
          {!buttonClicked && (
            <>
              <button onClick={handleWalletInsurance} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Wallet Insurance</button>
              <button onClick={handleCollateralProtection} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Collateral Protection</button>
            </>
          )}

          {/* If the Wallet Insurance button has been clicked, render the Wallet Insurance component */}
          {buttonClicked === 'walletInsurance' && <div className="m-4"><WalletInsurance /></div>}

          {/* If the Collateral Protection button has been clicked, render the Collateral Protection component */}
          {buttonClicked === 'collateralProtection' && <div className="m-4"><CollateralProtection /></div>}
        </>
      )}
    </div>
  );
}
