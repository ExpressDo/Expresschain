// Crowdfunding Contract

// Define the contract
contract Crowdfunding:

    // State variables
    projectOwner: address
    fundingGoal: Uint128
    deadline: Timestamp
    totalFunds: Uint128
    fundsRaised: Uint128
    isGoalReached: bool

    // Event to log contributions
    Contribute: event({contributor: indexed(address), amount: uint128})

    // Initialize the crowdfunding campaign
    init(owner: address, goal: Uint128, duration: Timestamp):
        projectOwner = owner
        fundingGoal = goal
        deadline = now() + duration

    // Function to contribute funds to the project
    function contribute() payable:
        // Check if the deadline has not passed
        require(now() < deadline, "Crowdfunding campaign has ended")

        // Update the total funds raised
        fundsRaised = add(fundsRaised, msg.value)

        // Log the contribution event
        log Contribute({contributor: msg.sender, amount: msg.value})

        // Check if the funding goal is reached
        if fundsRaised >= fundingGoal:
            isGoalReached = true

    // Function to withdraw funds if the goal is reached
    function withdrawFunds():
        // Check if the funding goal is reached and the project owner is calling the function
        require(isGoalReached && msg.sender == projectOwner, "Goal not reached or unauthorized")

        // Transfer funds to the project owner
        send(projectOwner, fundsRaised)

    // Function to refund contributors if the goal is not reached
    function refund():
        // Check if the deadline has passed and the funding goal is not reached
        require(now() >= deadline && !isGoalReached, "Deadline not reached or goal reached")

        // Refund the contributor
        send(msg.sender, getContribution(msg.sender))
        clearContribution(msg.sender)

    // Function to get the contribution amount of a specific contributor
    function getContribution(contributor: address) -> (Uint128):
        return contributions[contributor]

    // Function to clear a contributor's contribution after refund
    function clearContribution(contributor: address):
        contributions[contributor] = 0

// Utility function to add two Uint128 values
function add(a: Uint128, b: Uint128) -> (Uint128):
    return a + b
