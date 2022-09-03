from scripts.contracts import AccessControl as Contract
from scripts.contracts.utils.context import Context


class AccessControl(Context):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def hasRole(self, role: str, account):
        return self.contract().hasRole(
            role.encode("utf-8"),
            account,
        )

    def senderProtected(self, role: str, sender):
        return self.contract().senderProtected(
            role.encode("utf-8"),
            {"from": sender},
        )

    def setRoleAdmin(self, role: str, adminRole: str, sender):
        return self.contract().setRoleAdmin(
            role.encode("utf-8"),
            adminRole.encode("utf-8"),
            {"from": sender},
        )

    def setRoleAdmin(self, role: str):
        return self.contract().getRoleAdmin(
            role.encode("utf-8"),
        )

    def grantRole(self, role: str, account, sender):
        return self.contract().grantRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def revokeRole(self, role: str, account, sender):
        return self.contract().revokeRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )

    def renounceRole(self, role: str, account, sender):
        return self.contract().renounceRole(
            role.encode("utf-8"),
            account,
            {"from": sender},
        )
