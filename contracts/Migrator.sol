// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Migrator is IERC721Receiver {
    mapping (uint256 => uint256) public oldToNewId;
    IERC721 petZoo;
    IERC721 tombheads;
    address public _minter;
    address public _oldContract;
    address public _newContract;


    constructor (address minter, address oldContract, address newContract) {
        oldToNewId[6805] = 1;
        oldToNewId[6806] = 2;
        oldToNewId[6807] = 3;
        oldToNewId[6808] = 4;
        oldToNewId[6809] = 5;
        oldToNewId[6810] = 6;
        oldToNewId[6811] = 7;
        oldToNewId[6812] = 8;
        oldToNewId[6814] = 9;
        oldToNewId[6816] = 10;
        oldToNewId[6818] = 11;
        oldToNewId[6819] = 12;
        oldToNewId[7208] = 13;
        oldToNewId[7515] = 14;
        oldToNewId[7516] = 15;
        oldToNewId[7517] = 16;
        oldToNewId[7518] = 17;
        oldToNewId[7519] = 18;
        oldToNewId[7520] = 19;
        oldToNewId[7521] = 20;
        oldToNewId[7522] = 21;
        oldToNewId[7523] = 22;
        oldToNewId[7524] = 23;
        oldToNewId[7525] = 24;
        oldToNewId[7787] = 25;
        oldToNewId[8005] = 26;
        oldToNewId[8006] = 27;
        oldToNewId[8344] = 28;
        oldToNewId[8345] = 29;
        oldToNewId[8349] = 30;
        oldToNewId[8350] = 31;
        oldToNewId[8351] = 32;
        oldToNewId[8352] = 33;
        oldToNewId[8355] = 34;
        oldToNewId[8356] = 35;
        oldToNewId[8358] = 36;
        oldToNewId[8360] = 37;
        oldToNewId[8362] = 38;
        oldToNewId[8713] = 39;
        oldToNewId[8714] = 40;
        oldToNewId[8715] = 41;
        oldToNewId[8716] = 42;
        oldToNewId[8853] = 43;
        oldToNewId[8931] = 44;
        oldToNewId[8932] = 45;
        oldToNewId[8933] = 46;
        oldToNewId[8934] = 47;
        oldToNewId[9158] = 48;
        oldToNewId[9159] = 49;
        oldToNewId[9160] = 50;
        oldToNewId[9263] = 51;
        oldToNewId[9264] = 52;
        oldToNewId[9265] = 53;
        oldToNewId[9301] = 54;
        oldToNewId[9369] = 55;
        oldToNewId[9370] = 56;
        oldToNewId[9422] = 57;
        oldToNewId[9423] = 58;
        oldToNewId[9424] = 59;
        oldToNewId[9425] = 60;

        _oldContract = oldContract;
        _newContract = newContract;
        petZoo = IERC721(_oldContract);
        tombheads = IERC721(_newContract);
        _minter = minter;
    }

    function migrate(uint256 tokenId) external {
        require(oldToNewId[tokenId] > 0, "Migrator: This token is not on the list"); // make sure mapping exists
        tombheads.safeTransferFrom(_minter, msg.sender, oldToNewId[tokenId]);
        petZoo.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
