class DirectorItem {
  const DirectorItem({
    required this.email,
    required this.ownership,
    required this.shares,
    required this.phone,
    required this.address,
    required this.role,
    required this.name,
  });

  final String email;
  final String ownership;
  final String shares;
  final String phone;
  final String address;
  final String role;
  final String name;

  String get displayName => email.split('@').first;
  String get subtitle => '$role • $ownership% Ownership';
}
