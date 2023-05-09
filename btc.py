import subprocess

# Define the path to the bitcoin-cli executable
bitcoin_cli_path = "bitcoin-cli"

def create_bitcoin_wallet(id):
    # Define the command to create a new Bitcoin wallet with the specified ID
    command = [bitcoin_cli_path, "createwallet", id]

    # Execute the command in the terminal and capture the output
    result = subprocess.run(command, stdout=subprocess.PIPE)

    # Return the output of the command as a string
    return result.stdout.decode('utf-8')

def new_address(id):

    # Define the command to generate a new Bitcoin address for the specified wallet ID
    command = [bitcoin_cli_path, "-rpcwallet=" + id, "getnewaddress"]

    # Execute the command in the terminal and capture the output
    result = subprocess.run(command, stdout=subprocess.PIPE)

    # Return the output of the command as a string
    return result.stdout.decode('utf-8')

def blockchaininfo():
    # Define the command to list all Bitcoin addresses to which the specified wallet has sent a transaction
    command = [bitcoin_cli_path, "getblockchaininfo"]
    # Execute the command in the terminal and capture the output
    result = subprocess.run(command, stdout=subprocess.PIPE)
    # Return the output of the command as a string
    return result.stdout.decode('utf-8')

