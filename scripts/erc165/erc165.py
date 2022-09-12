from scripts import ERC165 as Contract


class ERC165(object):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def supportsInterface(self, interfaceId: str) -> bool:
        return self.contract().supportsInterface(
            interfaceId.encode("utf-8"),
        )
