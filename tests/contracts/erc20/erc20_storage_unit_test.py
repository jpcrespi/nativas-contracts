from scripts import Utils
from scripts.contracts.erc20.erc20 import ERC20
from pytest import skip


def test_erc20_storage():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = ERC20(owner)
    assert contract.totalSupply() == 0
    assert contract.balanceOf(owner) == 0
    assert contract.allowance(owner, owner) == 0
