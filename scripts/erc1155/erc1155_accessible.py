from scripts import ERC1155Accessible as Contract
from scripts.erc1155.erc1155 import ERC1155
from scripts.access.access_control_enumerable import AccessControlEnumerable


class ERC1155Accessible(ERC1155, AccessControlEnumerable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract
