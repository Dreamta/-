class BtException implements Exception {
  final String message;
  BtException({required this.message});
}

class ExcelException extends BtException {
  ExcelException({required super.message});
}

class DatabaseException extends BtException {
  DatabaseException({required super.message});
}
