#!/usr/bin/python3
import os
from brownie import Migrator, accounts, network, config


def main():
    minter = accounts.load("dev")
    admin = accounts.load("admin")
    print(network.show_active())
    publish_source = True # Not supported on Testnet
    old_contract = "0x99ed0fD437d663f54046150E621629409A882901" 
    new_contract = "0xE36a7641eEb756b16ad6BFB177955A2d13bd0c87"
    Migrator.deploy(minter, old_contract, new_contract, {"from": admin}, publish_source=publish_source)
