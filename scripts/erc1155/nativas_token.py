from scripts import NativasToken as Contract
from scripts.erc1155.erc1155_mintable import ERC1155Mintable
from scripts.erc1155.erc1155_burnable import ERC1155Burnable
from scripts.erc1155.erc1155_pausable import ERC1155Pausable
from scripts.erc1155.erc1155_offsettable import ERC1155Offsettable
from scripts.erc1155.erc1155_uristorable import ERC1155URIStorable
from scripts.erc1155.erc1155_erc20 import ERC1155ERC20


class NativasToken(
    ERC1155Mintable,
    ERC1155Burnable,
    ERC1155Pausable,
    ERC1155Offsettable,
    ERC1155URIStorable,
    ERC1155ERC20,
):
    __contract: Contract

    def __init__(
        self,
        uri: str,
        template: any,
        sender: any,
    ):
        self.__contract = Contract.deploy(
            uri,
            template,
            {"from": sender},
        )

    def contract(self) -> any:
        return self.__contract

    def exists(self, id: int) -> bool:
        return self.contract().exists(id)

    def setMetadata(
        self,
        id: int,
        name: str,
        symbol: str,
        decimals: int,
        uri: str,
        offsettable: bool,
        sender: any,
    ) -> any:
        return self.contract().setMetadata(
            id,
            name,
            symbol,
            decimals,
            uri,
            offsettable,
            {"from": sender},
        )
