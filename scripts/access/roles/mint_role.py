from scripts import MintRole as Contract
from scripts.utils.context import Context


class MintRole(Context):
    __contract: Contract

    MINTER_ROLE = Contract.MINTER_ROLE

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
