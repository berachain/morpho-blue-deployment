#!/bin/sh

if [ -f .env ]
then
  export $(grep -v '#.*' .env | xargs)
fi

if cd lib/public-allocator/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 8453 --constructor-args 0x000000000000000000000000bbbbbbbbbb9cc5e90e3b3af64bdaf62c37eeffcb 0xA090dD1a701408Df1d4d0B85b716c87565f90467 src/PublicAllocator.sol:PublicAllocator   --show-standard-json-input > etherscan.json
  cd ../../
fi

if cd lib/public-allocator/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 80069 --constructor-args 0x000000000000000000000000827d469291f8fd7158fa2757c849e0ef4d6505d2 0x65A7bf0bb3D31f405Dce6F8546e812f5f0aB108f src/PublicAllocator.sol:PublicAllocator
  cd ../../
fi

if cd lib/public-allocator/;
then
FOUNDRY_PROFILE=build forge verify-contract --watch --chain-id 80069 --constructor-args 0x000000000000000000000000827d469291f8fd7158fa2757c849e0ef4d6505d2 0x65A7bf0bb3D31f405Dce6F8546e812f5f0aB108f src/PublicAllocator.sol:PublicAllocator
  cd ../../
fi
