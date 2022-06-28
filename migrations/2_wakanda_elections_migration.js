const WakandaElections = artifacts.require("WakandaElections");

module.exports = function (deployer) {
  deployer.deploy(WakandaElections);
};
