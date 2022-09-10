from scripts import ERC1155Common as Contract


class ERC1155Common(object):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract
