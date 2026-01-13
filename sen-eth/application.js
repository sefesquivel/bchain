let web3;
let userAccount;

// Connect to MetaMask Wallet
async function connectWallet() {
    if (typeof window.ethereum !== 'undefined') {
        try {
            // Request account access
            const accounts = await window.ethereum.request({ 
                method: 'eth_requestAccounts' 
            });
            
            // Initialize Web3
            web3 = new Web3(window.ethereum);
            
            // Get the first account
            userAccount = accounts[0];
            
            // Display account information
            document.getElementById('accountAddress').textContent = userAccount;
            document.getElementById('accountInfo').classList.remove('hidden');
            document.getElementById('transactionForm').classList.remove('hidden');
            document.getElementById('connectButton').textContent = 'Connected ✓';
            document.getElementById('connectButton').disabled = true;
            
            // Get and display balance
            await getBalance();
            
            // Listen for account changes
            window.ethereum.on('accountsChanged', handleAccountsChanged);
            
            showStatus('Successfully connected to MetaMask!', 'success');
            
        } catch (error) {
            console.error('Error connecting to MetaMask:', error);
            showStatus('Failed to connect to MetaMask: ' + error.message, 'error');
        }
    } else {
        showStatus('MetaMask is not installed. Please install MetaMask extension.', 'error');
    }
}

// Get Account Balance
async function getBalance() {
    try {
        // Get balance in Wei
        const balanceWei = await web3.eth.getBalance(userAccount);
        
        // Convert Wei to Ether
        const balanceEth = web3.utils.fromWei(balanceWei, 'ether');
        
        // Display balance (rounded to 4 decimal places)
        document.getElementById('accountBalance').textContent = 
            parseFloat(balanceEth).toFixed(4);
            
    } catch (error) {
        console.error('Error getting balance:', error);
        showStatus('Error fetching balance: ' + error.message, 'error');
    }
}

// Refresh Balance
async function refreshBalance() {
    if (userAccount) {
        await getBalance();
        showStatus('Balance refreshed!', 'success');
    }
}

// Send Transaction
async function sendTransaction() {
    const recipientAddress = document.getElementById('recipientAddress').value;
    const amount = document.getElementById('amount').value;
    
    // Validation
    if (!recipientAddress) {
        showStatus('Please enter a recipient address', 'error');
        return;
    }
    
    if (!web3.utils.isAddress(recipientAddress)) {
        showStatus('Invalid Ethereum address', 'error');
        return;
    }
    
    if (!amount || amount <= 0) {
        showStatus('Please enter a valid amount', 'error');
        return;
    }
    
    try {
        // Disable send button during transaction
        document.getElementById('sendButton').disabled = true;
        document.getElementById('sendButton').textContent = 'Sending...';
        
        // Convert ETH to Wei
        const amountWei = web3.utils.toWei(amount, 'ether');
        
        // Create transaction object
        const transactionParameters = {
            from: userAccount,
            to: recipientAddress,
            value: amountWei,
            gas: '21000', // Standard gas limit for ETH transfer
        };
        
        // Send transaction
        const txHash = await window.ethereum.request({
            method: 'eth_sendTransaction',
            params: [transactionParameters],
        });
        
        showStatus('Transaction sent! Hash: ' + txHash, 'success');
        
        // Wait for transaction to be mined
        setTimeout(async () => {
            await getBalance();
            showStatus('Transaction confirmed! Balance updated.', 'success');
        }, 5000);
        
        // Clear form
        document.getElementById('recipientAddress').value = '';
        document.getElementById('amount').value = '';
        
    } catch (error) {
        console.error('Transaction error:', error);
        showStatus('Transaction failed: ' + error.message, 'error');
    } finally {
        // Re-enable send button
        document.getElementById('sendButton').disabled = false;
        document.getElementById('sendButton').textContent = 'Send ETH';
    }
}

// Handle Account Changes
function handleAccountsChanged(accounts) {
    if (accounts.length === 0) {
        // User disconnected wallet
        showStatus('Please connect to MetaMask', 'error');
        location.reload();
    } else if (accounts[0] !== userAccount) {
        // User switched accounts
        userAccount = accounts[0];
        document.getElementById('accountAddress').textContent = userAccount;
        getBalance();
        showStatus('Account changed', 'success');
    }
}

// Display Status Messages
function showStatus(message, type) {
    const statusDiv = document.getElementById('statusMessage');
    statusDiv.textContent = message;
    statusDiv.className = 'status ' + type;
    
    // Auto-hide after 5 seconds
    setTimeout(() => {
        statusDiv.textContent = '';
        statusDiv.className = '';
    }, 5000);
}