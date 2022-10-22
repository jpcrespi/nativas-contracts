from utils import Utils
from scripts.erc1155_holder.erc1155_holder import NativasHolder
from scripts.erc1155.erc1155_preset import NativasToken
from scripts.erc1167.erc1167_holdable import NativasFactory
from pytest import skip


def test_erc1167():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    erc1155 = NativasToken("", Utils.getAccountZero(), owner)
    template = NativasHolder(
        erc1155.address(), Utils.getAccountZero(), 0, "Template", owner
    )
    erc1167 = NativasFactory(template.address(), owner)
    assert erc1167.getHolder(1) == Utils.getAccountZero()
    erc1167.putHolder(erc1155.address(), 1, "juan", owner, owner)
    nativasHolder = erc1167.getHolder(1)
    assert nativasHolder != Utils.getAccountZero()
    assert erc1155.isApprovedForAll(nativasHolder, owner)
    assert erc1155.isApprovedForAll(nativasHolder, account1) == False
