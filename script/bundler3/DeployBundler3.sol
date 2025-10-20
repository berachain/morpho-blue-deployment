// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../ConfiguredScript.sol";

/// @dev Warning: keys must be ordered alphabetically.
struct BundlerConfig {
    string adapterName;
    bytes32[] args;
    bytes32 bundler3salt;
    bytes32 generalAdapterSalt;
}

contract DeployBundlers3 is ConfiguredScript {
    function _scriptDir() internal pure override returns (string memory) {
        return "bundler3";
    }

    function run(string memory network) public returns (BundlerConfig[] memory config) {
        config = abi.decode(_init(network, true), (BundlerConfig[]));
        console2.log("Deploying Bundler3 contracts with the following configuration:");

        for (uint256 i; i < config.length; ++i) {
            BundlerConfig memory bundlerConfig = config[i];
            // Deploy the bundler3 contract.
            address bundler3 = _deployCreate2Code("bundler3", "Bundler3", bytes(""), bundlerConfig.bundler3salt);

            // Bundler3 address is always expected first in GeneralAdapter constructor.
            // Morpho address is always expected to be the second in GeneralAdapter constructor.
            bytes memory constructorArgs = abi.encode(address(bundler3), address(morpho));
            for (uint256 j; j < bundlerConfig.args.length; ++j) {
                constructorArgs = bytes.concat(constructorArgs, abi.encode(bundlerConfig.args[j]));
            }

            // Deploy the general adapter contract.
            _deployCreate2Code("bundler3", bundlerConfig.adapterName, constructorArgs, bundlerConfig.generalAdapterSalt);
        }
    }
}
