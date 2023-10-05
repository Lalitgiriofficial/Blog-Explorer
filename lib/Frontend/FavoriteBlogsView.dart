import 'package:blog_explorer/Frontend/blogs_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_explorer/Utils/blog_provider.dart';
import '../Utils/Blog_model.dart';

class FavoriteBlogsView extends StatelessWidget {
  const FavoriteBlogsView({super.key});

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final favoriteBlogs = blogProvider.getFavoriteBlogs();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          splashColor: Colors.transparent,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Favorite Blogs'),
      ),
      body: ListView.builder(
        itemCount: favoriteBlogs.length,
        itemBuilder: (context, index) {
          final blog = favoriteBlogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return FadeTransition(
                      opacity: animation,
                      child: BlogDetailView(blog: blog),
                    );
                  },
                ),
              );
            },
            child: FavoriteBlogListItem(blog: blog),
          );
        },
      ),
    );
  }
}

class FavoriteBlogListItem extends StatelessWidget {
  final Blog blog;

  const FavoriteBlogListItem({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Hero(
        tag: 'blog_${blog.id}',
        child: Image.network(
          blog.imageUrl,
          width: 64.0,
          height: 64.0,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(blog.title),
    );
  }
}
