
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  late Web3Client _client;

  BlockchainService() {
    Client httpClient = Client();
    _client = Web3Client(
        // 'https://mainnet.infura.io/v3/a3afa86728a2458089b75a54fb1717e8', httpClient);
        'https://goerli.infura.io/v3/a3afa86728a2458089b75a54fb1717e8', httpClient);
  }

  Future<EtherAmount> getBalance(String address) async {
    final EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);
    final EtherAmount balance = await _client.getBalance(ethereumAddress);
    return balance;
  }
}