from scripts import AccessControlEnumerable as Contract
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
