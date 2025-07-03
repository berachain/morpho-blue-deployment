#!/bin/sh

if [ -f .env ]
then
  export $(grep -v '#.*' .env | xargs)
fi

if cd lib/universal-rewards-distributor/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 8453 --constructor-args 0x 0x7276454fc1cf9C408deeed722fd6b5E7A4CA25D8 src/UrdFactory.sol:UrdFactory  --show-standard-json-input > etherscan.json
  cd ../../
  cd ../../
fi

if cd lib/universal-rewards-distributor/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 80069 --constructor-args 0x 0xdb797363a0081Ce32Fe9d4fBa221EF10481f2Aa5 src/UrdFactory.sol:UrdFactory
  cd ../../
fi
