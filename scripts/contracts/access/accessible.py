from scripts.contracts import Accessible as Contract
from scripts.contracts.access.access_control_enumerable import AccessControlEnumerable


class Accessible(AccessControlEnumerable):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
