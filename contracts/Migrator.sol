// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract Migrator is Context, IERC721Receiver {
    mapping (uint256 => uint256) public oldToNewId;
    IERC721 petZoo;
    IERC721 tombheads;
    address public _minter;
    address public _oldContract;
    address public _newContract;


    constructor (address minter, address oldContract, address newContract) {
        oldToNewId[2] = 1;
        oldToNewId[4] = 2;
        oldToNewId[6] = 3;
        oldToNewId[8] = 4;
        oldToNewId[10] = 5;
        _oldContract = oldContract;
        _newContract = newContract;
        petZoo = IERC721(_oldContract);
        tombheads = IERC721(_newContract);
        _minter = minter;
    }

    function migrate(uint256 tokenId) external {
        require(oldToNewId[tokenId] > 0, "Migrator: This token is not on the list"); // make sure mapping exists
        tombheads.safeTransferFrom(_minter, _msgSender(), oldToNewId[tokenId]);
        petZoo.safeTransferFrom(_msgSender(), address(this), tokenId);
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
