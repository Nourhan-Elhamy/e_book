import 'package:bloc/bloc.dart';

import '../data/home_data.dart';
import '../data/home_models.dart';

abstract class BookState {}

class BookInitial extends BookState {}
class BookLoading extends BookState {}
class BookLoaded extends BookState {
  final List<BookModel> books;
  BookLoaded(this.books);
}
class BookError extends BookState {
  final String message;
  BookError(this.message);
}
