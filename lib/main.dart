import 'package:cobain_launchpad/project_detail.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: Launchpad(),
  ));
}

class Project {
  final String name;
  final String description;
  final String tokenomics;

  Project({required this.name, required this.description, required this.tokenomics});
}

class Launchpad extends StatelessWidget {
  final List<Project> projects = [
    Project(name: 'Project Hela 1', description: 'Description 1', tokenomics: 'Tokenomics 1'),
    Project(name: 'Project Hela 2', description: 'Description 2', tokenomics: 'Tokenomics 2'),
    // Add more projects here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launchpad Hela'),
      ),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(projects[index].name),
            subtitle: Text(projects[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProjectDetail(project: projects[index])),
              );
            },
          );
        },
      ),
    );
  }
}