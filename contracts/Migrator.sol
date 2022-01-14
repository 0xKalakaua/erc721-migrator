// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Migrator is IERC721Receiver {
    mapping (uint256 => uint256) public oldToNewId;
    IERC721 petZoo;
    IERC721 nftees;
    address public _minter;
    address public _oldContract;
    address public _newContract;


    constructor (address minter, address oldContract, address newContract) {
        oldToNewId[829] = 0;
        oldToNewId[831] = 1;
        oldToNewId[835] = 2;
        oldToNewId[836] = 3;
        oldToNewId[980] = 4;
        oldToNewId[981] = 5;
        oldToNewId[983] = 6;
        oldToNewId[986] = 7;
        oldToNewId[987] = 8;
        oldToNewId[988] = 9;
        oldToNewId[1359] = 10;
        oldToNewId[1405] = 11;
        oldToNewId[1436] = 12;
        oldToNewId[1864] = 13;
        oldToNewId[2354] = 16;
        oldToNewId[1247] = 20;
        oldToNewId[1422] = 21;
        oldToNewId[1426] = 22;
        oldToNewId[1428] = 23;
        oldToNewId[3086] = 24;
        oldToNewId[1276] = 25;
        oldToNewId[1431] = 26;
        oldToNewId[1433] = 27;
        oldToNewId[1360] = 28;
        oldToNewId[1361] = 29;
        oldToNewId[1715] = 31;
        oldToNewId[1640] = 32;
        oldToNewId[1642] = 33;
        oldToNewId[1643] = 34;
        oldToNewId[1644] = 35;
        oldToNewId[1645] = 36;
        oldToNewId[1269] = 37;
        oldToNewId[1274] = 38;
        oldToNewId[1355] = 39;
        oldToNewId[1266] = 40;
        oldToNewId[1351] = 41;
        oldToNewId[2654] = 42;
        oldToNewId[1270] = 43;
        oldToNewId[1352] = 45;
        oldToNewId[1353] = 46;
        oldToNewId[1354] = 47;
        oldToNewId[2047] = 48;
        oldToNewId[2048] = 49;
        oldToNewId[2045] = 50;

        _oldContract = oldContract;
        _newContract = newContract;
        petZoo = IERC721(_oldContract);
        nftees = IERC721(_newContract);
        _minter = minter;
    }

    function migrate(uint256 tokenId) external {
        require(oldToNewId[tokenId] > 0, "Migrator: This token is not on the list"); // make sure mapping exists
        nftees.safeTransferFrom(_minter, msg.sender, oldToNewId[tokenId]);
        petZoo.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function onERC721Received(address, address, uint256, bytes memory) public virtual override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
