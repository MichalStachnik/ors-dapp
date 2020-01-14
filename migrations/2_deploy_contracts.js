const OneRandomSample = artifacts.require('OneRandomSample');

module.exports = function(deployer) {
  deployer.deploy(OneRandomSample, 'how are you', 'ok', 'not so ok');
};
