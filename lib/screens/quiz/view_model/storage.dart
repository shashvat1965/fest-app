import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future writeData(int value, String key) async {
    var writedata = await _storage.write(key: key, value: value.toString());
    return writedata;
  }

  Future deleteData(String key) async {
    var deletedata = await _storage.delete(key: key);
    return deletedata;
  }

  Future readData(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }
}
