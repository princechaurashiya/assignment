import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zylentrix/models/post.dart';
import 'package:zylentrix/viewsmodels/post_viewmodel.dart';

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostViewModel>(context, listen: false).fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<PostViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Posts')),
      body:
          postViewModel.isLoading
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loading spinner
              : postViewModel.error.isNotEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 50),
                    SizedBox(height: 10),
                    Text(
                      postViewModel.error,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => postViewModel.fetchPosts(),
                      child: Text("Retry"),
                    ),
                  ],
                ),
              ) // Show error message
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: postViewModel.posts.length,
                itemBuilder: (context, index) {
                  final PostModel post = postViewModel.posts[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      title: Text(
                        post.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.body,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "User ID: ${post.userId}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
