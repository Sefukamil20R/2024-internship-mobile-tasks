import 'package:clean_architecture/features/auth/domain/entities/user_entitiy.dart';

class UsermodelNopassword extends User {
  UsermodelNopassword({
    required super.id,
    required super.name,
    required super.email,
    
  });

  factory UsermodelNopassword.fromJson(Map<String, dynamic> json) {
    return UsermodelNopassword(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
