//
//  Task.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()

    public var name: String
    public var icon: String
    public var site: String?
    public var code: String?
    public var doc: String?
}


let LiteBridges: [Task] = [
    Task(
        name: "Official Bridge",
        icon: "zksync",
        site: "https://lite.zksync.io",
        code:  """
```python3
# deposit eth from Ethereum mainnet to zkSync Lite
from eth_account.signers.local import LocalAccount
from eth_account.datastructures import SignedTransaction
from web3.types import TxReceipt

def deposit_to_zksync_lite(account: LocalAccount, value_in_wei: int)-> bool:
    contract_address = '0xaBEA9132b05A70803a4E85094fD0e1800777fBEF'
    contract=w3.eth.contract(address=contract_address, abi=lite_abi)
    nonce = w3.eth.get_transaction_count(account.address)
    gas_price = w3.eth.gas_price
    tx = contract.functions.depositETH(
        account.address
    ).build_transaction({
        'from': Web3.to_checksum_address(account.address),
        'value': value_in_wei,
        'nonce': nonce,
        'gas': gas,
        'gasPrice': gas_price
    })
    
    signed_tx = w3.eth.account.sign_transaction(tx, account.key)
    h = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
    r: TxReceipt = w3.eth.wait_for_transaction_receipt(h)
    if r.status:
        return True
    return False
```
"""
    ),
    Task(
        name: "Orbiter.Finance",
        icon: "orbiterfinance",
        site: "https://www.orbiter.finance/?source=Ethereum&dest=zkSync%20Lite"
    ),
    Task(
        name: "LayerSwap.io",
        icon: "layerswap",
        site: "https://www.layerswap.io"
    )
]


let LiteTasks: [Task] = [
    Task(
        name: "Activate",
        icon: "zksync",
        code: """
```python3
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

environ.setdefault('ZK_SYNC_LIBRARY_PATH', '<YOUR ZK_SYNC_LIBRARY_PATH>')


async def activate(account: LocalAccount) -> bool:
    wallet = _get_wallet(account)
    already_signed = await wallet.is_signing_key_set()
    if already_signed:
        return True

    tx: Transaction = await wallet.set_signing_key("ETH", eth_auth_data=ChangePubKeyEcdsa())
    status: TransactionResult = await tx.await_committed()
    if status.status == TransactionStatus.FAILED:
        print(f'activation for {account.address} failed...')
        return False
    return True


def _get_wallet(account: LocalAccount) -> Wallet:
    library = ZkSyncLibrary()
    provider = ZkSyncProviderV01(provider=HttpJsonRPCTransport(network=network.mainnet))

    ethereum_signer = EthereumSignerWeb3(account=account)
    print(ethereum_signer)

    main_contract = "0xaBEA9132b05A70803a4E85094fD0e1800777fBEF"
    zksync = ZkSync(account=account, web3=w3, zksync_contract_address=main_contract)
    ethereum_provider = EthereumProvider(w3, zksync)

    signer = ZkSyncSigner.from_account(account, library, network.mainnet.chain_id)
    wallet = Wallet(ethereum_provider=ethereum_provider, zk_signer=signer,
                    eth_signer=ethereum_signer, provider=provider)
    return wallet
```
""",
        doc: "https://docs.zksync.io/api/sdk/python/tutorial/#unlocking-zksync-account"
    ),
    Task(
        name: "Mint NFT",
        icon: "zksync",
        code: """
```python3
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

environ.setdefault('ZK_SYNC_LIBRARY_PATH', '<YOUR ZK_SYNC_LIBRARY_PATH>')


async def mint_nft(account: LocalAccount)-> bool:
    wallet = _get_wallet(account)
    tx: Transaction = await wallet.mint_nft('<IPFS Hash>', account.address, "ETH")
    status: TransactionResult = await tx.await_committed()
    if status.status == TransactionStatus.FAILED:
        return False
    return True


def _get_wallet(account: LocalAccount) -> Wallet:
    library = ZkSyncLibrary()
    provider = ZkSyncProviderV01(provider=HttpJsonRPCTransport(network=network.mainnet))

    ethereum_signer = EthereumSignerWeb3(account=account)
    print(ethereum_signer)

    main_contract = "0xaBEA9132b05A70803a4E85094fD0e1800777fBEF"
    zksync = ZkSync(account=account, web3=w3, zksync_contract_address=main_contract)
    ethereum_provider = EthereumProvider(w3, zksync)

    signer = ZkSyncSigner.from_account(account, library, network.mainnet.chain_id)
    wallet = Wallet(ethereum_provider=ethereum_provider, zk_signer=signer,
                    eth_signer=ethereum_signer, provider=provider)
    return wallet
```
""",
        doc: "https://docs.zksync.io/api/sdk/python/tutorial/#minting"
    ),
    Task(
        name: "Transfer NFT",
        icon: "zksync",
        code: """
```python3
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

environ.setdefault('ZK_SYNC_LIBRARY_PATH', '<YOUR ZK_SYNC_LIBRARY_PATH>')


async def tranfer_nft(cls, account: LocalAccount, target: LocalAccount)-> bool:
    wallet = _get_wallet(account)
    layer2_account: AccountState = await wallet.get_account_state()
    key_to_nfts: Dict[str, NFT] = layer2_account.verified.minted_nfts
    if not key_to_nfts:
        print(f'ALERT>>>>, {account.address} does not have any nfts, just skip tranfer nfts...')
        return True

    random_nft: NFT = random.choice(list(key_to_nfts.values()))
    txs: List[Transaction] = await wallet.transfer_nft(target.address, random_nft, "ETH")
    success = True
    for tx in txs:
        status: TransactionResult = await tx.await_committed()
        if status.status == TransactionStatus.FAILED:
            print(f'transfer nft {random_nft.address} for {target.address} failed...')
            success = False
    return success


def _get_wallet(account: LocalAccount) -> Wallet:
    library = ZkSyncLibrary()
    provider = ZkSyncProviderV01(provider=HttpJsonRPCTransport(network=network.mainnet))

    ethereum_signer = EthereumSignerWeb3(account=account)
    print(ethereum_signer)

    main_contract = "0xaBEA9132b05A70803a4E85094fD0e1800777fBEF"
    zksync = ZkSync(account=account, web3=w3, zksync_contract_address=main_contract)
    ethereum_provider = EthereumProvider(w3, zksync)

    signer = ZkSyncSigner.from_account(account, library, network.mainnet.chain_id)
    wallet = Wallet(ethereum_provider=ethereum_provider, zk_signer=signer,
                    eth_signer=ethereum_signer, provider=provider)
    return wallet
```
""",
        doc: "https://docs.zksync.io/api/sdk/python/tutorial/#transfering"
    ),
    Task(
        name: "Transfer ETH",
        icon: "zksync",
        code: """
```python3
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

environ.setdefault('ZK_SYNC_LIBRARY_PATH', '<YOUR ZK_SYNC_LIBRARY_PATH>')


async def transfer(account: LocalAccount, target: LocalAccount, value_in_eth: Union[float, str] = '0')-> bool:
    print(f'=====> start to tranfer {value_in_eth} eth from {account.address} to {target.address}... <=====')
    wallet = _get_wallet(account)
    tx: Transaction = await wallet.transfer(target.address, amount=Decimal(value_in_eth), token='ETH')
    status: TransactionResult = await tx.await_committed()
    if status.status == TransactionStatus.FAILED:
        print(f'transfer for {target.address} failed...')
        return False
    return True


def _get_wallet(account: LocalAccount) -> Wallet:
    library = ZkSyncLibrary()
    provider = ZkSyncProviderV01(provider=HttpJsonRPCTransport(network=network.mainnet))

    ethereum_signer = EthereumSignerWeb3(account=account)
    print(ethereum_signer)

    main_contract = "0xaBEA9132b05A70803a4E85094fD0e1800777fBEF"
    zksync = ZkSync(account=account, web3=w3, zksync_contract_address=main_contract)
    ethereum_provider = EthereumProvider(w3, zksync)

    signer = ZkSyncSigner.from_account(account, library, network.mainnet.chain_id)
    wallet = Wallet(ethereum_provider=ethereum_provider, zk_signer=signer,
                    eth_signer=ethereum_signer, provider=provider)
    return wallet
```
""",
        doc: "https://docs.zksync.io/api/sdk/python/tutorial/#unlocking-zksync-account"
    )
]




let EraBridges: [Task] = [
    Task(
        name: "Official Bridge",
        icon: "zksync",
        site: "https://bridge.zksync.io"
    ),
    Task(
        name: "Orbiter.Finance",
        icon: "orbiterfinance",
        site: "https://www.orbiter.finance/?source=Ethereum&dest=zkSync%20Lite"
    ),
    Task(
        name: "MultiChain",
        icon: "multichain",
        site: "https://app.multichain.org/#/router"
    ),
    Task(
        name: "LayerSwap.io",
        icon: "layerswap",
        site: "https://www.layerswap.io"
    )
]


let EraTasks: [Task] = [
    Task(
        name: "Mintsquare - mint nft",
        icon: "mintsquare",
        site: "https://mintsquare.io/mint",
        code: """
```python3
class MintSquare:

    @classmethod
    def mint_nft(cls, account: LocalAccount, w3: Web3, ipfs_url: str) -> bool:
        contractAds = Web3.to_checksum_address('0x53eC17BD635F7A54B3551E76Fd53Db8881028fC3')
        abi = get_abi('mintsquare/mintsquare.json')

        mintContract = w3.eth.contract(address=contractAds, abi=abi)
        gas_price = w3.eth.gas_price

        tx_hash = mintContract.functions.mint(ipfs_url).build_transaction({
            'from': account.address,
            'nonce': w3.eth.get_transaction_count(account.address),
            'gasPrice': gas_price,
            'gas': 3385066,
            "value": w3.to_wei(0, 'ether')
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True
```
"""
    ),
    Task(
        name: "Mute - swap token",
        icon: "mute",
        site: "https://mute.io",
        code: """
```python3
class Mute:

    @classmethod
    def eth_to_usdc(cls, account: LocalAccount, w3: Web3, value: int = 10 ** 16) -> bool:
        account_address = Web3.to_checksum_address(account.address)
        abi = get_abi('mute/Router.json')
        router_contract_address = w3.to_checksum_address(conf.mute['Router'])
        router_contract = w3.eth.contract(address=router_contract_address, abi=abi)
        path = (
            Web3.to_checksum_address(TokenAddress.weth.value),
            Web3.to_checksum_address(TokenAddress.usdc.value)
        )

        gas_price = w3.eth.gas_price
        # Function: sWapExactETHForTokenssupportingFeelnTransferTokens(uint256 amountouthin, adress[] path, address to, uint25 deadline, bool[] stable)
        tx_hash = router_contract.functions.swapExactETHForTokensSupportingFeeOnTransferTokens(
            0,
            path,
            account.address,
            w3.to_wei(int(time.time()) + 1800, 'wei'),
            [False, False]
        ).build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            'value': value,
            'gas': 1000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Mute eth=>usdc: Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} \ntransaction status: {r.status}')
        return True

    @classmethod
    def usdc_to_eth(cls, account: LocalAccount, w3: Web3, value: int = 10 * 10 ** 6) -> bool:
        account_address = Web3.to_checksum_address(account.address)
        abi = get_abi('mute/Router.json')
        router_contract_address = w3.to_checksum_address(conf.mute['Router'])
        router_contract = w3.eth.contract(address=router_contract_address, abi=abi)
        path = (
            Web3.to_checksum_address(TokenAddress.usdc.value),
            Web3.to_checksum_address(TokenAddress.weth.value)
        )

        gas_price = w3.eth.gas_price
        # Function: sWapExactETHForTokenssupportingFeelnTransferTokens(uint256 amountouthin, adress[] path, address to, uint25 deadline, bool[] stable)
        tx_hash = router_contract.functions.swapExactTokensForETHSupportingFeeOnTransferTokens(
            value,
            0,
            path,
            account.address,
            w3.to_wei(int(time.time()) + 1800, 'wei'),
            [False, False]
        ).build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            # 'value': value,  # very important.
            'gas': 1000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Mute eth=>usdc: Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True
```
"""
    ),
    Task(
        name: "SyncSwap - swap token",
        icon: "syncswap",
        site: "https://syncswap.xyz/",
        code: """
```python3
class SyncSwap:

    @classmethod
    def usdc_to_eth(cls, account: LocalAccount, w3: Web3, value: int = 10 * 10 ** 6) -> bool:
        # default 10 * 10**6 => 10 usdc
        account_address = Web3.to_checksum_address(account.address)
        usdc_ads = Web3.to_checksum_address(TokenAddress.usdc.value)
        weth_ads = Web3.to_checksum_address(TokenAddress.weth.value)
        zero_ads = Web3.to_checksum_address(TokenAddress.eth.value)

        # contract addresses: https://syncswap.gitbook.io/api-documentation/resources/smart-contract
        routerAds = Web3.to_checksum_address(conf.syncswap['address']['SyncSwapRouter'])
        poolFactoryAds = Web3.to_checksum_address(conf.syncswap['address']['SyncSwapClassicPoolFactory'])

        # abi https://syncswap.gitbook.io/api-documentation/resources/abis
        router_abi = get_abi('syncswap/SyncSwapRouter.json')
        pool_factory_abi = get_abi('syncswap/SyncSwapClassicFactory.json')

        # Pool Factory
        poolFactoryContract = w3.eth.contract(address=poolFactoryAds, abi=pool_factory_abi)

        pool = poolFactoryContract.functions.getPool(weth_ads, usdc_ads).call()
        print(f'get pool address: {pool}')

        withdraw_mode = 1
        swap_data = encode(
            ["address", "address", "uint8"],  # tokenIn, to, withdraw mode
            [usdc_ads, account_address, withdraw_mode],
        )

        # struct SwapStep
        swap_step = [(
            pool,  # pool
            swap_data,  # data
            zero_ads,  # callback
            '0x'  # callbackData
        )]

        # struct SwapPath
        swap_path = [(
            swap_step,
            usdc_ads,
            value
        )]

        router_contract = w3.eth.contract(address=routerAds, abi=router_abi)
        deadline = w3.to_wei(int(time.time()) + 1800, 'wei')
        gas_price = w3.eth.gas_price
        tx_hash = router_contract.functions.swap(swap_path, 0, deadline).build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            'gas': 2000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        if gas_fee > GAS_LIMIT_IN_ETHER * (10 ** 18):
            print("gas price too high, just skip...")
            return False

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True

    @classmethod
    def eth_to_usdc(cls, account: LocalAccount, w3: Web3, value: int = 10 ** 16) -> bool:
        # default 10**16 => 0.01eth
        account_address = Web3.to_checksum_address(account.address)
        usdc_ads = Web3.to_checksum_address(TokenAddress.usdc.value)
        weth_ads = Web3.to_checksum_address(TokenAddress.weth.value)
        zero_ads = Web3.to_checksum_address(TokenAddress.eth.value)

        # contract addresses: https://syncswap.gitbook.io/api-documentation/resources/smart-contract
        routerAds = Web3.to_checksum_address(conf.syncswap['address']['SyncSwapRouter'])
        poolFactoryAds = Web3.to_checksum_address(conf.syncswap['address']['SyncSwapClassicPoolFactory'])

        # abi: https://syncswap.gitbook.io/api-documentation/resources/abis
        router_abi = get_abi('syncswap/SyncSwapRouter.json')
        pool_factory_abi = get_abi('syncswap/SyncSwapClassicFactory.json')

        # Pool Factory
        poolFactoryContract = w3.eth.contract(address=poolFactoryAds, abi=pool_factory_abi)
        pool = poolFactoryContract.functions.getPool(weth_ads, usdc_ads).call()
        print(pool)

        withdraw_mode = 2
        swap_data = encode(
            ["address", "address", "uint8"],
            [weth_ads, account_address, withdraw_mode],
        )

        # struct SwapStep
        swap_step = [(
            pool,
            swap_data,
            zero_ads,
            '0x'
        )]

        # struct SwapPath
        swap_path = [(
            swap_step,
            zero_ads,
            value
        )]

        # SyncSwapRouter
        router_contract = w3.eth.contract(address=routerAds, abi=router_abi)
        deadline = w3.to_wei(int(time.time()) + 1800, 'wei')
        gas_price = w3.eth.gas_price
        tx_hash = router_contract.functions.swap(swap_path, 0, deadline).build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            'value': value,
            'gas': 1000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        if gas_fee > GAS_LIMIT_IN_ETHER * (10 ** 18):
            print("gas price too high, just skip...")
            return False

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True

```
"""
    ),
    Task(
        name: "Weth - wrap+unwrap",
        icon: "ethereum",
        code: """
```python3
class WethWrapper:

    @classmethod
    def deposit(cls, account: LocalAccount, w3: Web3, value: int = int(0.05 * 10 ** 18)) -> bool:
        print(f'{"*" * 10} wrap {value}(in wei) eth to weth {"*" * 10}')
        weth_abi = get_abi('weth.json')
        account_address = Web3.to_checksum_address(account.address)
        weth_contract = w3.eth.contract(address=Web3.to_checksum_address(TokenAddress.weth.value), abi=weth_abi)

        gas_price = w3.eth.gas_price
        tx_hash = weth_contract.functions.deposit().build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            'value': value,
            'gas': 1000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')
        
        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True

    @classmethod
    def withdraw(cls, account: LocalAccount, w3: Web3, value: int = int(0.05 * 10 ** 18)) -> bool:
        print(f'{"*" * 10} unwrap {value}(in wei) weth to eth {"*" * 10}')
        weth_abi = get_abi('weth.json')
        account_address = Web3.to_checksum_address(account.address)
        weth_contract = w3.eth.contract(address=Web3.to_checksum_address(TokenAddress.weth.value), abi=weth_abi)

        gas_price = w3.eth.gas_price
        tx_hash = weth_contract.functions.withdraw(value).build_transaction({
            'from': account_address,
            'nonce': w3.eth.get_transaction_count(account_address),
            'gasPrice': gas_price,
            'gas': 1000000,
        })

        gas_estimate = w3.eth.estimate_gas(tx_hash)
        gas_fee = gas_estimate * gas_price
        print(f'Estimated gas fee: {w3.from_wei(gas_fee, "ether")} ETH')

        signed_tx = w3.eth.account.sign_transaction(tx_hash, private_key=account.key)
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        r: TxReceipt = w3.eth.wait_for_transaction_receipt(tx_hash)
        print(f'transaction hash: {w3.to_hex(tx_hash)} transaction status: {r.status}')
        return True
```
"""
    )
]
