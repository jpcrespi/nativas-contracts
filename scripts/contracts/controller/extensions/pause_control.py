# from scripts.contracts import PauseControl as Contract
# from scripts.contracts.controller.controller import Controller


# class PauseControl(Controller):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def pause(self, sender):
#         return self.contract().pause({"from": sender})

#     def unpause(self, sender):
#         return self.contract().unpause({"from": sender})
