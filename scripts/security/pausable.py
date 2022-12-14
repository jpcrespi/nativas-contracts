from scripts import Pausable as Contract
from scripts.utils.context import Context


class Pausable(Context):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def paused(self) -> bool:
        return self.contract().paused()
