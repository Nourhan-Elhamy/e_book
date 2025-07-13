import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/home_models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';

class BookDetailsScreen extends StatelessWidget {
  final BookModel book;
  const BookDetailsScreen({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown[800]),
        title: Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.brown[800], fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Hero(
                  tag: book.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                    child: book.thumbnail.isNotEmpty
                        ? Image.network(
                      book.thumbnail,
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: double.infinity,
                      color: Colors.brown[300],
                      child: Icon(Icons.menu_book, size: 100, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.55,
            minChildSize: 0.55,
            maxChildSize: 0.9,
            builder: (context, controller) => Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.brown[50],
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.shade200,
                    offset: Offset(0, -2),
                    blurRadius: 8,
                  )
                ],
              ),
              child: ListView(
                controller: controller,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.brown[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 500),
                    child: Center(
                      child: Text(
                        book.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildAnimatedInfo("Authors", book.authors, 600),
                  buildAnimatedInfo("Publisher", book.publisher, 700),
                  buildAnimatedInfo("Published Date", book.publishedDate, 800),
                  buildAnimatedInfo("Categories", book.categories.isNotEmpty ? book.categories.join(", ") : 'None', 900),
                  buildAnimatedInfo("Description", book.description, 1000),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        foregroundColor: Colors.white,
                        elevation: 5,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      icon: Icon(Icons.open_in_browser),
                      label: Text("Preview Book", style: TextStyle(fontSize: 16)),
                      onPressed: () async {
                        final Uri url = Uri.parse(book.previewLink);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not open preview link')),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildAnimatedInfo(String label, String value, int delayMs) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: FadeInUp(
        duration: Duration(milliseconds: delayMs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.brown[800])),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 15, color: Colors.brown[600], height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

}
