from scripts import Context as Contract


class Context(object):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def address(self) -> any:
        return self.contract().address
