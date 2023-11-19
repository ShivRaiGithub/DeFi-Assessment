// Import necessary hooks and router from Next.js and React
import { useRouter } from 'next/router';
import { useState, useEffect } from 'react';

// Define the WalletInsurance component
export default function WalletInsurance() {
  // Initialize router
  const router = useRouter()

  // Initialize state variables
  const [selectedOption, setSelectedOption] = useState(''); // Selected insurance package
  const [packageBought, setPackageBought] = useState(''); // Bought insurance package
  const [price, setPrice] = useState(0); // Price of the selected package
  const [isPaymentSuccessful, setIsPaymentSuccessful] = useState(false); // Payment status
  const [isInsuranceClaimed, setIsInsuranceClaimed] = useState(false); // Insurance claim status

  // Define the prices for each insurance package
  const packagePrices = {
    Small: 1000,
    Regular: 10000,
    Large: 100000,
  };

  // Function to handle buying insurance
  const handleBuyInsurance = () => {
    setPackageBought(selectedOption);
    setPrice(packagePrices[selectedOption]);
  };

  // Function to handle making payment
  const handleMakePayment = () => {
    setIsPaymentSuccessful(true);
  };

  // Function to handle claiming insurance
  const handleClaimInsurance = () => {
    setIsInsuranceClaimed(true);
  };

  // Render the component
  return (
    <div>
      {/* If insurance has not been claimed, show the insurance purchase and payment options */}
      {!isInsuranceClaimed ? (
        <>
          {/* If no package has been bought, show the insurance package selection */}
          {!packageBought && (
            <>
              <h1 className="text-2xl text-gray-900 mt-10">Select Insurance Package</h1>
              <select value={selectedOption} className="border border-gray-300 rounded p-1 mt-5 mb-5" onChange={(e) => setSelectedOption(e.target.value)}>
                <option value="">Select...</option>
                <option value="Small">Small</option>
                <option value="Regular">Regular</option>
                <option value="Large">Large</option>
              </select>
              <button onClick={handleBuyInsurance} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Buy Insurance</button>
            </>
          )}
          {/* If a package has been bought, show the package details */}
          {packageBought && <p className='mt-10'>You bought the {packageBought} package for ${price}. Next Payment Due after 28 Days.</p>}
          {/* If a package has been bought, show the payment option */}
          {packageBought && (
            <>
              <h1 className="text-2xl text-gray-900 mt-10">Make Payment</h1>
              <button onClick={handleMakePayment} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Make Payment</button>
            </>
          )}
          {/* If payment is successful, show the success message */}
          {isPaymentSuccessful && <p>Payment Successful. Next Payment Due after 28 Days.</p>}
          {/* If a package has been bought, show the insurance claim option */}
          {packageBought && (
            <>
              <h1 className="text-2xl text-gray-900 mt-10">Claim Insurance</h1>
              <button onClick={handleClaimInsurance} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Claim Insurance</button>
            </>
          )}
        </>
      ) : (
        // If insurance has been claimed, show the claim message
        <p>Claimed Insurance</p>
      )}
    </div>
  );
}
