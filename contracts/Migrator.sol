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
        oldToNewId[2527] = 1;
        oldToNewId[2577] = 2;
        oldToNewId[2603] = 3;
        oldToNewId[2605] = 4;
        oldToNewId[2628] = 5;
        oldToNewId[2629] = 6;
        oldToNewId[2630] = 7;
        oldToNewId[2632] = 8;
        oldToNewId[2717] = 9;
        oldToNewId[2719] = 10;
        oldToNewId[2721] = 11;
        oldToNewId[2724] = 12;
        oldToNewId[2726] = 13;
        oldToNewId[2815] = 14;
        oldToNewId[2816] = 15;
        oldToNewId[2817] = 16;
        oldToNewId[2818] = 17;
        oldToNewId[2819] = 18;
        oldToNewId[2829] = 19;
        oldToNewId[2830] = 20;
        oldToNewId[2831] = 21;
        oldToNewId[2832] = 22;
        oldToNewId[2833] = 23;
        oldToNewId[2929] = 24;
        oldToNewId[2930] = 25;
        oldToNewId[2955] = 26;
        oldToNewId[2956] = 27;
        oldToNewId[2962] = 29;
        oldToNewId[2963] = 30;
        oldToNewId[2964] = 28;
        oldToNewId[3263] = 31;
        oldToNewId[3264] = 32;
        oldToNewId[3265] = 33;
        oldToNewId[3266] = 34;
        oldToNewId[3267] = 35;
        oldToNewId[3268] = 36;
        oldToNewId[3269] = 37;
        oldToNewId[3878] = 38;
        oldToNewId[3937] = 39;
        oldToNewId[3938] = 40;
        oldToNewId[3940] = 41;
        oldToNewId[3942] = 42;
        oldToNewId[3944] = 43;
        oldToNewId[3945] = 44;
        oldToNewId[3946] = 46;
        oldToNewId[3947] = 47;
        oldToNewId[3948] = 48;
        oldToNewId[3949] = 49;
        oldToNewId[3950] = 50;
        oldToNewId[3954] = 51;
        oldToNewId[3955] = 53;
        oldToNewId[3956] = 54;
        oldToNewId[3957] = 55;
        oldToNewId[3958] = 45;
        oldToNewId[4190] = 56;
        oldToNewId[4239] = 57;
        oldToNewId[4844] = 52;
        oldToNewId[5035] = 53;
        oldToNewId[5629] = 54;
        oldToNewId[5630] = 55;
        oldToNewId[5631] = 56;
        oldToNewId[5635] = 57;
        oldToNewId[5636] = 58;
        oldToNewId[5637] = 59;
        oldToNewId[6382] = 60;
        oldToNewId[6383] = 61;
        oldToNewId[6384] = 62;
        oldToNewId[7012] = 63;
        oldToNewId[7017] = 64;
        oldToNewId[7019] = 65;
        oldToNewId[7268] = 66;
        oldToNewId[7669] = 67;
        oldToNewId[7678] = 68;
        oldToNewId[7680] = 69;
        oldToNewId[8510] = 70;
        oldToNewId[8512] = 71;
        oldToNewId[8513] = 72;
        oldToNewId[8514] = 73;
        oldToNewId[8516] = 74;
        oldToNewId[8705] = 75;
        oldToNewId[8706] = 76;
        oldToNewId[8707] = 77;
        oldToNewId[8709] = 78;
        oldToNewId[8720] = 79;
        oldToNewId[8764] = 80;

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
