import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'item_details.dart';

class BookListScreen extends StatelessWidget {
  final String category;
  const BookListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📚 $category'), centerTitle: true),
      body: BlocBuilder<BookCubit, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.brown[700]),
            );
          } else if (state is BookLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.books.length,
                itemBuilder: (context, index) {
                  final book = state.books[index];
                  return ZoomIn(
                    duration: Duration(milliseconds: 400 + index * 100),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookDetailsScreen(book: book),
                          ),
                        );
                      },
                      child: Container(
                        height: 290,
                        decoration: BoxDecoration(
                          color: Colors.brown[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.brown.withOpacity(0.15),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: book.thumbnail.isNotEmpty
                                  ? Image.network(
                                      book.thumbnail,
                                      height: 150,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      height: 150,
                                      color: Colors.brown[200],
                                      child: Icon(
                                        Icons.menu_book,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        book.title,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.brown[900],
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      book.authors,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.brown[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
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
          } else if (state is BookError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.brown[400]),
                  SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.brown[700],
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
