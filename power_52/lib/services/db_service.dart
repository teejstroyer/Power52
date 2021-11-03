import 'package:mongo_dart/mongo_dart.dart';
import 'package:power_52/Config/config.dart';

class DBService {
  static Future<void> addUser(String name) async {
    var db = await Db.create(MONGODB_URL);
    await db.open();
    var collection = db.collection('users');
    await collection.insert({'name': name});
    await db.close();
  }
}
