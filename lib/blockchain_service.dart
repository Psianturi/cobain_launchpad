
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class BlockchainService {
  late Web3Client _client;

  BlockchainService() {
    Client httpClient = Client();
    _client = Web3Client(
        // '', httpClient);
        'key', httpClient);
  }

  Future<EtherAmount> getBalance(String address) async {
    final EthereumAddress ethereumAddress = EthereumAddress.fromHex(address);
    final EtherAmount balance = await _client.getBalance(ethereumAddress);
    return balance;
  }
}
