from scripts import Utils
from scripts.contracts.erc20.extensions.erc20_burnable import ERC20BurnableMock
from brownie import exceptions
from pytest import skip, raises


def test_erc20_burnable():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    # account1 = Utils.getAccount(index=1)
    # account2 = Utils.getAccount(index=2)
    contract = ERC20BurnableMock(owner, 100, owner)
    assert contract.balanceOf(owner) == 100
    assert contract.totalSupply() == 100
    assert contract.burn(25, owner)
    assert contract.balanceOf(owner) == 75
    assert contract.totalSupply() == 75


def test_erc20_burnable_from():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    account2 = Utils.getAccount(index=2)
    contract = ERC20BurnableMock(account1, 100, owner)
    assert contract.balanceOf(account1) == 100
    assert contract.totalSupply() == 100
    with raises(exceptions.VirtualMachineError):
        contract.burnFrom(account1, 25, owner)
    contract.approve(owner, 25, account1)
    contract.approve(account2, 25, account1)
    with raises(exceptions.VirtualMachineError):
        contract.burnFrom(account1, 25, account2)
    assert contract.burnFrom(account1, 25, owner)
    assert contract.balanceOf(account1) == 75
    assert contract.totalSupply() == 75
