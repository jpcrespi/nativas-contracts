from scripts import Utils
from scripts.contracts.access.controllable import Controllable
from pytest import skip


def test_controllable():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    controller = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    contract = Controllable(controller)
    # controller is controller
    assert contract.controller() == controller
    assert contract.controller() != account1
    assert contract.controller() != Utils.getAccountZero()
