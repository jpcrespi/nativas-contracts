from scripts import ERC1167Holder as Contract
from scripts.utils.context import Context
from scripts.access.ownable import Ownable


class ERC1167Holder(Ownable):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def getHolder(self, id: int) -> any:
        return self.contract().getHolder(id)

    def putHolder(
        self,
        entity: any,
        id: int,
        name: str,
        operator: any,
        sender: any,
    ) -> any:
        tx = self.contract().putHolder(
            entity,
            id,
            name,
            operator,
            {"from": sender},
        )
        return tx.return_value
