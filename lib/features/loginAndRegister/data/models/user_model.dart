import 'package:equatable/equatable.dart';
import 'package:nan_class/features/loginAndRegister/domain/entity.dart';

class UserModel extends User {
  const UserModel({
    String? id,
    String? login,
    String? username,
    String? avatar,
    String? discordId,
    String? githubId,
    String? email,
    String? sexe,
    String? phone,
    String? pays,
    SpecialityModel? speciality,
    String? status,
    int? percentReduction,
    bool? accountDeleted,
    String? matricule,
    String? googleId,
    AccountingModel? accounting,
    int? ratingsPoints,
    int? coursesPoints,
    int? projectsPoints,
  }) : super(
          id: id,
          login: login,
          username: username,
          avatar: avatar,
          discordId: discordId,
          githubId: githubId,
          email: email,
          sexe: sexe,
          phone: phone,
          pays: pays,
          speciality: speciality,
          status: status,
          percentReduction: percentReduction,
          accountDeleted: accountDeleted,
          matricule: matricule,
          googleId: googleId,
          accounting: accounting,
          ratingsPoints: ratingsPoints,
          coursesPoints: coursesPoints,
          projectsPoints: projectsPoints,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        login: json["login"],
        username: json["username"],
        avatar: json["avatar"],
        discordId: json["discordId"],
        githubId: json["githubId"],
        email: json["email"],
        sexe: json["sexe"],
        phone: json["phone"],
        pays: json["pays"],
        speciality: SpecialityModel.fromJson(json["speciality"]),
        status: json["status"],
        percentReduction: json["percent_reduction"],
        accountDeleted: json["accountDeleted"],
        matricule: json["matricule"],
        googleId: json["googleId"],
        accounting: AccountingModel.fromJson(json["accounting"]),
        ratingsPoints: json["ratings_points"],
        coursesPoints: json["courses_points"],
        projectsPoints: json["projects_points"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "login": login,
        "username": username,
        "avatar": avatar,
        "discordId": discordId,
        "githubId": githubId,
        "email": email,
        "sexe": sexe,
        "phone": phone,
        "pays": pays,
        "speciality": speciality?.toJson(),
        "status": status,
        "percent_reduction": percentReduction,
        "accountDeleted": accountDeleted,
        "matricule": matricule,
        "googleId": googleId,
        "accounting": accounting?.toJson(),
        "ratings_points": ratingsPoints,
        "courses_points": coursesPoints,
        "projects_points": projectsPoints,
      };
}

class AccountingModel extends Equatable {
  final String? id;
  final String? typeOfSubscription;
  final List<dynamic>? payments;
  final bool? sold;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  const AccountingModel({
    this.id,
    this.typeOfSubscription,
    this.payments,
    this.sold,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AccountingModel.fromJson(Map<String, dynamic> json) => AccountingModel(
        id: json["_id"],
        typeOfSubscription: json["typeOfSubscription"],
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
        sold: json["sold"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "typeOfSubscription": typeOfSubscription,
        "payments":
            payments != null ? List<dynamic>.from(payments!.map((x) => x)) : [],
        "sold": sold,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  List<Object?> get props => [
        id,
        typeOfSubscription,
        payments,
        sold,
        createdAt,
        updatedAt,
        v,
      ];
}

//User speciality
class SpecialityModel extends Equatable {
  final List<dynamic>? presencesDays;
  final String? id;
  final String? name;
  final int? onlineCost;
  final int? presenceCost;
  final int? costByMonthOnline;
  final int? costByMonthPresence;

  const SpecialityModel({
    this.presencesDays,
    this.id,
    this.name,
    this.onlineCost,
    this.presenceCost,
    this.costByMonthOnline,
    this.costByMonthPresence,
  });

  factory SpecialityModel.fromJson(Map<String, dynamic> json) => SpecialityModel(
        presencesDays: List<dynamic>.from(json["presencesDays"].map((x) => x)),
        id: json["_id"],
        name: json["name"],
        onlineCost: json["onlineCost"],
        presenceCost: json["presenceCost"],
        costByMonthOnline: json["costByMonthOnline"],
        costByMonthPresence: json["costByMonthPresence"],
      );

  Map<String, dynamic> toJson() => {
        "presencesDays": presencesDays != null
            ? List<dynamic>.from(presencesDays!.map((x) => x))
            : [],
        "_id": id,
        "name": name,
        "onlineCost": onlineCost,
        "presenceCost": presenceCost,
        "costByMonthOnline": costByMonthOnline,
        "costByMonthPresence": costByMonthPresence,
      };

  @override
  List<Object?> get props => [
        presencesDays,
        id,
        name,
        onlineCost,
        presenceCost,
        costByMonthOnline,
        costByMonthPresence,
      ];
}
