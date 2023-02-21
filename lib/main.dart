import 'package:flutter/material.dart';
import 'package:flutter_hive_riverpod/model/associate.dart';
import 'package:flutter_hive_riverpod/pages/add_associate_page.dart';
import 'package:flutter_hive_riverpod/pages/associate_list_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(
      AssociateAdapter(),
    );
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightGreenAccent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AssociateListPage(),
        '/AddAssociatePage': (context) => const AddAssociatePage(),
      },
    );
  }
}
