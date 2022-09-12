from utils import Utils
from scripts.access.roles.burn_role import BurnRole
from brownie import exceptions
from pytest import raises, skip
from sha3 import keccak_256


def test_burn_role():
    if Utils.localNetworks() == False:
        skip("Only local networks")
    owner = Utils.getAccount()
    contract = BurnRole(owner)
    assert contract.BURNER_ROLE() == Utils.getRole("BURNER_ROLE")
