from scripts.contracts import Controllable as Contract
from scripts.contracts.utils.context import Context


class Controllable(Context):
    __contract: Contract

    def __init__(self, controller, sender):
        self.__contract = Contract.deploy(controller, {"from": sender})

    def contract(self):
        return self.__contract

    def controller(self):
        return self.contract().controller()
