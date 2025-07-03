#!/bin/sh

if [ -f .env ]
then
  export $(grep -v '#.*' .env | xargs)
fi

if cd lib/morpho-blue-bundlers/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 8453 --constructor-args 0x000000000000000000000000bbbbbbbbbb9cc5e90e3b3af64bdaf62c37eeffcb000000000000000000000000bbbbbbbbbb9cc5e90e3b3af64bdaf62c37eeffcb0000000000000000000000004200000000000000000000000000000000000006 0xb5D342521EB5b983aE6a6324A4D9eac87C9D1987 src/chain-agnostic/ChainAgnosticBundlerV2.sol:ChainAgnosticBundlerV2
  cd ../../
fi

if cd lib/morpho-blue-bundlers/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 80069 --constructor-args 0x000000000000000000000000827d469291f8fd7158fa2757c849e0ef4d6505d20000000000000000000000006969696969696969696969696969696969696969 0xACB5E53D15d44C02A386fB2A9CAB7c05F7D4079D src/ChainAgnosticBundlerV2.sol:ChainAgnosticBundlerV2
  cd ../../
fi
