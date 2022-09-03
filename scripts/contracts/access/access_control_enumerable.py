
from scripts.contracts import AccessControlEnumerable as Contract
from scripts.contracts.access.access_control import AccessControl


class AccessControlEnumerable(AccessControl):
    __contract: Contract

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract

    def getRoleMember(self, role: str, index):
        return self.contract().getRoleMember(
            role.encode("utf-8"),
            index,
        )

    def getRoleMemberCount(self, role: str):
        return self.contract().getRoleMemberCount(
            role.encode("utf-8")
        )
