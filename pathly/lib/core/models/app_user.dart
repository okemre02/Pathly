import 'package:cloud_firestore/cloud_firestore.dart';

/// Represents a user profile stored in Firestore
/// Path: users/{uid}
class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final Map<String, String>
  selectedSubPaths; // {'game_dev': 'unity', 'mobile_dev': 'flutter'}
  final List<String> completedNodes;

  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    this.selectedSubPaths = const {},
    this.completedNodes = const [],
  });

  /// Create a new user profile (for signup)
  factory AppUser.create({
    required String uid,
    required String email,
    String? displayName,
  }) {
    return AppUser(
      uid: uid,
      email: email,
      displayName: displayName ?? email.split('@').first,
      createdAt: DateTime.now(),
      selectedSubPaths: {},
      completedNodes: [],
    );
  }

  /// Serialize to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'displayName': displayName,
      'createdAt': Timestamp.fromDate(createdAt),
      'selectedSubPaths': selectedSubPaths,
      'completedNodes': completedNodes,
    };
  }

  /// Deserialize from Firestore document
  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return AppUser(
      uid: doc.id,
      email: data['email'] as String? ?? '',
      displayName: data['displayName'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      selectedSubPaths: Map<String, String>.from(
        data['selectedSubPaths'] as Map<String, dynamic>? ?? {},
      ),
      completedNodes: List<String>.from(
        data['completedNodes'] as List<dynamic>? ?? [],
      ),
    );
  }

  /// CopyWith for immutable updates
  AppUser copyWith({
    String? uid,
    String? email,
    String? displayName,
    DateTime? createdAt,
    Map<String, String>? selectedSubPaths,
    List<String>? completedNodes,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      selectedSubPaths: selectedSubPaths ?? this.selectedSubPaths,
      completedNodes: completedNodes ?? this.completedNodes,
    );
  }

  @override
  String toString() {
    return 'AppUser(uid: $uid, email: $email, displayName: $displayName)';
  }
}
