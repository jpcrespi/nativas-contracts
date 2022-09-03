from scripts.contracts import ERC20Preset as Contract
from scripts.contracts import ERC20PresetMock as MockContract
from scripts.contracts.erc20.erc20_metadata import ERC20Metadata
from scripts.contracts.erc20.extensions.erc20_approve import ERC20Approve
from scripts.contracts.erc20.extensions.erc20_burnable import ERC20Burnable
from scripts.contracts.erc20.extensions.erc20_mintable import ERC20Mintable
from scripts.contracts.erc20.extensions.erc20_pausable import ERC20Pausable


class ERC20Preset(
    ERC20Metadata,
    ERC20Approve,
    ERC20Burnable,
    ERC20Mintable,
    ERC20Pausable,
):
    __contract: Contract

    def __init__(
        self,
        name=None,
        symbol=None,
        decimals=None,
        sender=None,
        address=None,
    ):
        if address:
            self.__contract = Contract.at(address)
        if name and symbol and decimals and sender:
            self.__contract = Contract.deploy(name, symbol, decimals, {"from": sender})

    def contract(self):
        return self.__contract


class ERC20PresetMock(ERC20Preset):
    __contract: MockContract

    def __init__(self, to, amount, sender):
        self.__contract = MockContract.deploy(to, amount, {"from": sender})

    def contract(self):
        return self.__contract
