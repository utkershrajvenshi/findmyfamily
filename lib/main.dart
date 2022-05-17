import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:findmyfamily/backend/appwrite_init.dart';
import 'package:findmyfamily/backend/group_details.dart';
import 'package:findmyfamily/components/app_icon.dart';
import 'package:findmyfamily/constants.dart';
import 'package:findmyfamily/screens/create_join_group.dart';
import 'package:findmyfamily/screens/get_started_screen.dart';
import 'package:findmyfamily/screens/group_created_screen.dart';
import 'package:findmyfamily/screens/home_screen.dart';
import 'package:findmyfamily/screens/join_group.dart';
import 'package:findmyfamily/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppwriteInit()),
      ChangeNotifierProvider(create: (context) => GroupDetails())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      initialRoute: InitApp.routeName,
      routes: {
        InitApp.routeName: (context) => const InitApp(),
        GetStartedScreen.routeName: (context) => const GetStartedScreen(),
        LoginScreen.routeName: ((context) => const LoginScreen()),
        CreateOrJoinGroup.routeName: (context) => const CreateOrJoinGroup(),
        GroupCreated.routeName: (context) => const GroupCreated(),
        JoinGroup.routeName: (context) => JoinGroup(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}

class InitApp extends StatelessWidget {
  static String routeName = '/init-app';
  const InitApp({Key? key}) : super(key: key);

  Future<String> checkForLogin(BuildContext buildContext) async {
    AppwriteInit instance =
        Provider.of<AppwriteInit>(buildContext, listen: false);
    try {
      User userValue = await instance.account.get();
      print(userValue.email);
      // If no error is thrown that means that a user is logged in.
      // Now check if the user is a part of any group or not
      String groupName = await instance.checkIfUserIsInAGroup(userValue);

      if (groupName != "NA") {
        // If result is true, navigate to HomeScreen
        // groupName now contains the name of the group the user is already a member of.
        // We have already specified the provider at the root of the application and subscribing to it
        // in HomeScreen. Hence update the value of the GroupDetails object before navigating to HomeScreen
        GroupDetails myGroup =
            Provider.of<GroupDetails>(buildContext, listen: false);

        // Get the document from the groups collection
        Document groupDoc = await instance.database.getDocument(
            collectionId: getGroupsCollectionID(), documentId: groupName);

        print(groupDoc.toMap());
        myGroup.setFromJson(groupDoc.data);
        print(myGroup.toMap());

        // myGroup should now contain new values from groupDoc.data
        // Navigating now to HomeScreen
        return HomeScreen.routeName;
      } else {
        // Navigate to the Create/Join Group if result is false

        return CreateOrJoinGroup.routeName;
      }
    } catch (e) {
      // If an error is thrown, it means the app was unable to find a currently logged in user
      // Navigate to the GetStarted screen in this case
      print("Error: $e");
      if (e is AppwriteException && e.code == 400) {
        // Index Not found error raised. Occurred because no documents were created or the
        // selected attributes were not in the document
        // Thus, creating a user document and then redirecting to Create/Join Group
        instance.createUserDocument(await instance.account.get());
        return CreateOrJoinGroup.routeName;
      }
    }
    return GetStartedScreen.routeName;
  }

  @override
  Widget build(BuildContext context) {
    checkForLogin(context).then((value) {
      Navigator.popAndPushNamed(context, value);
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppIcon(size: 100.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Appwrite Initialisation"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Enter your credentials to create an account",
                style: Theme.of(context).textTheme.headline6,
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: "Enter your name"),
              ),
              TextField(
                controller: _emailController,
                decoration:
                    const InputDecoration(hintText: "Enter your email address"),
              ),
              TextField(
                controller: _passwordController,
                decoration:
                    const InputDecoration(hintText: "Enter your password"),
              ),
              ElevatedButton(
                onPressed: () {
                  AppwriteInit instance =
                      Provider.of<AppwriteInit>(context, listen: false);
                  instance.registerUser(_emailController.text,
                      _passwordController.text, _nameController.text);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MyHomePage(title: "Post-Login")));
                },
                child: const Text("Register"),
              ),
              const Text(
                "OR",
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: () {
                  AppwriteInit instance =
                      Provider.of<AppwriteInit>(context, listen: false);
                  instance.oAuthSignIn('google');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const MyHomePage(title: "Post-Login")));
                },
                child: const Text("Sign in with Google"),
              ),
              ElevatedButton(
                onPressed: () async {
                  AppwriteInit instance =
                      Provider.of<AppwriteInit>(context, listen: false);
                  var sessionsList = await instance.account.getSessions();
                  print(sessionsList.total);
                },
                child: const Text("Get sessions"),
              ),
              ElevatedButton(
                onPressed: () async {
                  AppwriteInit instance =
                      Provider.of<AppwriteInit>(context, listen: false);
                  var deletedSession = await instance.account
                      .deleteSession(sessionId: "62783170efa4db648cbe");
                  var sessionsList = await instance.account.getSessions();
                  print(sessionsList.total);
                },
                child: const Text("Delete session 5"),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
