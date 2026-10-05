import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_service/identity_service.dart';

final identityAuthStateProvider = StreamProvider<UserProfile?>(
  (ref) => ref.watch(identityServiceProvider).authStateChanges,
);

final identityCurrentUserProvider = Provider<UserProfile?>((ref) {
  ref.watch(identityAuthStateProvider);
  return ref.watch(identityServiceProvider).currentUser;
});
