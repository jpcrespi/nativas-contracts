from scripts import ERC1167 as Contract
from scripts.utils.context import Context


class ERC1167(Context):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract
