import 'package:bloc/bloc.dart';

import '../data/home_data.dart';
import 'home_state.dart';

class BookCubit extends Cubit<BookState> {
  final BookRepository bookRepo;

  BookCubit(this.bookRepo) : super(BookInitial());

  void getBooks(String category) async {
    emit(BookLoading());
    try {
      final books = await bookRepo.fetchBooks(category);
      emit(BookLoaded(books));
    } catch (e) {
      emit(BookError(e.toString()));
    }
  }
}