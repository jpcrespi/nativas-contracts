from scripts import ERC1155Burnable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible
from scripts.access.roles.burn_role import BurnRole


class ERC1155Burnable(ERC1155Accessible, BurnRole):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def burn(
        self,
        account: any,
        id: int,
        value: int,
        data: any,
        sender: any,
    ):
        return self.contract().burn(
            account,
            id,
            value,
            data,
            {"from": sender},
        )

    def burnBatch(
        self,
        account: any,
        ids: list[int],
        values: list[int],
        data: any,
        sender: any,
    ):
        return self.contract().burnBatch(
            account,
            ids,
            values,
            data,
            {"from": sender},
        )
