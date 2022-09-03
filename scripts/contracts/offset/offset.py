from scripts.contracts import Offset as Contract
from scripts.contracts.access.controllable import Controllable


class Offset(Controllable):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def mint(self, to, amount, sender):
        return self.contract().mint(to, amount, {"from": sender})

