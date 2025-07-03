#!/bin/sh

if [ -f .env ]
then
  export $(grep -v '#.*' .env | xargs)
fi


if cd lib/morpho-blue-oracles/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 80069 --constructor-args 0x 0x2DC205F24BCb6B311E5cdf0745B0741648Aebd3d src/morpho-chainlink/MorphoChainlinkOracleV2Factory.sol:MorphoChainlinkOracleV2Factory --verifier-url https://api-testnet.berascan.com/api --verifier-api-key 84YNT91AFA69XD6S4F7FM99Q95JN1IYDUA --compiler-version 0.8.21
  cd ../../
fi
