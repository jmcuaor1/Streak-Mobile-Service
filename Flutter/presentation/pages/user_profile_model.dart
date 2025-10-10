class UserProfile {
  String name;
  String title;
  String email;
  String? phone;
  String avatarUrl;

  UserProfile({
    required this.name,
    required this.title,
    required this.email,
    this.phone,
    required this.avatarUrl,
  });
}