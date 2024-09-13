import 'package:flutter/material.dart';
import 'package:my_drift/db/db_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserCompanion entity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Screen"),
        backgroundColor: Colors.lightBlue,
      ),
      body: FutureBuilder(
          future: AppDatabase().userDao.getusers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: const CircularProgressIndicator.adaptive(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("No Data Available"),
              );
            }

            if (snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final currentData = snapshot.data![index];
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text("${snapshot.data?[index].name}"),
                          subtitle: Text("${snapshot.data?[index].email}"),
                          trailing: InkWell(
                              onTap: () {
                                AppDatabase()
                                    .userDao
                                    .deleteUsers(snapshot.data![index].id);
                                setState(() {});
                              },
                              child: const Icon(Icons.delete)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 12, 8),
                          child: Row(
                            children: [
                              Text("${snapshot.data?[index].phone}"),
                              const SizedBox(
                                width: 12,
                              ),
                              Text("${snapshot.data?[index].dateOfBirth}"),
                              const SizedBox(
                                width: 100,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/updateusers',
                                          arguments: currentData)
                                      .then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                  //  AppDatabase().userDao.getSingleUser(currentData.id);
                                },
                                child: const Icon(Icons.update),
                              ),
                              // Text("${snapshot.data?[index].dateOfBirth}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Text(" No data");
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/addusers').then(
            (value) {
              setState(() {});
            },
          );
        },
        label: const Icon(Icons.add),
      ),
    );
  }
}
