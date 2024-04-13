import 'package:bt_system/exception/core.dart';

class DataNotFoundException extends DatabaseException {
  DataNotFoundException({super.message = '什么数据也没有找到！'});
}

class TableNotExistException extends DatabaseException {
  TableNotExistException({super.message = '表不存在!'});
}
