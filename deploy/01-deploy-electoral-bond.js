const {network} = require('hardhat');
const {networkConfig, developmentChains} = require('../helper-hardhart-config');

module.exports = async ({getNamedAccounts, deployments}) => {
    const {deploy, log} = deployments;
    const {deployer} = await getNamedAccounts();

    log('Deploying Electoral Bond..........')
    const electoralBond = await deploy("ElectoralBond", {
        from: deployer,
        log: true,
        waitConformations: network.config.blockConfirmations || 1
    });
    log(`Electoral Bond deployed at ${electoralBond.address}`);
}