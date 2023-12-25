// Escrow Contract

// Define the contract
contract Escrow:

    // State variables
    buyer: address
    seller: address
    arbiter: address  // A trusted third party who can arbitrate disputes
    escrowAmount: Uint128
    isFundsReleased: bool
    isDisputeResolved: bool

    // Event to log actions
    EscrowInitiated: event({buyer: indexed(address), seller: indexed(address), arbiter: indexed(address), amount: uint128})
    FundsReleased: event({to: indexed(address), amount: uint128})
    DisputeResolved: event({resolvedBy: indexed(address), resolution: bool})

    // Initialize the escrow contract
    init(sellerAddress: address, arbiterAddress: address):
        buyer = msg.sender
        seller = sellerAddress
        arbiter = arbiterAddress
        isFundsReleased = false
        isDisputeResolved = false

    // Function to initiate the escrow by placing funds in it
    function initiateEscrow() payable:
        // Ensure only the buyer can initiate the escrow and that it hasn't been initiated before
        require(msg.sender == buyer && escrowAmount == 0, "Escrow already initiated")

        // Set the escrow amount
        escrowAmount = msg.value

        // Log the escrow initiation
        log EscrowInitiated({buyer: buyer, seller: seller, arbiter: arbiter, amount: escrowAmount})

    // Function for the seller to release funds when conditions are met
    function releaseFunds():
        // Ensure only the seller can release funds and that the escrow has been initiated
        require(msg.sender == seller && !isFundsReleased, "Funds already released or unauthorized")

        // Release funds to the seller
        send(seller, escrowAmount)

        // Log the funds release
        log FundsReleased({to: seller, amount: escrowAmount})

        // Update the state
        isFundsReleased = true

    // Function for the buyer or arbiter to resolve a dispute
    function resolveDispute(resolution: bool):
        // Ensure only the buyer or arbiter can resolve a dispute and that there is a dispute
        require((msg.sender == buyer || msg.sender == arbiter) && !isDisputeResolved, "Dispute already resolved or unauthorized")

        // Log the dispute resolution
        log DisputeResolved({resolvedBy: msg.sender, resolution: resolution})

        // If the resolution is true, release funds to the seller; otherwise, refund the buyer
        if resolution:
            send(seller, escrowAmount)
            log FundsReleased({to: seller, amount: escrowAmount})
        else:
            send(buyer, escrowAmount)

        // Update the state
        isDisputeResolved = true

// Utility function to check if the sender is the arbiter
function isArbiter() -> (bool):
    return msg.sender == arbiter
