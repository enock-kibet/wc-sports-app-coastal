part of 'service.dart';


class LocalService {
  HttpResult<Database> db() async {
    try {
      // get the application documents directory
      final dir = await getApplicationDocumentsDirectory();
      // make sure it exists
      await dir.create(recursive: true);
      // build the database path
      final dbPath = join(dir.path, 'sports.db');
      // open the database
      final db = await databaseFactoryIo.openDatabase(dbPath);
      return MultipleResult.onSuccess(data: db);
    } catch (error) {
      return MultipleResult.onError(error: Failure(error: error.toString()));
    }
  }

  Future<dynamic> storeData(
      {required String key, required dynamic data}) async {
    // dynamically typed store
    var store = StoreRef.main();
    //Initialize data
    dynamic data;
    // get the database
    var database = await db();
    database.when(onError: (error) {
      // log the error
      service<Talker>().error(error.toJson());
    }, onSuccess: (client) async {
      // store the data
      data = await store.record(key).put(client, data);
    });

    return data;
  }

  Future<dynamic> getData({required String key}) async {
    // dynamically typed store
    var store = StoreRef.main();
    //Initialize data
    dynamic data;
    // get the database
    var database = await db();
    database.when(onError: (error) {
      // log the error
      service<Talker>().error(error.toJson());
    }, onSuccess: (client) async {
      // store the data
      data = await store.record(key).get(client);
    });

    return data;
  }

  Future<bool> deleteData({required String key}) async {
    // dynamically typed store
    var store = StoreRef.main();
    //Initialize data
    bool deleted = false;
    // get the database
    var database = await db();
    database.when(onError: (error) {
      // log the error
      deleted = false;
      service<Talker>().error(error.toJson());
    }, onSuccess: (client) async {
      // store the data
      await store.record(key).delete(client);
    });

    return deleted;
  }
}
