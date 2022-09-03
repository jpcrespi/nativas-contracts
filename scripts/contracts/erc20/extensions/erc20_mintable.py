from scripts.contracts import ERC20Mintable as Contract
from scripts.contracts import ERC20MintableMock as MockContract
from scripts.contracts.erc20.erc20 import ERC20


class ERC20Mintable(ERC20):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def mint(self, to, amount, sender):
        return self.contract().mint(to, amount, {"from": sender})


class ERC20MintableMock(ERC20Mintable):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
