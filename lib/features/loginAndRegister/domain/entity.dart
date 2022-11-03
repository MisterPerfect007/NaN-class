import 'package:equatable/equatable.dart';

import '../data/models/user_model.dart';

class User extends Equatable {
  final String? id;
  final String? login;
  final String? username;
  final String? avatar;
  final String? discordId;
  final String? githubId;
  final String? email;
  final String? sexe;
  final String? phone;
  final String? pays;
  final SpecialityModel? speciality;
  final String? status;
  final double? percentReduction;
  final bool? accountDeleted;
  final String? matricule;
  final String? googleId;
  final AccountingModel? accounting;
  final double? ratingsPoints;
  final double? coursesPoints;
  final double? projectsPoints;

  const User({
    this.id,
    this.login,
    this.username,
    this.avatar,
    this.discordId,
    this.githubId,
    this.email,
    this.sexe,
    this.phone,
    this.pays,
    this.speciality,
    this.status,
    this.percentReduction,
    this.accountDeleted,
    this.matricule,
    this.googleId,
    this.accounting,
    this.ratingsPoints,
    this.coursesPoints,
    this.projectsPoints,
  });

  @override
  List<Object?> get props => [
        id,
        login,
        username,
        avatar,
        discordId,
        githubId,
        email,
        sexe,
        phone,
        pays,
        speciality,
        status,
        percentReduction,
        accountDeleted,
        matricule,
        googleId,
        accounting,
        ratingsPoints,
        coursesPoints,
        projectsPoints,
      ];
}
