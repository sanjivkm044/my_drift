import 'package:drift/drift.dart';
import 'package:my_drift/db/db_service.dart';

part 'db_table.g.dart';



class User extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get phone => text()(); 
  TextColumn get dateOfBirth => text()();
}

@DriftAccessor(tables: [User])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin{
  UserDao(super.attachedDatabase);
  

  Future<void> insertData(UserCompanion userdata)async => await into(user).insert(userdata);

  Future<List<UserData>> getusers() async {
    return await select(user).get();
  }

  // Future<UserData> getSingleUser(int id) async {
  //   return await (select(user)..where((tbl) => tbl.id.equals(id))).getSingle();
  // }

  Future<bool> updateUsers(UserCompanion entity) async {
    return await update(user).replace(entity);
  }

 

  Future<int> deleteUsers(int id) async {
    return await (delete(user)..where((tble) => tble.id.equals(id))).go();
  }

}