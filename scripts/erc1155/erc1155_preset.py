from scripts import ERC1155Preset as Contract
from scripts.erc1155.erc1155_mintable import ERC1155Mintable
from scripts.erc1155.erc1155_burnable import ERC1155Burnable
from scripts.erc1155.erc1155_pausable import ERC1155Pausable
from scripts.erc1155.erc1155_offsetable import ERC1155Offsetable
from scripts.erc1155.erc1155_uristorable import ERC1155URIStorable
from scripts.erc1155.erc1155_erc20 import ERC1155ERC20


class ERC1155Preset(
    ERC1155Mintable,
    ERC1155Burnable,
    ERC1155Pausable,
    ERC1155Offsetable,
    ERC1155URIStorable,
    ERC1155ERC20,
):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def exists(self, id: int) -> bool:
        return super(ERC1155URIStorable, self).exists(id)
