import brownie
from brownie import network, config, accounts, ZERO_ADDRESS

# Access
AccessControlEnumerable = brownie.AccessControlEnumerableMock
AccessControl = brownie.AccessControlMock
Ownable = brownie.OwnableMock
# Access # Roles
BurnRole = brownie.BurnRole
EditRole = brownie.EditRole
MintRole = brownie.MintRole
PauseRole = brownie.PauseRole
# ERC20 # Adapter
ERC20Adapter = brownie.ERC20Adapter
# ERC165
ERC165 = brownie.ERC165Mock
# Security
Pausable = brownie.PausableMock
# Utils
Context = brownie.ContextMock

# # ERC20
# ERC20 = brownie.ERC20
# ERC20Mock = brownie.ERC20Mock
# ERC20Metadata = brownie.ERC20Metadata
# # ERC20 # Controller
# ERC20Controller = brownie.ERC20Controller
# # ERC20 # Extensions
# BEP20 = brownie.BEP20
# ERC20Accesable = brownie.ERC20Accesable
# ERC20Approve = brownie.ERC20Approve
# ERC20ApproveMock = brownie.ERC20ApproveMock
# ERC20Burnable = brownie.ERC20Burnable
# ERC20BurnableMock = brownie.ERC20BurnableMock
# ERC20Mintable = brownie.ERC20Mintable
# ERC20MintableMock = brownie.ERC20MintableMock
# ERC20Pausable = brownie.ERC20Pausable
# ERC20PausableMock = brownie.ERC20PausableMock
# # ERC20 # Presets
# ERC20Preset = brownie.ERC20Preset
# ERC20PresetMock = brownie.ERC20PresetMock
# # Offset
# Offset = brownie.Offset
# # Offset # Extensions
# OffsetMintable = brownie.OffsetMintable
# # Offset # Presets
# OffsetPreset = brownie.OffsetPreset


class Utils(object):
    @classmethod
    def localNetworks(cls):
        return network.show_active() in ["development", "ganache"]

    @classmethod
    def forkNetworks(cls):
        return network.show_active() in ["mainnet-fork", "mainnet-fork-infura"]

    @classmethod
    def getAccount(cls, index=None, id=None):
        if cls.localNetworks() or cls.forkNetworks():
            if index:
                return accounts[index]
            return accounts[0]
        if id:
            accounts.load(id)
        return accounts.add(config["wallets"]["from_key"])

    @classmethod
    def getContract(cls, name):
        return config["networks"][network.show_active()][name]

    @classmethod
    def getAccountZero(cls):
        return accounts.at(ZERO_ADDRESS, force=True)
