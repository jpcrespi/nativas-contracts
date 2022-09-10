from scripts import ERC1167 as Contract
from scripts.erc1167.erc1167 import ERC1167
from scripts.access.ownable import Ownable


class ERC1167Ownable(ERC1167, Ownable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract
