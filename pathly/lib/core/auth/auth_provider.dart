import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/app_user.dart';

/// Firebase Auth instance provider
final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>((ref) {
  return firebase_auth.FirebaseAuth.instance;
});

/// Firestore instance provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// Auth state that holds the current user
class AuthState {
  final bool isLoading;
  final AppUser? user;
  final String? errorMessage;

  const AuthState({this.isLoading = false, this.user, this.errorMessage});

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    bool? isLoading,
    AppUser? user,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// Auth provider with Firebase integration
final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  firebase_auth.FirebaseAuth get _auth => ref.read(firebaseAuthProvider);
  FirebaseFirestore get _firestore => ref.read(firestoreProvider);

  @override
  AuthState build() {
    // Listen to Firebase auth state changes
    _auth.authStateChanges().listen((firebaseUser) async {
      if (firebaseUser != null) {
        await _loadUserProfile(firebaseUser.uid);
      } else {
        state = const AuthState();
      }
    });

    // Check if already signed in
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      _loadUserProfile(currentUser.uid);
    }

    return const AuthState();
  }

  /// Load user profile from Firestore
  Future<void> _loadUserProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        final appUser = AppUser.fromFirestore(doc);
        state = AuthState(user: appUser);
      } else {
        // User exists in Auth but not in Firestore (edge case)
        // Create profile
        final firebaseUser = _auth.currentUser;
        if (firebaseUser != null) {
          await _createUserProfile(firebaseUser);
        }
      }
    } catch (e) {
      state = AuthState(errorMessage: 'Failed to load profile: $e');
    }
  }

  /// Create user profile in Firestore
  Future<void> _createUserProfile(firebase_auth.User firebaseUser) async {
    final appUser = AppUser.create(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      displayName: firebaseUser.displayName,
    );

    await _firestore
        .collection('users')
        .doc(appUser.uid)
        .set(appUser.toFirestore());

    state = AuthState(user: appUser);
  }

  /// Sign up with email and password
  Future<void> signup(
    String email,
    String password, {
    String? displayName,
  }) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);

      // Create Firebase Auth user
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw Exception('Failed to create user');
      }

      // Update display name if provided
      if (displayName != null && displayName.isNotEmpty) {
        await firebaseUser.updateDisplayName(displayName);
      }

      // Create Firestore profile (users/{uid})
      final appUser = AppUser.create(
        uid: firebaseUser.uid,
        email: email,
        displayName: displayName ?? email.split('@').first,
      );

      await _firestore
          .collection('users')
          .doc(appUser.uid)
          .set(appUser.toFirestore());

      state = AuthState(user: appUser);
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getAuthErrorMessage(e.code),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred: $e',
      );
    }
  }

  /// Log in with email and password
  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true, clearError: true);

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _loadUserProfile(credential.user!.uid);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: _getAuthErrorMessage(e.code),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'An error occurred: $e',
      );
    }
  }

  /// Log out
  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);
      await _auth.signOut();
      state = const AuthState();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to log out: $e',
      );
    }
  }

  /// Update user's selected sub-path for a career path
  Future<void> selectSubPath(String careerPathId, String subPathId) async {
    final user = state.user;
    if (user == null) return;

    try {
      final updatedSubPaths = Map<String, String>.from(user.selectedSubPaths);
      updatedSubPaths[careerPathId] = subPathId;

      await _firestore.collection('users').doc(user.uid).update({
        'selectedSubPaths': updatedSubPaths,
      });

      state = state.copyWith(
        user: user.copyWith(selectedSubPaths: updatedSubPaths),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to update path: $e');
    }
  }

  /// Reset the selected sub-path for a career path
  Future<void> resetSubPath(String careerPathId) async {
    final user = state.user;
    if (user == null) return;

    try {
      final updatedSubPaths = Map<String, String>.from(user.selectedSubPaths);
      updatedSubPaths.remove(careerPathId);

      await _firestore.collection('users').doc(user.uid).update({
        'selectedSubPaths': updatedSubPaths,
      });

      state = state.copyWith(
        user: user.copyWith(selectedSubPaths: updatedSubPaths),
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to reset path: $e');
    }
  }

  /// Mark a node as completed
  Future<void> completeNode(String nodeId) async {
    final user = state.user;
    if (user == null) return;

    if (user.completedNodes.contains(nodeId)) return;

    try {
      final updatedNodes = [...user.completedNodes, nodeId];

      await _firestore.collection('users').doc(user.uid).update({
        'completedNodes': updatedNodes,
      });

      state = state.copyWith(user: user.copyWith(completedNodes: updatedNodes));
    } catch (e) {
      state = state.copyWith(errorMessage: 'Failed to complete node: $e');
    }
  }

  /// Get user-friendly error messages
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      default:
        return 'Authentication error: $code';
    }
  }
}

/// Provider to watch the current user's completed nodes (reactive)
final completedNodesStreamProvider = StreamProvider<List<String>>((ref) {
  final authState = ref.watch(authProvider);
  final user = authState.user;

  if (user == null) {
    return Stream.value([]);
  }

  final firestore = ref.read(firestoreProvider);

  return firestore.collection('users').doc(user.uid).snapshots().map((doc) {
    if (!doc.exists) return <String>[];
    final data = doc.data()!;
    return List<String>.from(data['completedNodes'] ?? []);
  });
});
