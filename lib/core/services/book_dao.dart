import 'dart:async';

import 'package:desktop_library_shop/core/models/book.dart';
import 'package:desktop_library_shop/core/models/book_borrowed.dart';
import 'package:desktop_library_shop/core/repositories/book_repository.dart';
import 'package:desktop_library_shop/locator.dart';

abstract class BookDao {
  StreamController<int> totalBooks = StreamController.broadcast();
  StreamController<int> totalCopies = StreamController.broadcast();
  StreamController<int> totalActiveBooksIssued = StreamController.broadcast();
  StreamController<int> totalBooksIssuedSoFar = StreamController.broadcast();
  StreamController<int> totalBooksIssuedToday = StreamController.broadcast();
  StreamController<int> totalBooksReturnedToday = StreamController.broadcast();
  StreamController<int> totalBooksDelayInReturn = StreamController.broadcast();
  StreamController<int> totalBooksDueReturn = StreamController.broadcast();
  StreamController<int> totalBooksAsNew = StreamController.broadcast();
  StreamController<int> totalUseableBooks = StreamController.broadcast();
  StreamController<int> totalBooksToDiscard = StreamController.broadcast();
  StreamController<int> totalPoorBooks = StreamController.broadcast();
  StreamController<int> totalBooksInSingleRack = StreamController.broadcast();
  StreamController<int> totalBooksCapacityInRack = StreamController.broadcast();
  StreamController<int> totalStudents = StreamController.broadcast();
  StreamController<int> totalStaffs = StreamController.broadcast();

  Future<Book> getByCategory(int id);
  Future<Book> getByCode(String code);
  Future<List<BookBorrowed>> getBooksBorrowed(int id);

  Future<List<Book>> getAll();
  Future<int> getSampleDataCount();
  Future<List<Book>> getAllActiveIssuedBooks();

  Future<List<Book>> getAllBooksIssuedSoFar();
  Future<List<Book>> getAllBooksIssuedToday();
  Future<List<Book>> getAllBooksReturnedToday();
  Future<List<Book>> getBooksByQuery(
      int? categoryId, String? author, String? publisher, DateTime? from, DateTime to);
  Future<Book> save(Book book);
  void dispose();
}

class BookDaoImpl extends BookDao {
  final BookRepository _bookRepository = loc<BookRepository>();

  @override
  Future<List<BookBorrowed>> getBooksBorrowed(int id) async {
    return await _bookRepository.getBooksBorrowedByStudent(id);
  }

  @override
  Future<Book> getByCategory(int id) async {
    return await _bookRepository.getBookByCategory(id);
  }

  @override
  Future<Book> getByCode(String code) async {
    return await _bookRepository.getBookByCode(code);
  }

  @override
  Future<List<Book>> getAll() async {
    return await _bookRepository.getAll();
  }

  @override
  Future<List<Book>> getAllActiveIssuedBooks() async {
    return await _bookRepository.getAllActiveIssuedBooks();
  }

  @override
  Future<List<Book>> getAllBooksIssuedSoFar() async {
    return await _bookRepository.getAllBooksIssuedSoFar();
  }

  @override
  Future<List<Book>> getAllBooksIssuedToday() async {
    return await _bookRepository.getAllBooksIssuedToday();
  }

  @override
  Future<List<Book>> getAllBooksReturnedToday() async {
    return await _bookRepository.getAllBooksReturnedToday();
  }

  @override
  Future<int> getSampleDataCount() {
    return Future<int>.delayed(
        const Duration(seconds: 2), () => DateTime.now().microsecond ~/ 3);
  }

  @override
  Future<Book> save(Book book) async {
    return await _bookRepository.save(book);
  }

  void _doDispose(StreamController controller) {
    if (!controller.isClosed) {
      print('controller closed');
      controller.close();
    }
  }

  @override
  void dispose() {
    _doDispose(totalBooks);
    _doDispose(totalCopies);
    _doDispose(totalActiveBooksIssued);
    _doDispose(totalBooksIssuedSoFar);
    _doDispose(totalBooksIssuedToday);
    _doDispose(totalBooksReturnedToday);
    _doDispose(totalBooksDelayInReturn);
    _doDispose(totalBooksDueReturn);
    _doDispose(totalBooksAsNew);
    _doDispose(totalUseableBooks);
    _doDispose(totalBooksToDiscard);
    _doDispose(totalPoorBooks);
    _doDispose(totalBooksInSingleRack);
    _doDispose(totalBooksCapacityInRack);
    _doDispose(totalStudents);
    _doDispose(totalStaffs);
  }

  @override
  Future<List<Book>> getBooksByQuery(
      int? categoryId, String? author, String? publisher, DateTime? from, DateTime to) async {
    String whereQuery = '';
    whereQuery += (categoryId != null) ? 'b.categoryId = $categoryId AND ' : '';
    whereQuery += (author != null) ? "b.author = '$author' AND " : "";
    whereQuery += (publisher != null) ? "b.publisher = '$publisher' AND " : "";
    whereQuery +=
        (from != null && to != null) ? "b.stockOn >= '$from' OR b.stockOn <= '$to' AND " : '';
    if (whereQuery.isEmpty) {
      return [];
    }
    whereQuery += 'b.isActive = 1';
    return _bookRepository.getBooksByQuery(whereQuery);
  }
}
