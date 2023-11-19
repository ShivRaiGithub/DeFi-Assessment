// Import necessary hooks and form handling from React and react-hook-form
import React, { useState } from 'react';
import { useForm } from 'react-hook-form';

// Define the CollateralProtection component
export default function CollateralProtection() {
  // Initialize form handling and error tracking
  const { register, handleSubmit, formState: { errors } } = useForm();

  // Initialize state variables
  const [formSubmitted, setFormSubmitted] = useState(false); // Form submission status
  const [loanTaken, setLoanTaken] = useState(false); // Loan taken status
  const [loanRepaid, setLoanRepaid] = useState(false); // Loan repayment status

  // Function to handle form submission
  const onSubmit = (data) => {
    console.log(data);
    setFormSubmitted(true);
  };

  // Function to handle loan taking
  const handleLoanTake = () => {
    setLoanTaken(true);
  };

  // Function to handle loan repayment
  const handleLoanRepay = () => {
    setLoanRepaid(true);
  };

  // Render the component
  return (
    // If form has not been submitted, show the loan application form
    !formSubmitted ? (
      <form onSubmit={handleSubmit(onSubmit)}>
        <h1 className="text-2xl text-gray-900 mt-10">Select Insurance Package</h1>

       // Loan Amount input field
        <label className="ml-10 mr-10 mt-5 mb-5">
          Loan Amount:
          <input className="border border-gray-300 rounded p-1 ml-10 mt-5 mb-5" {...register("loanAmount", { required: true, valueAsNumber: true, min: 1 })} />
        </label>
        {errors.loanAmount && <p>Please enter a positive integer.</p>}

       // Collateral input field
        <label className="ml-10 mr-10 mt-5 mb-5">
          Collateral:
          <input className="border border-gray-300 rounded p-1 ml-10 mt-5 mb-5" {...register("collateral", { required: true, valueAsNumber: true, min: 1 })} />
        </label>
        {errors.collateral && <p>Please enter a positive integer.</p>}

       // Coverage selection
        <label className="ml-10 mr-10 mt-5 mb-5">
          Coverage:
          <select className="border border-gray-300 rounded p-1 ml-10 mt-5 mb-5" {...register("coverage", { required: true })}>
            <option value="">Select...</option>
            <option value="partial">Partial</option>
            <option value="full">Full</option>
          </select>
        </label>
        {errors.coverage && <p>Please select a coverage.</p>}

       // Submit button
        <button type="submit" className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Apply for loans</button>
      </form>
    ) : (
      // If form has been submitted, check the status of loan taking and repayment
      !loanTaken ? (
        // If loan has not been taken, show the loan taking option
        <>
          <h1 className="text-2xl text-gray-900 mt-10">Applied for loan successfully</h1>
          <button onClick={handleLoanTake} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Take Loan</button>
        </>
      ) : (
        !loanRepaid ? (
          // If loan has been taken but not repaid, show the loan repayment option
          <>
            <h1 className="text-2xl text-gray-900 mt-10">Loan Taken Successfully</h1>
            <button onClick={handleLoanRepay} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 m-10 rounded-full">Repay Loan</button>
          </>
        ) : (
          // If loan has been repaid, show the success message
          <h1 className="text-2xl text-gray-900 mt-10">Loan Repaid Successfully</h1>
        )
      )
    )
  );
}
