const OneRandomSample = artifacts.require('../OneRandomSample.sol');

require('chai')
  .use(require('chai-as-promised'))
  .should();

contract('OneRandomSample', ([deployer, author, responder]) => {
  // Deployed instance variable of the contract
  let ors;

  before(async () => {
    ors = await OneRandomSample.deployed();
  });

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await ors.address;
      assert.notEqual(address, 0x0);
      assert.notEqual(address, '');
      assert.notEqual(address, null);
      assert.notEqual(address, undefined);
    });

    it('has a name', async () => {
      const name = await ors.name();
      assert.equal(name, 'one random sample contract');
    });
  });

  describe('polls', async () => {
    let result, pollCount, txHash;
    let sentVote;

    it('can create a poll', async () => {
      result = await ors.createPoll('how do you do?', 'well', 'not so well', {
        from: author
      });

      txHash = result.tx;
      assert.lengthOf(txHash, 66, 'string has length of 66');
      // pollCount = await ors.pollIdCounter();
    });

    it('allows users to vote on polls', async () => {
      result = await ors.createPoll(
        'how do you do?',
        'well',
        'not so well',
        'amazing',
        {
          from: author
        }
      );

      sentVote = await ors.sendVote(1, 1);

      // console.log('result from sent', sent);
    });
  });
});
