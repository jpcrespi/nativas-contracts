# from brownie import config, network
# from scripts.contracts import ControllerPreset as Contract
# from scripts.contracts.controller.extensions.burn_control import BurnControl
# from scripts.contracts.controller.extensions.mint_control import MintControl
# from scripts.contracts.controller.extensions.offset_control import OffsetControl
# from scripts.contracts.controller.extensions.pause_control import PauseControl
# from scripts.contracts.controller.extensions.whitelist_control import WhitelistControl


# class ControllerPreset(
#     BurnControl, MintControl, OffsetControl, PauseControl, WhitelistControl
# ):
#     __contract: Contract

#     def __init__(self, sender=None, address=None, index=None):
#         if address:
#             self.__contract = Contract.at(address)
#         if index:
#             self.__contract = Contract[index]
#         if sender:
#             self.__contract = Contract.deploy(
#                 {"from": sender},
#                 publish_source=config["networks"][network.show_active()].get(
#                     "verify", False
#                 ),
#             )

#     def contract(self):
#         return self.__contract
