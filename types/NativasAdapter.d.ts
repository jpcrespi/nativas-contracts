/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface NativasAdapterContract
  extends Truffle.Contract<NativasAdapterInstance> {
  "new"(
    tokenId_: number | BN | string,
    name_: string,
    symbol_: string,
    decimals_: number | BN | string,
    meta?: Truffle.TransactionDetails
  ): Promise<NativasAdapterInstance>;
}

export interface Approval {
  name: "Approval";
  args: {
    owner: string;
    spender: string;
    value: BN;
    0: string;
    1: string;
    2: BN;
  };
}

export interface Initialized {
  name: "Initialized";
  args: {
    version: BN;
    0: BN;
  };
}

export interface Transfer {
  name: "Transfer";
  args: {
    from: string;
    to: string;
    value: BN;
    0: string;
    1: string;
    2: BN;
  };
}

type AllEvents = Approval | Initialized | Transfer;

export interface NativasAdapterInstance extends Truffle.ContractInstance {
  /**
   * Initialize contract
   */
  init: {
    (
      tokenId_: number | BN | string,
      name_: string,
      symbol_: string,
      decimals_: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      tokenId_: number | BN | string,
      name_: string,
      symbol_: string,
      decimals_: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      tokenId_: number | BN | string,
      name_: string,
      symbol_: string,
      decimals_: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      tokenId_: number | BN | string,
      name_: string,
      symbol_: string,
      decimals_: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {IERC165-supportsInterface}.
   */
  supportsInterface(
    interfaceId: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<boolean>;

  /**
   * ERC1155 token address.
   */
  entity(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   * ERC1155 token indentifier.
   */
  id(txDetails?: Truffle.TransactionDetails): Promise<BN>;

  /**
   * See {IERC20-name}.
   */
  name(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   * See {IERC20-symbol}.
   */
  symbol(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   * See {IERC20-decimals}.
   */
  decimals(txDetails?: Truffle.TransactionDetails): Promise<BN>;

  /**
   * See {IERC20-totalSupply}.
   */
  totalSupply(txDetails?: Truffle.TransactionDetails): Promise<BN>;

  /**
   * See {IERC20-balanceOf}.
   */
  balanceOf(
    account: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<BN>;

  /**
   * See {IERC20-allowance}.
   */
  allowance(
    arg0: string,
    arg1: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<BN>;

  /**
   * See {IERC20-approve}.
   */
  approve: {
    (
      arg0: string,
      arg1: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      arg0: string,
      arg1: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;
    sendTransaction(
      arg0: string,
      arg1: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      arg0: string,
      arg1: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {IERC20-transfer}.
   */
  transfer: {
    (
      to: string,
      amount: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      to: string,
      amount: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;
    sendTransaction(
      to: string,
      amount: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      to: string,
      amount: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {IERC20-transferFrom}.
   */
  transferFrom: {
    (
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;
    sendTransaction(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  methods: {
    /**
     * Initialize contract
     */
    init: {
      (
        tokenId_: number | BN | string,
        name_: string,
        symbol_: string,
        decimals_: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        tokenId_: number | BN | string,
        name_: string,
        symbol_: string,
        decimals_: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        tokenId_: number | BN | string,
        name_: string,
        symbol_: string,
        decimals_: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        tokenId_: number | BN | string,
        name_: string,
        symbol_: string,
        decimals_: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {IERC165-supportsInterface}.
     */
    supportsInterface(
      interfaceId: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;

    /**
     * ERC1155 token address.
     */
    entity(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     * ERC1155 token indentifier.
     */
    id(txDetails?: Truffle.TransactionDetails): Promise<BN>;

    /**
     * See {IERC20-name}.
     */
    name(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     * See {IERC20-symbol}.
     */
    symbol(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     * See {IERC20-decimals}.
     */
    decimals(txDetails?: Truffle.TransactionDetails): Promise<BN>;

    /**
     * See {IERC20-totalSupply}.
     */
    totalSupply(txDetails?: Truffle.TransactionDetails): Promise<BN>;

    /**
     * See {IERC20-balanceOf}.
     */
    balanceOf(
      account: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<BN>;

    /**
     * See {IERC20-allowance}.
     */
    allowance(
      arg0: string,
      arg1: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<BN>;

    /**
     * See {IERC20-approve}.
     */
    approve: {
      (
        arg0: string,
        arg1: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        arg0: string,
        arg1: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<boolean>;
      sendTransaction(
        arg0: string,
        arg1: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        arg0: string,
        arg1: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {IERC20-transfer}.
     */
    transfer: {
      (
        to: string,
        amount: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        to: string,
        amount: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<boolean>;
      sendTransaction(
        to: string,
        amount: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        to: string,
        amount: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {IERC20-transferFrom}.
     */
    transferFrom: {
      (
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<boolean>;
      sendTransaction(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };
  };

  getPastEvents(event: string): Promise<EventData[]>;
  getPastEvents(
    event: string,
    options: PastEventOptions,
    callback: (error: Error, event: EventData) => void
  ): Promise<EventData[]>;
  getPastEvents(event: string, options: PastEventOptions): Promise<EventData[]>;
  getPastEvents(
    event: string,
    callback: (error: Error, event: EventData) => void
  ): Promise<EventData[]>;
}