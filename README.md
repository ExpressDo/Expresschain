# Expresschain

Express chain is a simple blockchain implementation in the Cairo programming language. This blockchain includes basic functionalities such as creating blocks, mining blocks using proof-of-work, and adding blocks to the chain.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Before you begin, ensure you have the following installed:

- Cairo Compiler
- Ethereum Virtual Machine (EVM)

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/my-blockchain.git
    ```

2. Navigate to the project directory:

    ```bash
    cd my-blockchain
    ```

3. Compile the Cairo contracts:

    ```bash
    # Replace <contract_filename> with the actual filename
    cairo-compile --output=<contract_filename>.out <contract_filename>.cairo
    ```

4. Deploy the compiled contract to the Ethereum blockchain.

## Usage

Here's how you can interact with the blockchain:

### 1. Initialize the Blockchain

```cairo
// Replace <initial_data> with your desired data
init(<initial_data>, <initial_difficulty>)
