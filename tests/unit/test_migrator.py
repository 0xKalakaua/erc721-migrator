import pytest
import brownie
from brownie import network, accounts, convert, Migrator, MockERC721

@pytest.fixture
def old_erc721():
    dev = accounts[0]
    max_ = 10
    old = MockERC721.deploy("Old Contract", "OLD", max_, dev, {'from': dev})
    for i in range(max_):
        tx = old.mint(f"Old #{i+1}", {'from': dev})
        if i:
            old.safeTransferFrom(dev, accounts[i], i, {'from': dev})
    return old

@pytest.fixture
def new_erc721():
    minter = accounts[1]
    max_ = 5
    new = MockERC721.deploy("New Contract", "NEW", max_, minter, {'from': minter})
    for i in range(max_):
        tx = new.mint(f"New #{i+1}", {'from': minter})
    return new

@pytest.fixture
def contracts(old_erc721, new_erc721):
    dev = accounts[0]
    minter = accounts[1]
    migrator = Migrator.deploy(minter, old_erc721, new_erc721, {'from': dev})
    return migrator, old_erc721, new_erc721

def test_initial_state(contracts):
    minter = accounts[1]
    migrator, old, new = contracts
    assert new.ownerOf(1) == minter.address
    assert new.ownerOf(2) == minter.address
    assert new.ownerOf(3) == minter.address
    assert new.ownerOf(4) == minter.address
    assert new.ownerOf(5) == minter.address
    assert old.ownerOf(1) == accounts[1].address
    assert old.ownerOf(2) == accounts[2].address
    assert old.ownerOf(3) == accounts[3].address
    assert old.ownerOf(4) == accounts[4].address
    assert old.ownerOf(5) == accounts[5].address
    assert old.ownerOf(6) == accounts[6].address
    assert old.ownerOf(7) == accounts[7].address
    assert old.ownerOf(8) == accounts[8].address
    assert old.ownerOf(9) == accounts[9].address
    assert old.ownerOf(10) == accounts[0].address


def test_succesful_migrate(contracts):
    minter = accounts[1]
    migrator, old, new = contracts
    new.setApprovalForAll(migrator, True, {'from': minter})
    old.approve(migrator, 2, {'from': accounts[2]})
    old.approve(migrator, 4, {'from': accounts[4]})
    old.approve(migrator, 6, {'from': accounts[6]})
    old.approve(migrator, 8, {'from': accounts[8]})
    old.approve(migrator, 10, {'from': accounts[0]})
    migrator.migrate(2, {'from': accounts[2]})
    migrator.migrate(4, {'from': accounts[4]})
    migrator.migrate(6, {'from': accounts[6]})
    migrator.migrate(8, {'from': accounts[8]})
    migrator.migrate(10, {'from': accounts[0]})
    assert old.ownerOf(2) == migrator.address
    assert old.ownerOf(4) == migrator.address
    assert old.ownerOf(6) == migrator.address
    assert old.ownerOf(8) == migrator.address
    assert old.ownerOf(10) == migrator.address
    assert new.ownerOf(1) == accounts[2].address
    assert new.ownerOf(2) == accounts[4].address
    assert new.ownerOf(3) == accounts[6].address
    assert new.ownerOf(4) == accounts[8].address
    assert new.ownerOf(5) == accounts[0].address

def test_invalid_tokenId(contracts):
    minter = accounts[1]
    migrator, old, new = contracts
    new.setApprovalForAll(migrator, True, {'from': minter})
    old.approve(migrator, 1, {'from': accounts[1]})
    old.approve(migrator, 3, {'from': accounts[3]})
    with brownie.reverts():
        migrator.migrate(1, {'from': accounts[1]})
    with brownie.reverts():
        migrator.migrate(3, {'from': accounts[3]})

def test_old_not_approved(contracts):
    minter = accounts[1]
    migrator, old, new = contracts
    new.setApprovalForAll(migrator, True, {'from': minter})
    with brownie.reverts():
        migrator.migrate(2, {'from': accounts[2]})
    assert old.ownerOf(2) == accounts[2].address
    assert new.ownerOf(1) == minter.address 

def test_new_not_approved(contracts):
    minter = accounts[1]
    migrator, old, new = contracts
    old.approve(migrator, 2, {'from': accounts[2]})
    with brownie.reverts():
        migrator.migrate(2, {'from': accounts[2]})
    assert old.ownerOf(2) == accounts[2].address
    assert new.ownerOf(1) == minter.address 

def test_token_not_minted_yet(old_erc721):
    old = old_erc721
    minter = accounts[1]
    max_ = 5
    new = MockERC721.deploy("New Contract", "NEW", max_, minter, {'from': minter})
    for i in range(max_ - 1):
        new.mint(f"New #{i+1}", {'from': minter})

    dev = accounts[0]
    migrator = Migrator.deploy(minter, old, new, {'from': dev})
    new.setApprovalForAll(migrator, True, {'from': minter})
    old.approve(migrator, 10, {'from': dev})
    with brownie.reverts():
        migrator.migrate(10, {'from': dev})

    new.mint(f"New #10", {'from': minter})
    migrator.migrate(10, {'from': dev})
    assert old.ownerOf(10) == migrator.address
    assert new.ownerOf(5) == dev.address
