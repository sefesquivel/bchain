// ===========================================
// METAMASK NETWORK CHECKER - JavaScript Code
// ===========================================

// This variable will hold our Web3 instance
let web3;

// This variable will store the user's account address
let userAccount;

// ===========================================
// FUNCTION 1: Connect to MetaMask
// ===========================================
async function connectMetaMask() {
    console.log("Connect button clicked!"); // For debugging
    
    // Check if MetaMask is installed
    if (typeof window.ethereum !== 'undefined') {
        console.log('MetaMask is installed!');
        
        try {
            // Request user to connect their wallet
            // This will open MetaMask popup
            const accounts = await window.ethereum.request({ 
                method: 'eth_requestAccounts' 
            });
            
            console.log('User approved connection!');
            
            // Create Web3 instance
            web3 = new Web3(window.ethereum);
            
            // Get the first account
            userAccount = accounts[0];
            console.log('Connected account:', userAccount);
            
            // Change button text to show we're connected
            document.getElementById('connectBtn').textContent = '✓ Connected';
            document.getElementById('connectBtn').style.background = '#28a745';
            
            // Now get the network information
            await getNetworkInfo();
            
        } catch (error) {
            // If user rejects connection or something goes wrong
            console.error('Error:', error);
            showError('Failed to connect: ' + error.message);
        }
        
    } else {
        // MetaMask is not installed
        console.log('MetaMask is NOT installed');
        showError('MetaMask is not installed! Please install it from metamask.io');
    }
}

// ===========================================
// FUNCTION 2: Get Network Information
// ===========================================
async function getNetworkInfo() {
    try {
        // Get the Chain ID (network identifier)
        const chainId = await web3.eth.getChainId();
        console.log('Chain ID:', chainId);
        
        // Display the Chain ID on the page
        document.getElementById('chainId').textContent = chainId;
        
        // Get network name and emoji based on Chain ID
        const networkDetails = getNetworkDetails(chainId);
        
        // Update the display with network information
        document.getElementById('networkName').textContent = networkDetails.name;
        document.getElementById('networkEmoji').textContent = networkDetails.emoji;
        
        // Show the network info box
        document.getElementById('networkInfo').style.display = 'block';
        
        console.log('Network:', networkDetails.name);
        
    } catch (error) {
        console.error('Error getting network:', error);
        showError('Failed to get network information: ' + error.message);
    }
}

// ===========================================
// FUNCTION 3: Get Network Details by Chain ID
// ===========================================
function getNetworkDetails(chainId) {
    // Convert chainId to number for comparison
    const id = Number(chainId);
    
    // Return different details based on the Chain ID
    switch(id) {
        case 1:
            return { name: 'Ethereum Mainnet', emoji: '💎' };
        case 11155111:
            return { name: 'Sepolia Testnet', emoji: '🧪' };
        case 5:
            return { name: 'Goerli Testnet', emoji: '🧪' };
        case 137:
            return { name: 'Polygon Mainnet', emoji: '🟣' };
        case 80001:
            return { name: 'Mumbai Testnet', emoji: '🟣' };
        case 56:
            return { name: 'BNB Smart Chain', emoji: '🟡' };
        case 97:
            return { name: 'BNB Testnet', emoji: '🟡' };
        case 42161:
            return { name: 'Arbitrum One', emoji: '🔵' };
        case 10:
            return { name: 'Optimism', emoji: '🔴' };
        default:
            return { name: 'Unknown Network', emoji: '❓' };
    }
}

// ===========================================
// FUNCTION 4: Show Error Messages
// ===========================================
function showError(message) {
    const errorDiv = document.getElementById('errorMessage');
    errorDiv.textContent = message;
    errorDiv.style.display = 'block';
    
    // Hide error after 5 seconds
    setTimeout(() => {
        errorDiv.style.display = 'none';
    }, 5000);
}

// ===========================================
// BONUS: Listen for Network Changes
// ===========================================
// This code automatically detects when user switches networks
if (typeof window.ethereum !== 'undefined') {
    window.ethereum.on('chainChanged', (chainId) => {
        console.log('Network changed to:', chainId);
        // Reload the page when network changes
        window.location.reload();
    });
    
    window.ethereum.on('accountsChanged', (accounts) => {
        console.log('Account changed to:', accounts[0]);
        // Reload the page when account changes
        window.location.reload();
    });
}

console.log('App.js loaded successfully!');