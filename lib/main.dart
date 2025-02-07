import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://kjniorxbazmxrbuzhtrc.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtqbmlvcnhiYXpteHJidXpodHJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE0Njc5ODEsImV4cCI6MjA0NzA0Mzk4MX0.jDPfgP9APmAfXiImjdUqr6fuUxc5eE9TCUTs6VJeqGY',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
