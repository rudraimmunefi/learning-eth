import json
from solcx import compile_standard, install_solc
from web3 import Web3

with open("./SimpleStorage.sol", "r") as file:
    simple_storage_file = file.read()

# We add these two lines that we forgot from the video!
# print("Installing...")
# install_solc("0.6.0")

# Solidity source code
compiled_sol = compile_standard(
    {
        "language": "Solidity",
        "sources": {"SimpleStorage.sol": {"content": simple_storage_file}},
        "settings": {
            "outputSelection": {
                "*": {
                    "*": ["abi", "metadata", "evm.bytecode", "evm.bytecode.sourceMap"]
                }
            }
        },
    },
    solc_version="0.6.0",
)

with open("compiled_code.json", "w") as file:
    json.dump(compiled_sol, file)

bytecode = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["evm"]["bytecode"]["object"]
abi = compiled_sol["contracts"]["SimpleStorage.sol"]["SimpleStorage"]["abi"]

# connecting ganache

w3 = Web3(Web3.HTTPProvider("http://127.0.0.1:8545"))
chainID = 1337
myAddress = ""
private_key = ""

# create contract
# we need abi and bytecode for creating new contract

SimpleStorage = w3.eth.contract(abi=abi, bytecode=bytecode)

# to build a transaction because to make a state change on blockchain you need to make a transaction
# and to create it we need nonce.

nonce = w3.eth.getTransactionCount(myAddress)

# to deploy a contract we need transaction
# 1) build a transaction for smart contract deployment
# 2) Sign a transaction
# 3) Send a transaction

transaction = SimpleStorage.constructor().buildTransaction(
    {"chainId": chainID, "from": myAddress, "nonce": nonce, "gasPrice": w3.eth.gas_price})

sign_tx = w3.eth.account.sign_transaction(transaction, private_key=private_key)

# send this signed transaction

tx_hash = w3.eth.send_raw_transaction(sign_tx.rawTransaction)

# get transaction receipt where the contract address could be found

tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

# contract has been deployed.

# -----------------------------

# working with contracts i.e calling functions

# contract ABI and address is needed

# Call -> Simulate making a call - does not change state of blockchain
# Transact -> Making state change

contract_obj = w3.eth.contract(address=tx_receipt.contractAddress, abi=abi)

print(contract_obj.functions.retrieve().call())
# 1337 is the function argument for store function
store = contract_obj.functions.store(1337).buildTransaction(
    {"chainId": chainID, "from": myAddress, "nonce": nonce+1, "gasPrice": w3.eth.gas_price})

sign_store = w3.eth.account.sign_transaction(store, private_key=private_key)
tx_hash = w3.eth.send_raw_transaction(sign_store.rawTransaction)
tx_receipt = w3.eth.wait_for_transaction_receipt(tx_hash)

print(contract_obj.functions.retrieve().call())
