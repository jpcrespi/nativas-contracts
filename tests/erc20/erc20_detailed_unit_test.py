from utils import Utils
from scripts.erc20_adapter.nativas_adapter import NativasAdapter
from pytest import skip


def test_erc20_detailed():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = NativasAdapter(0, "TestCoin", "TST", 6, owner)
    assert contract.name() == "TestCoin"
    assert contract.symbol() == "TST"
    assert contract.decimals() == 6
