from scripts.contracts import ERC20Approve as Contract
from scripts.contracts import ERC20ApproveMock as MockContract
from scripts.contracts.erc20.erc20 import ERC20


class ERC20Approve(ERC20):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def increaseAllowance(self, spender, addedValue, sender):
        return self.contract().increaseAllowance(spender, addedValue, {"from": sender})

    def decreaseAllowance(self, spender, subtractedValue, sender):
        return self.contract().decreaseAllowance(
            spender, subtractedValue, {"from": sender}
        )


class ERC20ApproveMock(ERC20Approve):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
