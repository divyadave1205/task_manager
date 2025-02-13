class UserPreferences {
  final bool isDarkMode;
  final String sortOrder; // date, priority

  UserPreferences({required this.isDarkMode, required this.sortOrder});

  factory UserPreferences.fromMap(Map<String, dynamic> map) {
    return UserPreferences(
      isDarkMode: map['isDarkMode'] ?? false,
      sortOrder: map['sortOrder'] ?? 'date',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isDarkMode': isDarkMode,
      'sortOrder': sortOrder,
    };
  }
}
