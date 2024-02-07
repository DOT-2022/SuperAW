
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DBHelper {
  final databaseName = "awc.db";

  String createTableCenter = """
      CREATE TABLE centers (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        code INTEGER NOT NULL,
        c_id INTEGER NOT NULL,
        name TEXT,
        address TEXT,
        landmark TEXT,
        c_type TEXT,
        community_building TEXT,
        building_ownership TEXT,
        lat TEXT,
        long TEXT,
        image TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
    """;

  String createTableWorkers = """
      CREATE TABLE workers (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        c_id INTEGER NOT NULL,
        c_name TEXT,
        multiple BOOLEAN NOT NULL DEFAULT 0,
        name TEXT,
        contact TEXT,
        image TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
    """;

  String createTableHelpers = """
     CREATE TABLE helpers (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        c_id INTEGER NOT NULL,
        c_name TEXT,
        multiple BOOLEAN NOT NULL DEFAULT 0,
        name TEXT,
        contact TEXT,
        image TEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
    """;

  String createPivotTableCenterWorker = """
     CREATE TABLE center_worker (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        c_id INTEGER NOT NULL,
        w_id INTEGER NOT NULL)
    """;

  String createPivotTableWorkerHelper = """
     CREATE TABLE worker_helper (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        w_id INTEGER NOT NULL,
        h_id INTEGER NOT NULL)
    """;

  Future<sql.Database> initDB() async {
    final databasePath = await sql.getDatabasesPath();
    final path = join(databasePath, databaseName);

    return sql.openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(createTableCenter);
          await db.execute(createTableWorkers);
          await db.execute(createTableHelpers);
          await db.execute(createPivotTableCenterWorker);
          await db.execute(createPivotTableWorkerHelper);
        });
  }

  // Check duplicate centers
  Future<bool> checkCenter(String id) async {
    final sql.Database db = await initDB();
    final resultSet = await db.rawQuery('SELECT COUNT(id) FROM centers WHERE c_id = $id');
    final count = sql.Sqflite.firstIntValue(resultSet);
    return (count! > 0) ? true : false;
  }

  Future<bool> checkWorker(String id, String name, int multiple) async {
    final sql.Database db = await initDB();

    final resultSet = await db.rawQuery("SELECT COUNT(id) FROM workers WHERE c_id = ${int.parse(id)}");
    final count = sql.Sqflite.firstIntValue(resultSet);
    return (count! > 0) ? true : false;

  }

  Future<bool> checkWorkerId(Map<String, dynamic> worker) async {
    final sql.Database db = await initDB();
    String query = '';
    String cName = worker['name'][0]['name'];
    int cId = 0;
    if(worker['isCenterChanged']) {
      cId = int.parse(worker['name'][0]['cid']);
    } else{
      cId = worker['name'][0]['cid'];
    }
    // int cId = int.parse(worker['name'][0]['cid']);
    print(worker);
    if(worker['isCenterChanged']){
      query = "SELECT COUNT(id) FROM workers WHERE c_name = '$cName'";
      final resultSet = await db.rawQuery(query);
      final count = sql.Sqflite.firstIntValue(resultSet);
      return (count! > 0) ? true : false;
    } else{
      query = "SELECT COUNT(id) FROM workers WHERE c_id = $cId";
      final resultSet = await db.rawQuery(query);
      final count = sql.Sqflite.firstIntValue(resultSet);
      return (count! > 0) ? false : true;
    }
  }

  //Create Centers
  Future<int> createCenter(Map<String, dynamic> center) async {
    final sql.Database db = await initDB();
    bool status = await checkCenter(center['c_id']);
    if(status) {
      return 0;
    } else {
      return db.insert('centers', center);
    }
  }

  Future<Map<String, dynamic>> createWorker(Map<String, dynamic> worker) async {
    final sql.Database db = await initDB();
    List<Map<String, String>> duplicate = [];
    Map<String, dynamic> result = {
      'status' : false,
      'duplicates' : duplicate
    };

    bool status = false;
    //First loop with the list of centers in worker data
    for(var element in worker['name']) {
      // Depending on the no of centers check the duplicates
      status = await checkWorker(element['cid'], worker['w_name'], worker['multiple']);
      if(status) {
        duplicate.add({
          'w_name' : worker['w_name'],
          'cid' : element['cid']
        });
      } else {
        String query = """
            INSERT INTO workers (c_id, c_name, multiple ,name, contact, image)
            VALUES (${int.parse(element['cid'])}, '${element['name']}', 
            ${worker['multiple']}, '${worker['w_name']}', '${worker['w_contact']}', '${worker['im'
            'age'
            '']}')
          """;
        await db.rawInsert(query);
      }
    }

    if(duplicate.isNotEmpty) {
      result['status'] = false;
      result['duplicates'] = duplicate;
    } else {
      result['status'] = true;
      result['duplicates'] = duplicate;
    }

    return result;
  }

  Future<Map<String, dynamic>> updateWorker(Map<String, dynamic> worker) async {
    final sql.Database db = await initDB();
    int id = worker['id'];
    String wName = worker['w_name'];
    String wContact = worker['w_contact'];
    String image = worker['image'];
    String cName = worker['name'][0]['name'];
    int cId = 0;
    if(worker['isCenterChanged']) {
      cId = int.parse(worker['name'][0]['cid']);
    } else{
      cId = worker['name'][0]['cid'];
    }
    List<Map<String, String>> duplicate = [];
    Map<String, dynamic> result = {
      'status' : false,
      'duplicates' : duplicate,
      'message' : ''
    };

    if(!worker['multiple']) {
      bool res = await checkWorkerId(worker);
      if(!res) {
        String query = """
         UPDATE workers 
         SET name= ?,
         contact= ?,
         c_id = ?,
         c_name = ?,
         image = ? 
         WHERE id = ?
        """;
        int response = await db.rawUpdate(query,[wName,wContact, cId, cName, image, id]);
        if(response > 0) {
          result = {
            'status' : true,
            'duplicates' : duplicate,
            'message' : '$wName details updated successfully!',
          };
        } else {
          result = {
            'status' : false,
            'duplicates' : duplicate,
            'message' : '$wName details was not updated. Please try again.'
          };
        }

        return result;
      } else {
        result = {
          'status' : false,
          'duplicates' : duplicate,
          'message' : 'Center : "$cName" is already assigned. Update failed.'
        };
        return result;
      }
    } else {
      result = {
        'status' : false,
        'duplicates' : duplicate,
        'message' : '$wName is assigned with multiple centers. Update failed!.'
      };
      return result;
    }
  }

  Future<int> updateCenter(Map<String, dynamic> center) async {
    final sql.Database db = await initDB();
    Map<String, dynamic> resultMap = {};
    center.forEach((key, value) {
      // Check if the value is not empty (null, empty string, empty list, or empty map)
      if (value != null &&
          !(value is String && value.isEmpty)) {
        // Add the key-value pair to the result map
        resultMap[key] = value;
      }
    });

    bool status = await checkCenter(resultMap['c_id']);
    if(status) {
      return db.update('centers', resultMap, where: 'c_id = ?', whereArgs: [resultMap['c_id']]);
    } else {
      return 0;
    }
  }

  Future<int> deleteRecord(String tableName, int id) async {
    final sql.Database db = await initDB();

    if(tableName == 'centers') {
      await db.transaction((txn) async {
        String query = "SELECT c_id FROM centers WHERE id = ?";
        List<Map<String, dynamic>> center = await txn.rawQuery(query, [id]);
        await txn.rawDelete("DELETE FROM workers WHERE c_id = ?", [center[0]['c_id']]);
        await txn.rawDelete("DELETE FROM centers WHERE id = ?", [id]);
      });

      return 1;
    }

    return db.rawDelete('DELETE FROM $tableName WHERE id = ?',[id]);
  }

  Future<List<Map<String, dynamic>>> getData(String tableName, String orderBy) async {
    final sql.Database db = await initDB();
    String query = 'SELECT * FROM $tableName ORDER BY $orderBy';
    return db.rawQuery(query);
  }

  Future<List<Map<String, dynamic>>> getDataWithCondition(String tableName, String orderBy,
      String condition, List<String> args) async {
    final sql.Database db = await initDB();
    return db.query(
      tableName,
      orderBy: orderBy,
      where: condition,
      whereArgs: args
    );
  }

  Future<List<String>> getMultipleCenters(String wName) async {
    final sql.Database db = await initDB();
    List<Map<String, dynamic>> result = [];
    List<String> resp = [];
    result = await db.rawQuery(
        'SELECT c_name FROM workers WHERE name=? and multiple=? order by c_id',
        [wName, 1]
    );

    if(result.isNotEmpty) {
      for(var element in result) {
        resp.add(element['c_name']);
      }
    }

    return resp;
  }

  Future<List<Map<String, dynamic>>> getCentersWorkers() async {
    final sql.Database db = await initDB();
    return await db.rawQuery('''
      SELECT 
        c.id, c.c_id, c.name, c.code, c.address, c.landmark, c.c_type, c.lat, c.long, c.image,
        w.name AS w_name, w.contact AS w_contact
      FROM centers AS c
      INNER JOIN workers AS w ON w.c_id = c.c_id
      ORDER BY c.c_id
    ''');
  }
}