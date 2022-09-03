from scripts.contracts import Pausable as Contract
from scripts.contracts.utils.context import Context


class Pausable(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def paused(self):
        return self.contract().paused()

    def pause(self, pauser, sender):
        return self.contract().pause(pauser, {"from": sender})

    def unpause(self, pauser, sender):
        return self.contract().unpause(pauser, {"from": sender})
