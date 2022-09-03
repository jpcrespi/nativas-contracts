from scripts import Utils
from scripts.contracts.erc20.erc20_metadata import ERC20Metadata
from pytest import skip


def test_erc20_detailed():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = ERC20Metadata("TestCoin", "TST", 18, owner)
    assert contract.name() == "TestCoin"
    assert contract.symbol() == "TST"
    assert contract.decimals() == 18
