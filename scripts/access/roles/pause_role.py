from scripts import PauseRole as Contract
from scripts.utils.context import Context


class PauseRole(Context):
    __contract: Contract

    PAUSER_ROLE = Contract.PAUSER_ROLE

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
