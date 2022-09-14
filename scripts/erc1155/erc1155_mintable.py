from scripts import ERC1155Mintable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible
from scripts.access.roles.mint_role import MintRole


class ERC1155Mintable(ERC1155Accessible, MintRole):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def mint(
        self,
        account: any,
        id: int,
        value: int,
        data: any,
        sender: any,
    ):
        tx = self.contract().mint(
            account,
            id,
            value,
            data,
            {"from": sender},
        )
        return tx.return_value

    def mintBatch(
        self,
        account: any,
        ids: list[int],
        values: list[int],
        data: any,
        sender: any,
    ):
        tx = self.contract().mintBatch(
            account,
            ids,
            values,
            data,
            {"from": sender},
        )
        return tx.return_value
