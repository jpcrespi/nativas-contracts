from scripts import ERC1155Pausable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible
from scripts.access.roles.pause_role import PauseRole


class ERC1155Pausable(ERC1155Accessible, PauseRole):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def paused(self):
        return self.contract().paused()

    def pause(self, sender):
        return self.contract().pause({"from": sender})

    def unpause(self, sender):
        return self.contract().unpause({"from": sender})
