# from scripts.contracts import Controller as Contract
# from scripts.contracts.access.ownable import Ownable
# from scripts.contracts.access.access_control import AccessControl


# class Controller(Ownable, AccessControl):
#     __contract: Contract

#     def __init__(self, sender):
#         self.__contract = Contract.deploy({"from": sender})

#     def contract(self):
#         return self.__contract

#     def token(self):
#         return self.contract().token()

#     def offset(self):
#         return self.contract().offset()
