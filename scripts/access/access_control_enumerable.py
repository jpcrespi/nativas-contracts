from scripts import AccessControlEnumerable as Contract
from scripts import AccessControlEnumerableMock as Mock
from scripts.access.access_control import AccessControl


class AccessControlEnumerable(AccessControl):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def getRoleMember(self, role: str, index: int) -> any:
        return self.contract().getRoleMember(
            role.encode("utf-8"),
            index,
        )

    def getRoleMemberCount(self, role: str) -> int:
        return self.contract().getRoleMemberCount(
            role.encode("utf-8"),
        )


class AccessControlEnumerableMock(AccessControlEnumerable):
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
