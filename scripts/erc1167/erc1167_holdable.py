from scripts import ERC1167 as Contract
from scripts.erc1167.erc1167_ownable import ERC1167Ownable


class ERC1167Holdable(ERC1167Ownable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def getHolder(self, id: int) -> any:
        return self.contract().getHolder(id)

    def createHolder(
        self,
        entity: any,
        id: int,
        name: str,
        operator: any,
        sender: any,
    ) -> any:
        return self.contract().createHolder(
            entity,
            id,
            name,
            operator,
            {"from": sender},
        )
