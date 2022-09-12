from scripts import AccessControl as Contract
from scripts import AccessControlMock as Mock
from scripts.utils.context import Context
from scripts.erc165.erc165 import ERC165


class AccessControl(Context, ERC165):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def DEFAULT_ADMIN_ROLE(self) -> bytes:
        return self.contract().DEFAULT_ADMIN_ROLE.call()

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
        return self.contract().grantRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def revokeRole(self, role: str, account: any, sender: any):
        return self.contract().revokeRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def renounceRole(self, role: str, account: any, sender: any):
        return self.contract().renounceRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )


class AccessControlMock(AccessControl):
    __contract: Mock

    def __init__(self, sender: any):
        self.__contract = Mock.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def senderProtected(self, role: str, sender: any):
        return self.contract().senderProtected(
            role.encode("utf-8"),
            {"from": sender},
        )

    def setRoleAdmin(self, role: str, adminRole: str, sender: any):
        return self.contract().setRoleAdmin(
            role.encode("utf-8"),
            adminRole.encode("utf-8"),
            {"from": sender},
        )
