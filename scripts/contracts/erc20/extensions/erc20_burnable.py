from scripts.contracts import ERC20Burnable as Contract
from scripts.contracts import ERC20BurnableMock as MockContract
from scripts.contracts.erc20.erc20 import ERC20


class ERC20Burnable(ERC20):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def burn(self, amount, sender):
        return self.contract().burn(amount, {"from": sender})

    def burnFrom(self, origin, amount, sender):
        return self.contract().burnFrom(origin, amount, {"from": sender})


class ERC20BurnableMock(ERC20Burnable):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
