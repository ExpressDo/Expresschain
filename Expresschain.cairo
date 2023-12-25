

// Define the contract
contract Expresschain:

    // State variables
    chain: List(Block)
    difficulty: Uint256

    // Struct to represent a block
    Block:
        index: Uint256
        timestamp: Uint256
        data: string
        previousHash: string
        hash: string

    // Event to log new blocks
    NewBlock: event({index: uint256, timestamp: uint256, data: string, previousHash: string, hash: string})

    // Initialize the blockchain
    init(initialData: string, initialDifficulty: Uint256):
        createGenesisBlock(initialData)
        difficulty = initialDifficulty

    // Function to create the genesis block
    function createGenesisBlock(data: string):
        // Create the first block
        let genesisBlock: Block = {
            index: 0,
            timestamp: now(),
            data: data,
            previousHash: "0",
            hash: calculateHash(0, now(), data, "0")
        }

        // Add the genesis block to the chain
        chain = [genesisBlock]

        // Log the genesis block
        log NewBlock(genesisBlock.index, genesisBlock.timestamp, genesisBlock.data, genesisBlock.previousHash, genesisBlock.hash)

    // Function to add a new block to the blockchain
    function addBlock(data: string):
        // Get the previous block
        let previousBlock: Block = chain[chain.length - 1]

        // Calculate the new block's index, timestamp, and hash
        let newIndex: Uint256 = previousBlock.index + 1
        let newTimestamp: Uint256 = now()
        let newHash: string = calculateHash(newIndex, newTimestamp, data, previousBlock.hash)

        // Mine the block with proof-of-work
        let minedBlock: Block = mineBlock(newIndex, newTimestamp, data, previousBlock.hash)

        // Add the mined block to the chain
        chain.push(minedBlock)

        // Log the new block
        log NewBlock(minedBlock.index, minedBlock.timestamp, minedBlock.data, minedBlock.previousHash, minedBlock.hash)

    // Function to mine a block using proof-of-work
    function mineBlock(index: Uint256, timestamp: Uint256, data: string, previousHash: string) -> (Block):
        let nonce: Uint256 = 0
        let newHash: string = calculateHash(index, timestamp, data, previousHash, nonce)

        // Proof-of-work: find a hash with the required difficulty
        while (newHash.slice(0, difficulty) != "0" * difficulty):
            nonce = nonce + 1
            newHash = calculateHash(index, timestamp, data, previousHash, nonce)

        // Create the mined block
        let minedBlock: Block = {
            index: index,
            timestamp: timestamp,
            data: data,
            previousHash: previousHash,
            hash: newHash
        }

        return minedBlock

    // Function to calculate the hash of a block
    function calculateHash(index: Uint256, timestamp: Uint256, data: string, previousHash: string, nonce: Uint256) -> (string):
        let hashInput: string = index.toString() @ timestamp.toString() @ data @ previousHash @ nonce.toString()
        return sha3(hashInput)
