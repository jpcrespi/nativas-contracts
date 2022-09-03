from scripts.contracts import OffsetPreset as Contract
from scripts.contracts.offset.extensions.offset_mintable import OffsetMintable
from scripts.contracts.erc20.erc20_metadata import ERC20Metadata


class OffsetPreset(ERC20Metadata, OffsetMintable):
    __contract: Contract

    def __init__(self, sender=None, address=None):
        if address:
            self.__contract = Contract.at(address)
        if sender:
            self.__contract = Contract.deploy({"from": sender})

    def contract(self):
        return self.__contract
    