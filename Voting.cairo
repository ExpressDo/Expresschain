// Voting Contract

// Define the contract
contract Voting:

    // State variables
    candidates: Map(string, Uint32)
    voters: Map(address, bool)

    // Event to log votes
    Vote: event({voter: indexed(address), candidate: string})

    // Initialize the contract with a list of candidates
    init(candidateList: List(string)):
        // Initialize candidates with zero votes
        for candidate in candidateList:
            candidates[candidate] = 0

    // Function to vote for a candidate
    function vote(candidate: string):
        // Check if the voter has not voted before
        require(!voters[msg.sender], "You have already voted")

        // Check if the candidate exists
        require(candidates[candidate] > 0, "Invalid candidate")

        // Record the vote
        candidates[candidate] = add(candidates[candidate], 1)
        voters[msg.sender] = true

        // Log the vote event
        log Vote({voter: msg.sender, candidate: candidate})

    // Function to get the vote count for a candidate
    function getVoteCount(candidate: string) -> (Uint32):
        return candidates[candidate]

// Utility function to add two Uint32 values
function add(a: Uint32, b: Uint32) -> (Uint32):
    return a + b
