from scripts import ERC20Adapter as Contract
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165


class ERC20Adapter(Context, ERC165):
    __contract: Contract

    def __init__(self, entity, id, name, symbol, decimals, sender):
        self.__contract = Contract.deploy(
            entity, id, name, symbol, decimals, {"from": sender}
        )

    def contract(self):
        return self.__contract

    def entity(self):
        return self.contract().entity()

    def id(self):
        return self.contract().id()

    def name(self):
        return self.contract().name()

    def symbol(self):
        return self.contract().symbol()

    def decimals(self):
        return self.contract().decimals()

    def getOwner(self):
        return self.contract().getOwner()

    def totalSupply(self):
        return self.contract().totalSupply()

    def balanceOf(self, acconut):
        return self.contract().balanceOf(acconut)

    def allowance(self, owner, spender):
        return self.contract().allowance(owner, spender)

    def approve(self, spender, amount, sender):
        return self.contract().approve(spender, amount, {"from": sender})

    def increaseAllowance(self, spender, value, sender):
        return self.contract().increaseAllowance(spender, value, {"from": sender})

    def decreaseAllowance(self, spender, value, sender):
        return self.contract().decreaseAllowance(spender, value, {"from": sender})

    def transfer(self, to, amount, sender):
        return self.contract().transfer(to, amount, {"from": sender})

    def transferFrom(self, origin, to, amount, sender):
        return self.contract().transferFrom(origin, to, amount, {"from": sender})
