from datetime import datetime
from utils import Utils
from scripts.erc1155.nativas_token import NativasToken
from pytest import skip


def test_erc1155_offsettable():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = NativasToken("", Utils.getAccountZero(), owner)
    contract.mint(owner, 0, 1000, "", owner)
    contract.setOffsettable(0, True, owner)
    startDate = datetime.now().timestamp()
    contract.offset(owner, 0, 750, "", owner)
    endDate = datetime.now().timestamp()
    assert contract.getOffsetCount(owner) == 1
    id, value, date = contract.getOffsetValue(owner, 0)
    assert id == 0
    assert value == 750
    assert int(startDate) <= date <= int(endDate)
