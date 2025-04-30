import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // dùng GridView
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/post_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text("Home"),
      ),
      child: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: viewModel.posts.length,
                itemBuilder: (context, index) {
                  return PostTile(post: viewModel.posts[index]);
                },
              ),
      ),
    );
  }
}
