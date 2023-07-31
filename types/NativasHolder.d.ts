/* Autogenerated file. Do not edit manually. */
/* tslint:disable */
/* eslint-disable */

import BN from "bn.js";
import { EventData, PastEventOptions } from "web3-eth-contract";

export interface NativasHolderContract
  extends Truffle.Contract<NativasHolderInstance> {
  "new"(
    entity_: string,
    operator_: string,
    controller_: string,
    holderId_: number | BN | string,
    nin_: string,
    name_: string,
    meta?: Truffle.TransactionDetails
  ): Promise<NativasHolderInstance>;
}

export interface ControlTransferred {
  name: "ControlTransferred";
  args: {
    oldController: string;
    newControllerr: string;
    0: string;
    1: string;
  };
}

export interface Initialized {
  name: "Initialized";
  args: {
    version: BN;
    0: BN;
  };
}

type AllEvents = ControlTransferred | Initialized;

export interface NativasHolderInstance extends Truffle.ContractInstance {
  /**
   * Returns the address of the current controller.
   */
  controller(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   * Initialize contract
   */
  init: {
    (
      entity_: string,
      operator_: string,
      controller_: string,
      id_: number | BN | string,
      nin_: string,
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      entity_: string,
      operator_: string,
      controller_: string,
      id_: number | BN | string,
      nin_: string,
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      entity_: string,
      operator_: string,
      controller_: string,
      id_: number | BN | string,
      nin_: string,
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      entity_: string,
      operator_: string,
      controller_: string,
      id_: number | BN | string,
      nin_: string,
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   */
  id(txDetails?: Truffle.TransactionDetails): Promise<BN>;

  /**
   */
  nin(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   */
  name(txDetails?: Truffle.TransactionDetails): Promise<string>;

  /**
   * See {IERC165-supportsInterface}.
   */
  supportsInterface(
    interfaceId: string,
    txDetails?: Truffle.TransactionDetails
  ): Promise<boolean>;

  /**
   * See {Controllable-_transferControl}.
   */
  transferControl: {
    (controller_: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(
      controller_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      controller_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      controller_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {NativasHolder-_setApprovalForAll}. Requirements: - the caller must be the controller.
   */
  setApprovalForAll: {
    (
      entity_: string,
      operator_: string,
      approved_: boolean,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      entity_: string,
      operator_: string,
      approved_: boolean,
      txDetails?: Truffle.TransactionDetails
    ): Promise<void>;
    sendTransaction(
      entity_: string,
      operator_: string,
      approved_: boolean,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      entity_: string,
      operator_: string,
      approved_: boolean,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {NativasHolder-_setName}. Requirements: - the caller must be the controller.
   */
  setName: {
    (name_: string, txDetails?: Truffle.TransactionDetails): Promise<
      Truffle.TransactionResponse<AllEvents>
    >;
    call(name_: string, txDetails?: Truffle.TransactionDetails): Promise<void>;
    sendTransaction(
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      name_: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {IERC1155TokenReceiver-onERC1155Received}.
   */
  onERC1155Received: {
    (
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      arg3: number | BN | string,
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      arg3: number | BN | string,
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    sendTransaction(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      arg3: number | BN | string,
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      arg0: string,
      arg1: string,
      arg2: number | BN | string,
      arg3: number | BN | string,
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  /**
   * See {IERC1155TokenReceiver-onERC1155BatchReceived}.
   */
  onERC1155BatchReceived: {
    (
      arg0: string,
      arg1: string,
      arg2: (number | BN | string)[],
      arg3: (number | BN | string)[],
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<Truffle.TransactionResponse<AllEvents>>;
    call(
      arg0: string,
      arg1: string,
      arg2: (number | BN | string)[],
      arg3: (number | BN | string)[],
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    sendTransaction(
      arg0: string,
      arg1: string,
      arg2: (number | BN | string)[],
      arg3: (number | BN | string)[],
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<string>;
    estimateGas(
      arg0: string,
      arg1: string,
      arg2: (number | BN | string)[],
      arg3: (number | BN | string)[],
      arg4: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<number>;
  };

  methods: {
    /**
     * Returns the address of the current controller.
     */
    controller(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     * Initialize contract
     */
    init: {
      (
        entity_: string,
        operator_: string,
        controller_: string,
        id_: number | BN | string,
        nin_: string,
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        entity_: string,
        operator_: string,
        controller_: string,
        id_: number | BN | string,
        nin_: string,
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        entity_: string,
        operator_: string,
        controller_: string,
        id_: number | BN | string,
        nin_: string,
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        entity_: string,
        operator_: string,
        controller_: string,
        id_: number | BN | string,
        nin_: string,
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     */
    id(txDetails?: Truffle.TransactionDetails): Promise<BN>;

    /**
     */
    nin(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     */
    name(txDetails?: Truffle.TransactionDetails): Promise<string>;

    /**
     * See {IERC165-supportsInterface}.
     */
    supportsInterface(
      interfaceId: string,
      txDetails?: Truffle.TransactionDetails
    ): Promise<boolean>;

    /**
     * See {Controllable-_transferControl}.
     */
    transferControl: {
      (controller_: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        controller_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        controller_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        controller_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {NativasHolder-_setApprovalForAll}. Requirements: - the caller must be the controller.
     */
    setApprovalForAll: {
      (
        entity_: string,
        operator_: string,
        approved_: boolean,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        entity_: string,
        operator_: string,
        approved_: boolean,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        entity_: string,
        operator_: string,
        approved_: boolean,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        entity_: string,
        operator_: string,
        approved_: boolean,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {NativasHolder-_setName}. Requirements: - the caller must be the controller.
     */
    setName: {
      (name_: string, txDetails?: Truffle.TransactionDetails): Promise<
        Truffle.TransactionResponse<AllEvents>
      >;
      call(
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<void>;
      sendTransaction(
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        name_: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {IERC1155TokenReceiver-onERC1155Received}.
     */
    onERC1155Received: {
      (
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        arg3: number | BN | string,
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        arg3: number | BN | string,
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      sendTransaction(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        arg3: number | BN | string,
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        arg0: string,
        arg1: string,
        arg2: number | BN | string,
        arg3: number | BN | string,
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<number>;
    };

    /**
     * See {IERC1155TokenReceiver-onERC1155BatchReceived}.
     */
    onERC1155BatchReceived: {
      (
        arg0: string,
        arg1: string,
        arg2: (number | BN | string)[],
        arg3: (number | BN | string)[],
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<Truffle.TransactionResponse<AllEvents>>;
      call(
        arg0: string,
        arg1: string,
        arg2: (number | BN | string)[],
        arg3: (number | BN | string)[],
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      sendTransaction(
        arg0: string,
        arg1: string,
        arg2: (number | BN | string)[],
        arg3: (number | BN | string)[],
        arg4: string,
        txDetails?: Truffle.TransactionDetails
      ): Promise<string>;
      estimateGas(
        arg0: string,
        arg1: string,
        arg2: (number | BN | string)[],
        arg3: (number | BN | string)[],
        arg4: string,
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