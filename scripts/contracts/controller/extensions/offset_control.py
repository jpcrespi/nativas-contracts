# from scripts.contracts import OffsetControl as Contract
# from scripts.contracts.controller.controller import Controller


# class OffsetControl(Controller):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def performOffset(self, amount, sender):
#         return self.contract().performOffset(amount, {"from": sender})
