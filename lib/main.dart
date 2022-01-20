import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learninig_provide/models/books_model.dart';
import 'package:learninig_provide/providers/counter_provider.dart';
import 'package:learninig_provide/services/database.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyC3LsEr7LDX7EnDU36-39P2P_urqSA5Hao", appId: "appId", messagingSenderId: "messagingSenderId", projectId: "authentication-9b57c"));
  Database d = Database();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => CounterProvider()),
      StreamProvider<List<UserModel>?>(
        create: (context) => d.userList(), initialData: [],
      )
      //StreamProvider<List<Books>>
    ],
    child:  MaterialApp(home: MyHomePage()),)
  );
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List userList = Provider.of<List<UserModel>>(context);
    Database firebaseServices = Database();
    print(userList);
    print(10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Stream Provider'),
      ),
      body:userList==null?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: userList.length,
        itemBuilder: (_, int index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.amber,
            ),
            title: Text(
              userList[index].name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            subtitle: Text(
              userList[index].age,
              style: const TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          firebaseServices.addUser();
        },
        backgroundColor: Colors.amber,
      ),
    );
  }
}
