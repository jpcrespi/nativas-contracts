from scripts.contracts import OffsetMintable as Contract
from scripts.contracts.offset.offset import Offset


class OffsetMintable(Offset):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
