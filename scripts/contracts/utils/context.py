from scripts.contracts import Context as Contract


class Context(object):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def address(self):
        return self.contract().address
