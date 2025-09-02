// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IMetaMorphoV1_1Factory} from "../../lib/metamorpho-v1.1/src/interfaces/IMetaMorphoV1_1Factory.sol";
import {MetaFeePartitionerDeployer} from "../../lib/metamorpho-v1.1/src/utils/MetaFeePartitionerDeployer.sol";
import {MetaFeePartitioner} from "../../lib/metamorpho-v1.1/src/MetaFeePartitioner.sol";
import "../ConfiguredScript.sol";

/// @dev Warning: keys must be ordered alphabetically.
struct DeployMetaMorphoFactoryConfig {
    bytes32 metaFeePartitionerSalt;
    bytes32 salt;
}

contract DeployMetaMorphoFactory is ConfiguredScript {
    IMetaMorphoV1_1Factory internal metaMorphoFactory;
    MetaFeePartitioner internal metaFeePartitioner;

    function _scriptDir() internal pure override returns (string memory) {
        return "metamorpho-factory-v1.1";
    }

    function run(string memory network) public returns (DeployMetaMorphoFactoryConfig memory config) {
        config = abi.decode(_init(network, true), (DeployMetaMorphoFactoryConfig));

        address owner = vm.envAddress("MORPHO_OWNER");
        require(owner != address(0), "MORPHO_OWNER must be set on .env");

        // Deploy metaFeePartitioner
        vm.startBroadcast();
        MetaFeePartitionerDeployer deployer =
            new MetaFeePartitionerDeployer(owner, uint256(config.metaFeePartitionerSalt));

        metaFeePartitioner = MetaFeePartitioner(deployer.feePartitioner());

        console2.log("MetaFeePartitioner deployed at: ", address(metaFeePartitioner));

        bytes memory constructorArgs = abi.encode(address(morpho), deployer.feePartitioner());

        metaMorphoFactory = IMetaMorphoV1_1Factory(
            _deployCreate2Code("metamorpho-v1.1", "MetaMorphoV1_1Factory", constructorArgs, config.salt)
        );
        vm.stopBroadcast();
    }
}
