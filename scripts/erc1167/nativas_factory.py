from scripts import NativasFactory as Contract
from scripts.access.ownable import Ownable


class NativasFactory(Ownable):
    __contract: Contract

    def __init__(self, template: any, sender: any):
        self.__contract = Contract.deploy(
            template,
            {"from": sender},
        )

    def contract(self) -> any:
        return self.__contract

    def template(self) -> any:
        return self.contract().template()

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
        return self.contract().putHolder(
            entity,
            id,
            name,
            operator,
            {"from": sender},
        )
