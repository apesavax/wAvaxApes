// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IMyContract {
    function func1() external view returns (bytes32);

    function func2() external;
}

contract GetSelectorOfIMyContract {
    bytes4 public _interfaceId;

    constructor() {
        _interfaceId = type(IMyContract).interfaceId;
    }
}
