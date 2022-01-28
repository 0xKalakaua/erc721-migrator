#!/usr/bin/python3
import os
from brownie import Migrator, accounts, network, config


def main():
    dev = accounts.load("dev")
    minter = "0x4E5710a75c1c718Cf7F79688883F94Ea6cA02043"
    print(network.show_active())
    publish_source = True
    old_contract = "0xd606543c1c7607bf02B9536e9B31cdc1CF564c1E" 
    new_contract = "0x7Eb605E32AA833dff55DF3BAe51Afb82eC61e372"
    Migrator.deploy(minter, old_contract, new_contract, {"from": dev}, publish_source=publish_source)
