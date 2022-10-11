from utils import Utils
from scripts.erc1155.erc1155_preset import ERC1155Preset
from scripts.erc1167.erc1167_holdable import ERC1167Holder
from pytest import skip


def test_erc1167():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    erc1155 = ERC1155Preset("", owner)
    erc1167 = ERC1167Holder(owner)
    assert erc1167.getHolder(1) == Utils.getAccountZero()
    erc1167.putHolder(erc1155.address(), 1, "juan", owner, owner)
    erc1155Holder = erc1167.getHolder(1)
    assert erc1155Holder != Utils.getAccountZero()
    assert erc1155.isApprovedForAll(erc1155Holder, owner)
    assert erc1155.isApprovedForAll(erc1155Holder, account1) == False
