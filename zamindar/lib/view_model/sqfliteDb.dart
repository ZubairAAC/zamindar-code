import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class UserDB {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id TEXT PRIMARY KEY,
        name TEXT,
        phone TEXT,
        image TEXT,
        gender TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  //init db
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'USER-DATABASE.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  //create new user in db
  static Future<int> createUser(String name, String? phone, String image,
      String gender, String myid) async {
    final db = await UserDB.db();

    final data = {
      'id': myid,
      'name': name,
      'phone': phone,
      'image': image,
      'gender': gender
    };
    final id = await db.insert('USERs', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //read all users in db
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await UserDB.db();
    return db.query('USERs', orderBy: "id");
  }

  //read user by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getUserByPhone(int phone) async {
    final db = await UserDB.db();
    return db.query('USERs', where: "phone = ?", whereArgs: [phone], limit: 1);
  }

  //update user
  static Future<int> updateUser(String name, String? phone, String image,
      String gender, String myid) async {
    final db = await UserDB.db();

    final data = {
      'id': myid,
      'name': name,
      'phone': phone,
      'image': image,
      'gender': gender,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [myid]);
    return result;
  }

  //delete user
  static Future<void> deleteUser(int id) async {
    final db = await UserDB.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
