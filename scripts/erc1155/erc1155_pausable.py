from scripts import ERC1155Pausable as Contract
from scripts.erc1155.erc1155_accessible import ERC1155Accessible
from scripts.access.roles.pause_role import PauseRole
from scripts.security.pausable import Pausable


class ERC1155Pausable(ERC1155Accessible, PauseRole, Pausable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def pause(self, sender: any):
        self.contract().pause({"from": sender})

    def unpause(self, sender: any):
        self.contract().unpause({"from": sender})
