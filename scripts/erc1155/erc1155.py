from socket import IPV6_DSTOPTS
from scripts import ERC1155 as Contract
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165
from scripts.erc1155.erc1155_common import ERC1155Common


class ERC1155(Context, ERC165, ERC1155Common):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def balanceOf(self, acconut: any, id: int):
        return self.contract().balanceOf(acconut, id)

    def balanceOfBatch(self, acconuts: list[any], ids: list[int]):
        return self.contract().balanceOf(acconuts, ids)

    def setApprovalForAll(self, operator: any, approved: bool, sender: any):
        return self.contract().setApprovalForAll(operator, approved, {"from": sender})

    def isApprovedForAll(self, acconut: any, operator: any):
        return self.contract().isApprovedForAll(acconut, operator)

    def safeTransferFrom(
        self, origin: any, to: any, id: int, amount: int, data: any, sender: any
    ):
        return self.contract().safeTransferFrom(
            origin, to, id, amount, data, {"from": sender}
        )

    def safeBatchTransferFrom(
        self,
        origin: any,
        to: any,
        ids: list[int],
        amounts: list[int],
        data: any,
        sender: any,
    ):
        return self.contract().safeBatchTransferFrom(
            origin, to, ids, amounts, data, {"from": sender}
        )
