const AccessControlMock = artifacts.require('AccessControlMock')

const migration: Truffle.Migration = function (deployer) {
  deployer.deploy(AccessControlMock)
}

module.exports = migration

export {}
