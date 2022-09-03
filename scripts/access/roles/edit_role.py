from scripts import EditRole as Contract
from scripts.utils.context import Context


class EditRole(Context):
    __contract: Contract

    EDITOR_ROLE = Contract.EDITOR_ROLE

    def __init__(self, sender):
        self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
