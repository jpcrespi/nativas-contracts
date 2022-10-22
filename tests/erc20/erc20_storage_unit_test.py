from utils import Utils
from scripts.erc20_adapter.nativas_adapter import NativasAdapter
from pytest import skip


def test_erc20_storage():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = NativasAdapter(0, "TestCoin", "TST", 6, owner)
    # assert contract.totalSupply() == 0
    # assert contract.balanceOf(owner) == 0
    assert contract.allowance(owner, owner) == 0
