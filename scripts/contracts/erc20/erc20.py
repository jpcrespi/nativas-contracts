from scripts.contracts import ERC20 as Contract
from scripts.contracts import ERC20Mock as MockContract


class ERC20(object):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def totalSupply(self):
        return self.contract().totalSupply()

    def balanceOf(self, acconut):
        return self.contract().balanceOf(acconut)

    def allowance(self, owner, spender):
        return self.contract().allowance(owner, spender)

    def approve(self, spender, amount, sender):
        return self.contract().approve(spender, amount, {"from": sender})

    def transfer(self, to, amount, sender):
        return self.contract().transfer(to, amount, {"from": sender})

    def transferFrom(self, origin, to, amount, sender):
        return self.contract().transferFrom(origin, to, amount, {"from": sender})


class ERC20Mock(ERC20):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
