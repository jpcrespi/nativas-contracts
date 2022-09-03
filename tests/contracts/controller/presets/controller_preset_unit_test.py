# from scripts.utils import Utils
# from scripts.contracts.controller.presets.controller_preset import ControllerPreset
# from scripts.contracts.erc20.presets.erc20_preset import ERC20Preset
# from scripts.contracts.offset.presets.offset_preset import OffsetPreset
# from brownie import exceptions
# from pytest import skip, raises


# def test_deploy():
#     if Utils.localNetworks() == False:
#         skip("Only local networks")
#     account = Utils.getAccount()
#     contract = ControllerPreset(sender=account)
#     token = ERC20Preset(address=contract.token())
#     assert token.name() == "Nativas"
#     assert token.symbol() == "CO2"
#     assert token.decimals() == 0
#     assert token.totalSupply() == 0
#     offset = OffsetPreset(address=contract.offset())
#     assert offset.name() == "Offset"
#     assert offset.symbol() == "OCF"
#     assert offset.decimals() == 0
#     assert offset.totalSupply() == 0


# def test_first_minter_mint():
#     if Utils.localNetworks() == False:
#         skip("Only local networks")
#     account = Utils.getAccount()
#     contract = ControllerPreset(index=-1)
#     token = ERC20Preset(address=contract.token())
#     amount = 50 * 10 ** token.decimals()
#     contract.mint(account, amount, account)
#     assert token.totalSupply() == amount
#     assert token.balanceOf(account) == amount


# def test_anybody_mint():
#     if Utils.localNetworks() == False:
#         skip("Only local networks")
#     account = Utils.getAccount(index=2)
#     contract = ControllerPreset(index=-1)
#     token = ERC20Preset(address=contract.token())
#     amount = 50 * 10 ** token.decimals()
#     with raises(exceptions.VirtualMachineError):
#         contract.mint(account, amount, account)
#     assert token.balanceOf(account) == 0
