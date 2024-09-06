// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract ZKVerifier {
    bytes32 public merkleRoot;

    function setMerkleRoot(bytes32 _merkleRoot) external {
        merkleRoot = _merkleRoot;
    }

    function verifyProof(bytes32[] calldata _proof, bytes32 _leaf) external view returns (bool) {
        return MerkleProof.verify(_proof, merkleRoot, _leaf);
    }
}
