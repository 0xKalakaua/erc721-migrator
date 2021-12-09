#!/usr/bin/python3
import os
from brownie import Migrator, accounts, network, config


def main():
    dev = accounts.load("dev")
    minter = "0x3B6B88535C0fa08179262829558F49C72EE6c1a0"
    print(network.show_active())
    publish_source = True
    old_contract = "0xd606543c1c7607bf02B9536e9B31cdc1CF564c1E" 
    new_contract = "0x24487f31B75c2B740C82f64b9e94477Ed12757e7"
    Migrator.deploy(minter, old_contract, new_contract, {"from": dev}, publish_source=publish_source)
