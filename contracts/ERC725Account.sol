// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

import {LSP0ERC725Account} from "@lukso/lsp-smart-contracts/contracts/LSP0ERC725Account/LSP0ERC725Account.sol";
import {LSP1_UniversalProfile} from "./contracts/LSP1_UniversalProfile.sol";

contract UniversalProfile is LSP0ERC725Account, LSP1_UniversalProfile {}
