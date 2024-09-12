import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.group),
            radius: 25,
          ),
          title: Text(
            "Asmita",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Hi Simran",
            style: TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text("18.04"),
        ),
        Divider()
      ],
    );
  }
}
