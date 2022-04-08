import 'package:flipper/logic/cubit/storage/shared_preferneces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import 'states.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(InitialState());

  final controller = TextEditingController();

  int countLength = 0;

  void countStr(String value) {
    countLength = value.length;
    emit(CountLengthState());
  }

  Database? database;
  List listTasks = [];

  Future<List<Map>> getData(database) async {
    return await database.rawQuery('SELECT * FROM Tasks');
  }

  void createDb() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        await database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, taskName TEXT, status TEXT)')
            .then((value) {
        });
        emit(CreateTbalesState());
      },
      onOpen: (database) {
        getData(database).then((value) {
          listTasks = value;
          emit(GetDbState());
        });
        emit(OpenDbState());
      },
    );
    emit(CreateDbState());
  }

  insertDB() async {
    await database?.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO Tasks (taskName, status) VALUES("${controller.text}", "false")')
          .then((value) {
        getData(database).then((value) {
          listTasks = value;
          emit(GetDbState());
        });
        emit(AddTaskState());
      }).catchError((error) {
        // print('Error catched while inserting the data ${error.toString()}');
      });
      return null;
    });
  }

  void deleteTask(id) {
    database!.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      emit(DeleteRecordState());
      getData(database).then((value) {
        listTasks = value;
      });
    });
  }

  void updateTask({
    required String status,
    required int id,
  }) {
    database!.rawDelete('UPDATE Tasks SET status = ? WHERE id = ?', [
      status,
      '$id',
    ]).then((value) {
      emit(UpdateRecordState());
      getData(database).then((value) {
        listTasks = value;
      });
    });
  }

  Future<void> deleteDB() async {
    await deleteDatabase('todo.db').then((value) {});
    emit(DeleteDbState());
  }

  Future<int?> countRecord() async {
    int? count = Sqflite.firstIntValue(
      await database!.rawQuery('SELECT COUNT(*) FROM Tasks'),
    );
    return count;
  }

  bool isDark = true;
  void changeTheme([bool? fromShared]) async {
    if (fromShared == null) {
      isDark = !isDark;
    } else {
      isDark = fromShared;
    }
    SharedPrefs.storeValue(isDark);
    emit(ChangeThemeState());
  }
}
