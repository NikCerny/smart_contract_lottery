# Expecting:
# 3 535,85USD 19/07/2025
# https://eth-converter.com/
# 2USD / 3 535,85USD = 5.656 E-4 = 0.0005656 ~ 2USD
# Wei 565600000000000

from brownie import Lottery, accounts, config,network
from web3 import Web3

def test_get_entrance_fee():
    account = accounts[0]
    lottery = Lottery.deploy(
        config["networks"][network.show_active()]["eth_usd_price_feed"],
        {"from": account}
    )
    assert lottery.getEntranceFee() > Web3.to_wei(0.005556, "ether")
