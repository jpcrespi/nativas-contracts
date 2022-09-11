from scripts import Ownable as Contract
from scripts.utils.context import Context


class Ownable(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def owner(self) -> any:
        return self.contract().owner()

    def renounceOwnership(self, sender: any):
        return self.contract().renounceOwnership({"from": sender})

    def transferOwnership(self, newOwner: any, sender: any):
        return self.contract().transferOwnership(newOwner, {"from": sender})
