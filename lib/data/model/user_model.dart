class UserModel {
  final String id;
  final String first_name;
  final String last_name;
  final String full_name;
  final String email;
  final String? profile_image;

  UserModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.full_name,
    required this.email,
    this.profile_image,
  });

  UserModel copyWith({
    String? id,
    String? first_name,
    String? last_name,
    String? full_name,
    String? email,
    String? profile_image,
  }) {
    return UserModel(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      profile_image: profile_image ?? this.profile_image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'full_name': full_name,
      'email': email,
      'profile_image': profile_image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      full_name: map['full_name'] as String,
      email: map['email'] as String,
      profile_image: map['profile_image'] != null ? ['profile_image'] as String : null,
    );
  }


}
