from datetime import datetime
from utils import Utils
from scripts.erc1155.erc1155_preset import ERC1155Preset
from pytest import skip


def test_erc1155_offsetable():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = ERC1155Preset("", owner)
    contract.mint(owner, 0, 1000, "", owner)
    startDate = datetime.now().timestamp()
    contract.offset(owner, 0, 750, "", owner)
    endDate = datetime.now().timestamp()
    assert contract.getOffsetCount(owner) == 1
    id, value, date = contract.getOffsetValue(owner, 0)
    assert id == 0
    assert value == 750
    assert int(startDate) <= date <= int(endDate)
