from scripts import AccessControl as Contract
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165


class AccessControl(Context, ERC165):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def hasRole(self, role: str, account: any) -> bool:
        return self.contract().hasRole(
            role.encode("utf-8"),
            account,
        )

    def getRoleAdmin(self, role: str) -> any:
        return self.contract().getRoleAdmin(
            role.encode("utf-8"),
        )

    def grantRole(self, role: str, account: any, sender: any):
        self.contract().grantRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def revokeRole(self, role: str, account: any, sender: any):
        self.contract().revokeRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def renounceRole(self, role: str, account: any, sender: any):
        self.contract().renounceRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )
