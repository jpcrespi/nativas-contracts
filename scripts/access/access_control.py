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

    def hasRole(self, role: bytes, account: any) -> bool:
        return self.contract().hasRole(
            role,
            account,
        )

    def getRoleAdmin(self, role: bytes) -> any:
        return self.contract().getRoleAdmin(
            role,
        )

    def grantRole(self, role: bytes, account: any, sender: any):
        return self.contract().grantRole(
            role,
            account,
            {"from": sender},
        )

    def revokeRole(self, role: bytes, account: any, sender: any):
        return self.contract().revokeRole(
            role,
            account,
            {"from": sender},
        )

    def renounceRole(self, role: bytes, account: any, sender: any):
        return self.contract().renounceRole(
            role,
            account,
            {"from": sender},
        )


class AccessControlMock(AccessControl):
    __contract: Mock

    def __init__(self, sender: any):
        self.__contract = Mock.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def senderProtected(self, role: bytes, sender: any):
        return self.contract().senderProtected(
            role,
            {"from": sender},
        )

    def setRoleAdmin(self, role: bytes, adminRole: bytes, sender: any):
        return self.contract().setRoleAdmin(
            role,
            adminRole,
            {"from": sender},
        )
