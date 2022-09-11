from scripts import ERC1155Offsetable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible


class ERC1155Offsetable(ERC1155Accessible):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def offset(
        self,
        account: any,
        id: int,
        value: int,
        data: any,
        sender: any,
    ):
        return self.contract().offset(
            account,
            id,
            value,
            data,
            {"from": sender},
        )

    def offsetBatch(
        self,
        account: any,
        ids: list[int],
        values: list[int],
        data: any,
        sender: any,
    ):
        return self.contract().offsetBatch(
            account,
            ids,
            values,
            data,
            {"from": sender},
        )
