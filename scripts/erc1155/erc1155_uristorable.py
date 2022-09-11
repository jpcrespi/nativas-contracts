from scripts import ERC1155URIStorable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible
from scripts.access.roles.edit_role import EditRole


class ERC1155URIStorable(ERC1155Accessible, EditRole):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def setURI(self, id: int, uri: any, sender: any):
        return self.contract().setURI(id, uri, {"from": sender})

    def uri(self, id: int) -> str:
        return self.contract().uri(id)

    def exists(self, id: int) -> bool:
        return self.contract().exists(id)
