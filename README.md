# Dotenv

- export WEB3_INFURA_PROJECT_ID =
- export FLASK_APP = app
- export FLASK_ENV = development

## Networks

### Permanent Ganache

```bash
❯ brownie networks add Ethereum localnet \
    name="Localnet (Ganache)" \
    host="http://127.0.0.1:7545" \
    cmd=ganache-cli \
    chainid=5777 \
    accounts=10 \
    mnemonic=nativas
```

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
