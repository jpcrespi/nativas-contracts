from scripts import AccessControlEnumerable as Contract
from scripts import AccessControlEnumerableMock as Mock
from scripts.access.access_control import AccessControl


class AccessControlEnumerable(AccessControl):
    __contract: Contract

    def __init__(self, sender: any):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self) -> any:
        return self.__contract

    def getRoleMember(self, role: bytes, index: int) -> any:
        return self.contract().getRoleMember(
            role,
            index,
        )

    def getRoleMemberCount(self, role: bytes) -> int:
        return self.contract().getRoleMemberCount(
            role,
        )


class AccessControlEnumerableMock(AccessControlEnumerable):
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

    def setRoleAdmin(
        self,
        role: bytes,
        adminRole: bytes,
        sender: any,
    ):
        tx = self.contract().setRoleAdmin(
            role,
            adminRole,
            {"from": sender},
        )
        return tx.return_value
