import 'package:agilex/api/ApiServices.dart';
import 'package:flutter/material.dart';

class ApiDesign extends StatefulWidget {
  const ApiDesign({super.key});

  @override
  State<ApiDesign> createState() => _ApiDesignState();
}

class _ApiDesignState extends State<ApiDesign> {
  late Future<Data> Response;
  @override
  void initState() {
    super.initState();
    Response = feathdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API")),
      body: Column(
        children: [
          FutureBuilder<Data>(
            future: feathdata(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                return Text(snapshot.data!.title);
              } else if (snapshot.hasError) {
                return Text("${snapshot.hasError}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
