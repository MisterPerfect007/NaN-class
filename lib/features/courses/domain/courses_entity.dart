import 'package:equatable/equatable.dart';

import '../data/models/courses_model.dart';

class Courses extends Equatable{
  final String? month;
  final List<MonthCourse> courses;

  const Courses({this.month, required this.courses});

  @override
  List<Object?> get props => [month, courses];
  
}