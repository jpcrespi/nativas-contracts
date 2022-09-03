from scripts.contracts import BurnRole as Contract
from scripts.contracts.utils.context import Context


class BurnRole(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
