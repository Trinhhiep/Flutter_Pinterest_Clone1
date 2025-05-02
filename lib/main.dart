import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'data/repositories/post_repository.dart';
import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/root/root_screen.dart';

void main() {
  final repository = PostRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(repository)..fetchData(),
        ),

        // ChangeNotifierProvider<DetailPostViewModel>(
        //   create: (_) => DetailPostViewModel(repository)..fetchData(),
        // ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinterest Clone',
      home: RootScreen(),
    );
  }
}
