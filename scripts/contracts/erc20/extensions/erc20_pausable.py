from scripts.contracts import ERC20Pausable as Contract
from scripts.contracts import ERC20PausableMock as MockContract
from scripts.contracts.erc20.erc20 import ERC20
from scripts.contracts.security.pausable import Pausable


class ERC20Pausable(Pausable, ERC20):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def pause(self, pauser, sender):
        return self.contract().pause(pauser, {"from": sender})

    def unpause(self, pauser, sender):
        return self.contract().unpause(pauser, {"from": sender})


class ERC20PausableMock(ERC20Pausable):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
