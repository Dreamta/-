import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  SharedPreferences? _pre;
  static Cache? _instense;

  Cache._() {
    init();
  }

  factory Cache.getInstence() {
    return _instense ??= Cache._();
  }

  static Future preInit() async {
    if (_instense == null) {
      SharedPreferences pre = await SharedPreferences.getInstance();
      _instense = Cache._pre(pre);
    }
  }

  Cache._pre(SharedPreferences pre) {
    _pre = pre;
  }

  init() async {
    _pre = await SharedPreferences.getInstance();
  }

  Cache setBool(String key, bool value) {
    _pre?.setBool(key, value);
    return this;
  }

  Cache setInt(String key, int value) {
    _pre?.setInt(key, value);
    return this;
  }

  Cache setString(String key, dynamic value) {
    _pre?.setString(key, value is String ? value : jsonEncode(value));
    return this;
  }

  /// `保存时将接收任意类型的列表，对其中的元素使用jsonEncode函数进行序列化(化为json字符串)后进行存储`
  Cache setList<T>(String key, List list) {
    _pre?.setStringList(
        key, list.map((e) => e is String ? e : jsonEncode(e)).toList());
    return this;
  }

  T? get<T>(String key) {
    return _pre?.get(key) as T?;
  }

  ///`将解码工作交给底层方法（该方法）来做，使上层调用该方法时无需进行额外解码工作，直接对该函数返回的列表进行解析即可`
  List getList<T>(String key) {
    return T is String
        ? _pre?.getStringList(key) ?? []
        : _pre?.getStringList(key)?.map((e) => jsonDecode(e)).toList() ?? [];
  }

  clear() {
    _pre?.clear();
  }
}
