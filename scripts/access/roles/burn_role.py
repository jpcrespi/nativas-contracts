from scripts import BurnRole as Contract
from scripts.utils.context import Context


class BurnRole(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def BURNER_ROLE(self) -> bytes:
        return self.contract().BURNER_ROLE.call()
