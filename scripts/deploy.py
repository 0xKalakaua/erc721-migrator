#!/usr/bin/python3
import os
from brownie import Migrator, accounts, network, config


def main():
    dev = accounts.load("dev")
    minter = "0x0A75029385FDF5e50e8753234Df0346784eCbdC1"
    print(network.show_active())
    publish_source = True
    old_contract = "0xd606543c1c7607bf02B9536e9B31cdc1CF564c1E" 
    new_contract = "0x903efDA32f6d85ae074c1948C8d6B54F2421949f"
    Migrator.deploy(minter, old_contract, new_contract, {"from": dev}, publish_source=publish_source)
