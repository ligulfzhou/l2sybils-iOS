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
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, \
    ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

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
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, \
    ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

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
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, \
    ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

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
from zksync_sdk import ZkSyncProviderV01, HttpJsonRPCTransport, network, ZkSync, EthereumProvider, Wallet, \
    ZkSyncSigner, EthereumSignerWeb3, ZkSyncLibrary

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
