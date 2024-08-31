import 'package:get_storage/get_storage.dart';

class localdata {
  static final box = GetStorage();

  // add string
  static void addString(String key, String value) {
    box.write(key, value);
  }

  // get string
  static String getString(String key) {
    return box.read(key);
  }

  // remove string
  static void removeString(String key) {
    box.remove(key);
  }

// set bool
  static void setbool(String key, bool value) {
    box.write(key, value);
  }

  // get bool
static bool getbool(String key) {
    return box.read(key);
  }
  




  // check if key exists
  static bool hasData(String key) {
    return box.hasData(key);
  }
}
