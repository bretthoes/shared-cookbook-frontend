import 'package:boilerplate/core/data/local/sembast/sembast_client.dart';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook.dart';
import 'package:boilerplate/domain/entity/cookbook/cookbook_list.dart';
import 'package:boilerplate/domain/entity/person/person.dart';
import 'package:sembast/sembast.dart';

class PersonDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _personStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final SembastClient _sembastClient;

  // Constructor
  PersonDataSource(this._sembastClient);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Person person) async {
    return await _personStore.add(_sembastClient.database, person.toMap());
  }

  Future<int> count() async {
    return await _personStore.count(_sembastClient.database);
  }

  Future<List<Person>> getAllSortedByFilter({List<Filter>? filters}) async {
    //creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    final recordSnapshots = await _personStore.find(
      _sembastClient.database,
      finder: finder,
    );

    // Making a List<Cookbook> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final cookbook = Person.fromMap(snapshot.value);
      cookbook.personId = snapshot.key;
      return cookbook;
    }).toList();
  }

  Future<Person?> getPersonById({List<Filter>? filters}) async {
    // creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

    // check for person in db
    final recordSnapshot = await _personStore.findFirst(
      _sembastClient.database,
      finder: finder,
    );

    if (recordSnapshot != null) {
      final person = Person.fromMap(recordSnapshot.value);
      person.personId = recordSnapshot.key;
      return person;
    }

    return null;
  }

  Future<Person?> getPersonByEmail({List<Filter>? filters}) async {
    // creating finder
    final finder = Finder(
        filter: filters != null ? Filter.and(filters) : null,
        sortOrders: [SortOrder(DBConstants.FIELD_EMAIL)]);

    // check for person in db
    final recordSnapshot = await _personStore.findFirst(
      _sembastClient.database,
      finder: finder,
    );

    if (recordSnapshot != null) {
      final person = Person.fromMap(recordSnapshot.value);
      person.personId = recordSnapshot.key;
      return person;
    }

    return null;
  }

  Future<CookbookList> getCookbooksFromDb() async {
    print('Loading from database');

    // cookbook list
    var cookbooksList;

    // fetching data
    final recordSnapshots = await _personStore.find(
      _sembastClient.database,
    );

    // Making a List<Cookbook> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      cookbooksList = CookbookList(
          cookbooks: recordSnapshots.map((snapshot) {
        final cookbook = Cookbook.fromMap(snapshot.value);
        // An ID is a key of a record from the database.
        cookbook.cookbookId = snapshot.key;
        return cookbook;
      }).toList());
    }

    return cookbooksList;
  }

  Future<int> update(Cookbook cookbook) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(cookbook.cookbookId));
    return await _personStore.update(
      _sembastClient.database,
      cookbook.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Cookbook cookbook) async {
    final finder = Finder(filter: Filter.byKey(cookbook.cookbookId));
    return await _personStore.delete(
      _sembastClient.database,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _personStore.drop(
      _sembastClient.database,
    );
  }
}
