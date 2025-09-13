// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  final String? title;
  String? id;
  final String? describtion;
  final DateTime? date;
  final int? priority;
  final bool? isCompleted;

 TaskModel({
    this.title,
    this.id,
    this.describtion,
    this.date,
    this.priority,
    this.isCompleted = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          describtion: json['describtion'],
          date: json['date'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['date'])
              : null,
          priority: json['priority'],
          isCompleted: json['isCompleted'],
        );

  Map<String, dynamic> toJson()  {
    final normalizedDate=DateTime(date!.year,date!.month,date!.day);
    return{
        'id': id,
        'title': title,
        'describtion': describtion,
        'date': normalizedDate.millisecondsSinceEpoch,
        'priority': priority,
        'isCompleted': isCompleted,
      };
  }
}
