//SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.17;

import "./IBaseERC20.sol";

interface ILegacyERC20 is IBaseERC20 {

  /**
   * @dev Moves `amount` tokens from the caller's account to `to`.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address to, uint256 amount) external;

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external;

  /**
   * @dev Moves `amount` tokens from `from` to `to` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address from, address to, uint256 amount) external;
}
