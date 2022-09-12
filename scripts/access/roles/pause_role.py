from scripts import PauseRole as Contract
from scripts.utils.context import Context


class PauseRole(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def PAUSER_ROLE(self) -> bytes:
        return self.contract().PAUSER_ROLE.call()
