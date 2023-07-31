const AccessControlMock = artifacts.require('AccessControlMock');

contract('AccessControlMock', (accounts) => {
  it('', async () => {
    const accessControlInstance = await AccessControlMock.deployed();
    const adminRole = await accessControlInstance.DEFAULT_ADMIN_ROLE();
    const account0 = '0x0000000000000000000000000000000000000000';
    const account0IsAdmin = await accessControlInstance.hasRole(
      adminRole,
      account0
    );
    const account1IsAdmin = await accessControlInstance.hasRole(
      adminRole,
      accounts[0]
    );
    assert.isNotTrue(account0IsAdmin, 'account0 is admin');
    assert.isTrue(account1IsAdmin, 'account1 is admin');
  });
});
