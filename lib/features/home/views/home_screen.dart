
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';
import '../widgets/post_tile.dart'; // giả sử bạn có file này

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
            : Column(
                children: [
                  Expanded(
                    child: MasonryGridView.count(
                      controller: viewModel.scrollController,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding: const EdgeInsets.all(12),
                      itemCount: viewModel.posts.length,
                      itemBuilder: (context, index) {
                        return PostTile(post: viewModel.posts[index]);
                      },
                    ),
                  ),
                  if (viewModel.isFetchingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: CupertinoActivityIndicator(),
                    ),
                ],
              ),
      ),
    );
  }
}
