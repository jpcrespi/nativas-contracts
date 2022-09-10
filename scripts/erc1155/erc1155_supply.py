from scripts import ERC1155Supply as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible


class ERC1155Supply(ERC1155Accessible):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def totalSupply(self, id: int) -> int:
        return self.contract().totalSupply(id)

    def exists(self, id: int) -> bool:
        return self.contract().exists(id)
