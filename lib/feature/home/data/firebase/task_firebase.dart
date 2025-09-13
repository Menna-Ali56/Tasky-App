import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/feature/auth/data/model/user_model.dart';
import 'package:tasky/feature/home/data/model/task_model.dart';

class TaskFirebase {
  static CollectionReference<TaskModel> getCollectionTask() {
    String id = FirebaseAuth.instance.currentUser?.uid ?? " ";

    return FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, _) => value.toJson(),
        )
        .doc(id)
        .collection("Tasks")
        .withConverter(
          fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask(TaskModel task) async {
    final colletion = getCollectionTask().doc();
    var id = colletion.id;
    task.id = id;
    await colletion.set(task);
  }

  static Future<List<TaskModel>> getTasks(DateTime date) async {
    final targetDate =
        DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    var tasks = await getCollectionTask()
        .where('date', isEqualTo: targetDate)
        .orderBy('priority', descending: false)
        .get();
    List<QueryDocumentSnapshot<TaskModel>> docs = tasks.docs;
    return docs.map((task) => task.data()).toList();
  }

  static deleteTask() {}
  static updateTask() {}
}
