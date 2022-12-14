from scripts import NativasHolder as Contract
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165


class NativasHolder(Context, ERC165):
    __contract: Contract

    def __init__(
        self,
        entity: any,
        operator: any,
        id: int,
        name: str,
        sender: any,
    ):
        self.__contract = Contract.deploy(
            entity,
            operator,
            id,
            name,
            {"from": sender},
        )

    def contract(self) -> any:
        return self.__contract

    def init(
        self,
        entity: any,
        operator: any,
        id: int,
        name: str,
        sender: any,
    ):
        return self.contract().init(
            entity,
            operator,
            id,
            name,
            {"from": sender},
        )

    def id(self) -> int:
        return self.contract().id()

    def name(self) -> str:
        return self.contract().name()
