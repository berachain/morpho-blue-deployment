#!/bin/sh

if [ -f .env ]
then
  export $(grep -v '#.*' .env | xargs)
fi

if cd lib/morpho-blue/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain 80069 --constructor-args 0x0000000000000000000000000cf32c7c003bd9fdbd5ba635daedcb1070e77de0 0x827D469291f8fd7158Fa2757c849E0ef4D6505d2 src/Morpho.sol:Morpho --verifier-url https://api-testnet.berascan.com/api --verifier-api-key 84YNT91AFA69XD6S4F7FM99Q95JN1IYDUA
  cd ../../
fi

if cd lib/morpho-blue-irm/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain 80069 --constructor-args 0x000000000000000000000000827d469291f8fd7158fa2757c849e0ef4d6505d2 0x926C578948f2e5ccD7413c2C098252109Db01337 src/AdaptiveCurveIrm.sol:AdaptiveCurveIrm --verifier-url https://api-testnet.berascan.com/api --verifier-api-key 84YNT91AFA69XD6S4F7FM99Q95JN1IYDUA
  cd ../../
fi
