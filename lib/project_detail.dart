import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'blockchain_service.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class ProjectDetail extends StatefulWidget {
  final Project project;

  ProjectDetail({required this.project});

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  final TextEditingController _controller = TextEditingController();
  BlockchainService blockchainService = BlockchainService();

  Future<void> showBalance(String address) async {
    EtherAmount balance = await blockchainService.getBalance(address);
    print('Balance: ${balance.getValueInUnit(EtherUnit.ether)} ETH');
  }


  Future<double> getTokenPrice() async {
    final response = await http.get(Uri.parse('https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['ethereum']['usd'];
    } else {
      throw Exception('Failed to load token price');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Description: ${widget.project.description}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Tokenomics: ${widget.project.tokenomics}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter your Ethereum address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showBalance(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple[300],
              ),
              child: const Center(
              child: Text('Show Balance'),
              )
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement participation logic here
              },
              child: Text('Participate This Project'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 21),
            FutureBuilder<double>(
              future: getTokenPrice(),
              builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Token Price: \$${snapshot.data}', style: TextStyle(fontSize: 20));
                }
              },
            ),
            const SizedBox(height: 35),
            const Card(
              shadowColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Project Team ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Icon(Icons.person, color: Colors.greenAccent),
                          SizedBox(width: 10),
                          Text('Member 1 - CEO'),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.person, color: Colors.greenAccent),
                          SizedBox(width: 10),
                          Text('Member 2 - CTO'),
                        ],
                      ),
                      // Add more team members here
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}