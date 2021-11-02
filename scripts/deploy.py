#!/usr/bin/python3
import os
from brownie import Migrator, accounts, network, config


def main():
    dev = accounts.load("dev")
    minter = "<Tombheads address>"
    print(network.show_active())
    publish_source = True # Not supported on Testnet
    old_contract = "<old contract>" 
    new_contract = "<new contract>"
    Migrator.deploy(minter, old_contract, new_contract, {"from": dev}, publish_source=publish_source)
