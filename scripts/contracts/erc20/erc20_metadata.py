from scripts.contracts import ERC20Metadata as Contract


class ERC20Metadata(object):
    __contract: Contract

    def __init__(self, name, symbol, decimals, sender):
        self.__contract = Contract.deploy(name, symbol, decimals, {"from": sender})

    def contract(self):
        return self.__contract

    def name(self):
        return self.contract().name()

    def symbol(self):
        return self.contract().symbol()

    def decimals(self):
        return self.contract().decimals()
