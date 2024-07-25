import 'package:get_storage/get_storage.dart';

class StorageService {
  final GetStorage _storage = GetStorage();

  // Store a value with a given key
  void storeValue(String key, dynamic value) {
    _storage.write(key, value);
  }

  // Retrieve a value for a given key
  String retrieveStringValue(String key) {
    return _storage.read(key);
  }
  bool retrieveBooleanValue(String key) {
    return _storage.read(key)??false;
  }

  // Remove a value for a given key
  void removeValue(String key) {
    _storage.remove(key);
  }
}
