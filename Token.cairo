// Token Contract

// Define the contract
contract Token:

    // State variables
    totalSupply: Uint128
    balances: Map(address, Uint128)

    // Event to log transfers
    Transfer: event({from: indexed(address), to: indexed(address), value: uint128})

    // Initialize the contract
    init(initialSupply: Uint128)
        totalSupply = initialSupply
        balances[msg.sender] = initialSupply

    // Function to get the total supply of the token
    function getTotalSupply() -> (Uint128):
        return totalSupply

    // Function to get the balance of a specific address
    function getBalance(owner: address) -> (Uint128):
        return balances[owner]

    // Function to transfer tokens
    function transfer(to: address, value: Uint128):
        // Check if the sender has enough balance
        require(balances[msg.sender] >= value, "Insufficient balance")

        // Transfer tokens
        balances[msg.sender] = sub(balances[msg.sender], value)
        balances[to] = add(balances[to], value)

        // Log the transfer event
        log Transfer({from: msg.sender, to: to, value: value})

// Utility function to add two Uint128 values
function add(a: Uint128, b: Uint128) -> (Uint128):
    return a + b

// Utility function to subtract two Uint128 values
function sub(a: Uint128, b: Uint128) -> (Uint128):
    require(a >= b, "Subtraction overflow")
    return a - b
