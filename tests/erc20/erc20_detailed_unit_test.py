from utils import Utils
from scripts.erc20_adapter.erc20_adapter import ERC20Adapter
from pytest import skip


def test_erc20_detailed():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = ERC20Adapter(owner)
    contract.init(0, "TestCoin", "TST", 6, owner)
    assert contract.name() == "TestCoin"
    assert contract.symbol() == "TST"
    assert contract.decimals() == 6
