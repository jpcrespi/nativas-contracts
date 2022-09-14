from scripts import ERC1167 as Contract
from scripts.erc1167.erc1167_ownable import ERC1167Ownable


class ERC1167Adaptable(ERC1167Ownable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def getAdapter(self, id: int) -> any:
        return self.contract().getAdapter(id)

    def createAdapter(
        self,
        entity: any,
        id: int,
        name: str,
        symbol: str,
        decimals: int,
        sender: any,
    ) -> any:
        tx = self.contract().createAdapter(
            entity,
            id,
            name,
            symbol,
            decimals,
            {"from": sender},
        )
        return tx.return_value
