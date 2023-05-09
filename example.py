import btc

new_wallet="new_wallet"
#first let's create a wallet
print(btc.create_bitcoin_wallet(new_wallet))

#then we will create 2 bitcoin addresses
print(btc.new_address(new_wallet))

print(btc.new_address(new_wallet))

#finally let's see how the server is doing
print(btc.blockchaininfo())