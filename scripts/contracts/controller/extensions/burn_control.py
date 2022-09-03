# from scripts.contracts import BurnControl as Contract
# from scripts.contracts.controller.controller import Controller


# class BurnControl(Controller):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def burn(self, amount, sender):
#         return self.contract().burn(amount, {"from": sender})

#     def burnFrom(self, origin, amount, sender):
#         return self.contract().burnFrom(origin, amount, {"from": sender})
