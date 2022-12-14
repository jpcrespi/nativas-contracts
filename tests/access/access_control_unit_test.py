from utils import Utils
from scripts.access.access_control import AccessControlMock
from brownie import exceptions
from pytest import skip, raises


def test_access_control():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    adminRole = Utils.getAccount()
    account1 = Utils.getAccount(index=1)
    account2 = Utils.getAccount(index=2)
    contract = AccessControlMock(adminRole)
    TEST_ROLE = Utils.getRole("TEST_ROLE")
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account1)
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account2)
    contract.grantRole(TEST_ROLE, account1, adminRole)
    assert contract.senderProtected(TEST_ROLE, account1)
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account2)
    contract.grantRole(TEST_ROLE, account2, adminRole)
    assert contract.senderProtected(TEST_ROLE, account1)
    assert contract.senderProtected(TEST_ROLE, account2)
    contract.revokeRole(TEST_ROLE, account1, adminRole)
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account1)
    assert contract.senderProtected(TEST_ROLE, account2)
    contract.renounceRole(TEST_ROLE, account2, account2)
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account1)
    with raises(exceptions.VirtualMachineError):
        contract.senderProtected(TEST_ROLE, account2)
