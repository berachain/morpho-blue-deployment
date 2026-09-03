// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IMetaMorphoV1_1Factory} from "../../lib/metamorpho-v1.1/src/interfaces/IMetaMorphoV1_1Factory.sol";
import "../ConfiguredScript.sol";

/// @dev Warning: keys must be ordered alphabetically.
struct DeployMetaMorphoFactoryWithExistingFeePartitionerConfig {
    address metaFeePartitioner;
    bytes32 metaFeePartitionerSalt;
    bytes32 salt;
}

contract DeployMetaMorphoFactoryWithExistingFeePartitioner is ConfiguredScript {
    IMetaMorphoV1_1Factory internal metaMorphoFactory;

    function _scriptDir() internal pure override returns (string memory) {
        return "metamorpho-factory-v1.1";
    }

    function run(string memory network)
        public
        returns (DeployMetaMorphoFactoryWithExistingFeePartitionerConfig memory config)
    {
        config = abi.decode(_init(network, true), (DeployMetaMorphoFactoryWithExistingFeePartitionerConfig));

        require(config.metaFeePartitioner != address(0), "metaFeePartitioner must be set in the config");
        require(config.metaFeePartitioner.code.length != 0, "metaFeePartitioner is not a contract on this network");

        console2.log("Reusing MetaFeePartitioner at: ", config.metaFeePartitioner);

        bytes memory constructorArgs = abi.encode(address(morpho), config.metaFeePartitioner);

        metaMorphoFactory = IMetaMorphoV1_1Factory(
            _deployCreate2Code("metamorpho-v1.1", "MetaMorphoV1_1Factory", constructorArgs, config.salt)
        );
    }
}
