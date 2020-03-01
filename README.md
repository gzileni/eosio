# EOS Docker Node Test Network

## Operating System
The EOSIO software supports the following environments for development and/or deployment:

- Amazon Linux 2
- Centos 7
- Ubuntu 16.04
- Ubuntu 18.04
- MacOS 10.14 (Mojave) and higher

## Run Docker

```
git clone https://github.com/gzileni/eosio.git
cd eosio
docker-compose up
```

## How to use Scatter
1. Navigate to [https://get-scatter.com](https://get-scatter.com).
2. Download and Install Scatter on your device.
3. Launch the newly installed Scatter application.
4. Click I’m New to Blockchain button.
5. Read and accept Terms.
6. Key a strong password, click Next.
7. On the intro screen, click the Start using Scatter button.

### How to generate an EOS keypair
1. On the wallet screen, click the Generate Key button.
2. On the Generate Keypair screen, click the EOSIO button.
3. On the Exporting Private Key screen, click the Back button.
4. Your new EOSIO Key is now visible in your Scatter wallet.

### How to import an EOS keypair
1. On the wallet screen, click Import Key
2. On the import key screen, click Text
3. Paste in the private key to import

### How to get a public key
1. On the wallet screen, expand the Actions menu (the three dots next to the key symbol) and click Copy Public Key.

### How to get a private key
1. On the wallet screen, click the key symbol and enter password.
2. Select the "Key" option.
3. Double click on the public key and copy it to your clipboard (clicking the copy button places both the public and private key in your clipboard).
4. Click the back button to return to the wallet screen.

### How to name a public key
1. On the wallet screen, expand the Actions menu (the three dots next to the key symbol) and click Edit Name.

## CLEOS SUPPORT

*Notes:*
*Please read through these instructions at least once before installing software and executing commands.*
*A blockchain has certain attributes that are relevant when executing cleos commands.* 

Those attributes are as follows: 

- network_api_url 
- token_precision 
- token_symbol

What the above means is that if a cleos command, which deals with tokens, is to be executed against a chain at network_api_url, then the token_precision and token_symbol of said cleos command must match the token precision and token symbol of the specified chain.

### Supported Operating Systems
* Ubuntu
* OSX

### Installation
Open a terminal on the appropriate operating system and run the commands below.

#### OSX

```
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap eosio/eosio
brew install eosio
```

#### Ubuntu 18.04

```
wget https://github.com/EOSIO/eos/releases/download/v1.7.0/eosio_1.7.0-1-ubuntu-18.04_amd64.deb
sudo apt install ./eosio_1.7.0-1-ubuntu-18.04_amd64.deb
```

#### Ubuntu 16.04

```
wget https://github.com/EOSIO/eos/releases/download/v1.7.0/eosio_1.7.0-1-ubuntu-16.04_amd64.deb
sudo apt install ./eosio_1.7.0-1-ubuntu-16.04_amd64.deb
```

### Actions
Open a terminal on the appropriate operating system and run the commands below.

#### CREATE A WALLET

```
cleos wallet create --to-console
```

*NOTE: Save the password returned from the above command.*

#### IMPORT A PRIVATE KEY

```
cleos wallet import
```
Paste the private key for the account name used when the desired chain was created (see the Scatter Support instructions above for how to get a private key from Scatter).

#### CREATE AN ACCOUNT

```
cleos -u network_api_url system newaccount genesis_account --transfer account_to_be_created account_to_be_created_eos_public_key account_to_be_created_eos_public_key --stake-net ' 10.token_precision token_symbol' --stake-cpu '10.token_precision token_symbol' --buy-ram-kbytes 8192 -p genesis_account@active

cleos system newaccount clementine --transfer clementiot33 EOS7cbeQjFcyXTM5D2cv2hNZgPoZEAMqsuQ8Ln3Dy3c2c6zypvAu1 EOS7cbeQjFcyXTM5D2cv2hNZgPoZEAMqsuQ8Ln3Dy3c2c6zypvAu1 --stake-net ' 10.00 AGRI’ --stake-cpu '10.00 token_symbol' --buy-ram-kbytes 8192 -p clementine@active
```

Create an EOS key pair for the new account (see the Scatter Support instructions above for how to generate a new key pair in Scatter).
Replace the network_api_url variable in the COMMAND above with the desired chain network api url. 
Replace the genesis_account variable in the COMMAND above with the account name used when the desired chain was created. 
Replace both account_to_be_created_eos_public_key variables in the COMMAND above with the public key that was just created in Scatter. 
Replace the account_to_be_created variable with a valid EOS account name (12 characters in length, a-z, A-Z and 1-5). 
Replace both token_precision variables in the COMMAND above with a value of the appropriate length

*NOTE: the length must match the token precision of the desired chain (if the token precision is 4 then put 4 numbers - 10.1234). Replace both token_symbol variables in the COMMAND above with the token symbol of the desired chain.*

##### EXAMPLE 

```
cleos system newaccount adminaccount --transfer douganderson EOS7xn3qvgD2q44gzqhMkF6y6TPAMGw4An9n6dawo1opkGTFz7jnB EOS7xn3qvgD2q44gzqhMkF6y6TPAMGw4An9n6dawo1opkGTFz7jnB --stake-net '10.1234 ADMN' --stake-cpu '10.1234 ADMN' --buy-ram-kbytes 8192 -p adminaccount@active
```

#### TRANSFER TOKENS

```
cleos -u network_api_url transfer genesis_account account_to_receive_tokens ' 1000.token_precision token_symbol' 'transferring tokens' -p genesis_account@active
```

Replace the genesis_account variable in the COMMAND above with the account name used when the desired chain was created. 
Replace the account_to_receive_tokens variable in the COMMAND above with the account name that was just created. 
Replace both token_precision variables in the COMMAND above with a value of the appropriate number length.

*NOTE: the number length must match the token precision of the desired chain (if the token precision is 4 then put 4 number- 10.1234). Replace both token_symbol variables in the COMMAND above with the token symbol of the desired chain.*

##### EXAMPLE 

```
cleos transfer adminaccount douganderson '1000.1234 ADMN' 'transferring tokens' -p adminaccount@active
```

#### VIEW ACCOUNT INFO

```
cleos -u network_api_url get account account_to_get
```

Replace the network_api_url variable in the COMMAND above with the desired chain network api url. 
Replace the account_to_get variable in the COMMAND above with the desired account to get info about.

##### EXAMPLE 

```
cleos get account douganderson
```

#### VIEW ACCOUNT BALANCE

```
cleos get currency balance eosio.token account_to_look_up token_symbol
```

Replace the network_api_url variable in the COMMAND above with the desired chain network api url. 
Replace account_to_look_up variable in the COMMAND above with the desired account to look up. 
Replace both token_symbol variables in the COMMAND above with the token symbol of the desired chain.

##### EXAMPLE

```
cleos get currency balance eosio.token douganderson ADMN
```

#### OPEN WALLET
```
cleos wallet open
```

#### UNLOCK WALLET
```
cleos wallet unlock 
```

Paste in the password given when the wallet was created.

#### VIEW KEYS
```
cleos wallet list keys
```

#### CLEOS HELP

```
cleos --help
```
