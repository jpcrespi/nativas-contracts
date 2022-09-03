from scripts import Utils
from scripts.contracts.erc20.extensions.erc20_approve import ERC20ApproveMock
from brownie import exceptions
from pytest import skip, raises


def test_erc20_approve():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    account2 = Utils.getAccount(index=2)
    contract = ERC20ApproveMock(owner, 1000, owner)
    contract.approve(account2, 100, account1)
    assert contract.allowance(account1, account2) == 100
    assert contract.increaseAllowance(account2, 50, account1)
    assert contract.allowance(account1, account2) == 150
    assert contract.decreaseAllowance(account2, 100, account1)
    assert contract.allowance(account1, account2) == 50
    with raises(exceptions.VirtualMachineError):
        contract.decreaseAllowance(account2, 100, account1)
