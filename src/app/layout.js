// Importing components and libraries
import './globals.css'
import Page from './page.client.js'

// Exporting the RootLayout function as a default export
export default function RootLayout() {
  // Returning the JSX code for the layout
  return (
    <html lang="en">
      <head>
        <title>
          DeFi Assessment
        </title>
      </head>
      <body>
        <Page />
      </body>
    </html>
  )
}
