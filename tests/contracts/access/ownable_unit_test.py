from scripts import Utils
from scripts.contracts.access.ownable import Ownable
from brownie import exceptions
from pytest import raises, skip


def test_ownable():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    contract = Ownable(owner)
    # owner is owner
    assert contract.owner() == owner
    assert contract.owner() != account1
    assert contract.owner() != Utils.getAccountZero()
    # transfer ownership
    contract.transferOwnership(account1, owner)
    assert contract.owner() != owner
    assert contract.owner() == account1
    assert contract.owner() != Utils.getAccountZero()
    # try transfer ownership
    with raises(exceptions.VirtualMachineError):
        contract.transferOwnership(account1, owner)
    # try renounce ownership
    with raises(exceptions.VirtualMachineError):
        contract.renounceOwnership(owner)
    # renounce ownership
    contract.renounceOwnership(account1)
    assert contract.owner() != owner
    assert contract.owner() != account1
    assert contract.owner() == Utils.getAccountZero()
