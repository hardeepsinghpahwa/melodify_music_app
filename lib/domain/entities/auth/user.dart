class UserEntity {
  String? fullName;
  String? email;
  String? userId;

  UserEntity(this.fullName, this.email, this.userId);

  factory UserEntity.fromFirestore(Map<String, dynamic> data) {
    return UserEntity(
      data['name'] ?? '',
      data['email'] ?? '',
      data['user_id'] ?? '',
    );
  }
}
