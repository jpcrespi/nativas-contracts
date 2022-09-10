from brownie import network, config, accounts, ZERO_ADDRESS


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
