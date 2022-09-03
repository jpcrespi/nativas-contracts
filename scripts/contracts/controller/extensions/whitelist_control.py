# from scripts.contracts import WhitelistControl as Contract
# from scripts.contracts.controller.controller import Controller


# class WhitelistControl(Controller):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def addBlacklisted(self, account, sender):
#         return self.contract().addBlacklisted(account, {"from": sender})

#     def removeBlacklisted(self, account, sender):
#         return self.contract().removeBlacklisted(account, {"from": sender})
