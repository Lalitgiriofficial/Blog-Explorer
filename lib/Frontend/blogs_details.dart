import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Utils/Blog_model.dart';
import '../Utils/blog_provider.dart';

class BlogDetailView extends StatelessWidget {
  final Blog blog;

  const BlogDetailView({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            'Blog Details',
            style: GoogleFonts.montserrat(
              fontSize: 28,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'blog_${blog.id}',
              child: Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          final scaffoldMessenger = ScaffoldMessenger.of(context);
          scaffoldMessenger.showSnackBar(blog.isFavorite
              ? const SnackBar(
                  content: Text('Removed from favorites'),
                  duration:
                      Duration(seconds: 2), // Adjust the duration as needed
                )
              : const SnackBar(
                  content: Text('Added to favorites'),
                  duration:
                      Duration(seconds: 2), // Adjust the duration as needed
                ));
          Provider.of<BlogProvider>(context, listen: false)
              .toggleFavorite(blog.id);
        },
        child: Consumer<BlogProvider>(
          builder: (context, blogProvider, child) {
            final isFavorite = blog.isFavorite;
            return Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            );
          },
        ),
      ),
    );
  }
}
