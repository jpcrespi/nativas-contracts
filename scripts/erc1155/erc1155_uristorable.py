from scripts import ERC1155URIStorable as Contract
from scripts.erc1155.erc1155_supply import ERC1155Supply
from scripts.access.roles.edit_role import EditRole


class ERC1155URIStorable(ERC1155Supply, EditRole):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def setAdapter(self, id: int, adapter: any, sender: any):
        return self.contract().setAdapter(id, adapter, {"from": sender})

    def getAdapter(self, id: int) -> any:
        return self.contract().getAdapter(id)

    def exists(self, id: int) -> bool:
        return self.contract().exists(id)

    def safeAdapterTransferFrom(
        self,
        operator: any,
        origin: any,
        to: any,
        id: int,
        amount: int,
        data: any,
        sender: any,
    ):
        return self.contract().exists(
            operator,
            origin,
            to,
            id,
            amount,
            data,
            {"from": sender},
        )
