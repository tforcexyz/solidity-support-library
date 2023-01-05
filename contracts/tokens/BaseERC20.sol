//SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.17;

import "../openzeppelin/contracts/utils/Context.sol";
import "./interfaces/IBaseERC20.sol";

contract BaseERC20 is Context, IBaseERC20 {

  mapping(address => uint256) private _balances;
  mapping(address => mapping(address => uint256)) private _allowances;

  uint256 private _totalSupply;

  string private _name;
  string private _symbol;
  uint8 private _decimals;

  constructor(string memory name_, string memory symbol_, uint8 decimals_) {
    _name = name_;
    _symbol = symbol_;
    _decimals = decimals_;
  }

  /**
   * @dev Returns the name of the token.
   */
  function name() public override view returns (string memory) {
    return _name;
  }

  /**
   * @dev Returns the symbol of the token.
   */
  function symbol() public override view returns (string memory) {
    return _symbol;
  }

  /**
   * @dev Returns the decimals places of the token.
   */
  function decimals() public override view returns (uint8) {
    return _decimals;
  }

  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() public override view returns (uint256) {
    return _totalSupply;
  }

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) public override view returns (uint256) {
    return _balances[account];
  }

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address owner, address spender) public override view returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * @dev Moves `amount` tokens from the `from` account to `to`.
   *
   * Emits a {Transfer} event.
   */
  function _transfer(address from, address to, uint256 amount) internal {
    require(from != address(0), "ERC20: transfer from the zero address");
    require(to != address(0), "ERC20: transfer to the zero address");

    uint256 fromBalance = _balances[from];
    require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
    unchecked {
      _balances[from] = fromBalance - amount;
      // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
      // decrementing then incrementing.
      _balances[to] += amount;
    }

    emit Transfer(from, to, amount);
  }

  /**
   * @dev Reduce `amount` as the allowance of `spender` over the `owner` tokens.
   *
   * Emits an {Approval} event.
   *
   * - `currentAllowance` must be greater than or equal `amount`.
   */
  function _spendAllowance(address owner, address spender, uint256 amount) internal {
    uint256 currentAllowance = allowance(owner, spender);
    if (currentAllowance != type(uint256).max) {
      require(currentAllowance >= amount, "ERC20: insufficient allowance");
      unchecked {
        _approve(owner, spender, currentAllowance - amount);
      }
    }
  }

  /**
   * @dev Sets `amount` as the allowance of `spender` over the `owner` tokens.
   *
   * Emits an {Approval} event.
   */
  function _approve(address owner, address spender, uint256 amount) internal {
    require(owner != address(0), "ERC20: approve from the zero address");
    require(spender != address(0), "ERC20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

  /** @dev Creates `amount` tokens and assigns them to `account`, increasing
   * the total supply.
   *
   * Emits a {Transfer} event with `from` set to the zero address.
   *
   * Requirements:
   *
   * - `account` cannot be the zero address.
   */
  function _mint(address account, uint256 amount) internal virtual {
    require(account != address(0), "ERC20: mint to the zero address");

    _totalSupply += amount;
    unchecked {
      // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
      _balances[account] += amount;
    }
    emit Transfer(address(0), account, amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, reducing the
   * total supply.
   *
   * Emits a {Transfer} event with `to` set to the zero address.
   *
   * Requirements:
   *
   * - `account` cannot be the zero address.
   * - `account` must have at least `amount` tokens.
   */
  function _burn(address account, uint256 amount) internal virtual {
    require(account != address(0), "ERC20: burn from the zero address");

    uint256 accountBalance = _balances[account];
    require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
    unchecked {
      _balances[account] = accountBalance - amount;
      // Overflow not possible: amount <= accountBalance <= totalSupply.
      _totalSupply -= amount;
    }

    emit Transfer(account, address(0), amount);
  }
}
