# Dotenv

- export PRIVATE_KEY =
- export WEB3_INFURA_PROJECT_ID =
- export ETHERSCAN_TOKEN =
- export FLASK_APP = app
- export FLASK_ENV = development

# Networks

### Mainnet Fork

```bash
❯ brownie networks add Development mainnet-fork-infura \
    name="Infura (Mainnet Fork)" \
    host=http://127.0.0.1 \
    port=8545 \
    cmd=ganache-cli \
    fork='https://mainnet.infura.io/v3/$WEB3_INFURA_PROJECT_ID' \
    accounts=10 \
    mnemonic=brownie 
```

### Permanent Ganache

```bash
❯ brownie networks add Ethereum ganache \
    name="Ganache (Local)" \
    host=http://127.0.0.1 \
    port=8545 \
    chainid=1337
```