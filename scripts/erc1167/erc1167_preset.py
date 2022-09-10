from scripts import ERC1167 as Contract
from scripts.erc1167.erc1167_adaptable import ERC1167Adaptable
from scripts.erc1167.erc1167_holdable import ERC1167Holdable


class ERC1167Preset(ERC1167Adaptable, ERC1167Holdable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract
