# from scripts.contracts import MintControl as Contract
# from scripts.contracts.controller.controller import Controller


# class MintControl(Controller):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def mint(self, to, amount, sender):
#         return self.contract().mint(to, amount, {"from": sender})
