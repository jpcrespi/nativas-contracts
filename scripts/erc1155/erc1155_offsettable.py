from scripts import ERC1155Offsettable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible


class ERC1155Offsettable(ERC1155Accessible):
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

    def getOffsetValue(
        self,
        account: any,
        index: int,
    ) -> any:
        return self.contract().getOffsetValue(
            account,
            index,
        )

    def getOffsetCount(
        self,
        account: any,
    ) -> int:
        return self.contract().getOffsetCount(
            account,
        )

    def offsettable(
        self,
        id: int,
    ) -> bool:
        return self.contract().offsettable(
            id,
        )

    def setOffsettable(
        self,
        id: int,
        enabled: bool,
        sender: any,
    ) -> bool:
        return self.contract().setOffsettable(
            id,
            enabled,
            {"from": sender},
        )
