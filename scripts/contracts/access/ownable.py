from scripts.contracts import Ownable as Contract
from scripts.contracts.utils.context import Context


class Ownable(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def owner(self):
        return self.contract().owner()

    def renounceOwnership(self, sender):
        return self.contract().renounceOwnership({"from": sender})

    def transferOwnership(self, newOwner, sender):
        return self.contract().transferOwnership(newOwner, {"from": sender})
