from scripts import Pausable as Contract
from scripts.utils.context import Context


class Pausable(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def paused(self):
        return self.contract().paused()

    def pause(self, sender):
        return self.contract().pause({"from": sender})

    def unpause(self, sender):
        return self.contract().unpause({"from": sender})
