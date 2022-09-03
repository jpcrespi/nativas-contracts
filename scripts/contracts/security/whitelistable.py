from scripts.contracts import Whitelistable as Contract
from scripts.contracts.utils.context import Context


class Whitelistable(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def isWhitelisted(self, account):
        return self.contract().isWhitelisted(account)
