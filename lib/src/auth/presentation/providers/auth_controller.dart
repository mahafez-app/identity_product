import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:identity_service/identity_service.dart';
import 'package:mahafez_core/mahafez_core.dart';


enum IdentityLoadingMethod { none, email, google, confirmName, signOut }

const _unsetFailure = Object();

final class IdentityAuthState {
  const IdentityAuthState({
    this.loadingMethod = IdentityLoadingMethod.none,
    this.error,
  });

  final IdentityLoadingMethod loadingMethod;
  final Failure? error;

  bool get isLoading => loadingMethod != IdentityLoadingMethod.none;

  IdentityAuthState copyWith({
    IdentityLoadingMethod? loadingMethod,
    Object? error = _unsetFailure,
  }) => IdentityAuthState(
    loadingMethod: loadingMethod ?? this.loadingMethod,
    error: identical(error, _unsetFailure) ? this.error : error as Failure?,
  );
}

final identityAuthControllerProvider =
    NotifierProvider<IdentityAuthController, IdentityAuthState>(
      IdentityAuthController.new,
    );

final class IdentityAuthController extends Notifier<IdentityAuthState> {
  @override
  IdentityAuthState build() => const IdentityAuthState();

  void clearError() => state = state.copyWith(error: null);

  Future<void> signInWithGoogle() => _run(
    IdentityLoadingMethod.google,
    ref.read(identityServiceProvider).signInWithGoogle,
  );

  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) => _run(
    IdentityLoadingMethod.email,
    () => ref
        .read(identityServiceProvider)
        .signInWithEmailPassword(email: email, password: password),
  );

  Future<void> signUpWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) => _run(
    IdentityLoadingMethod.email,
    () => ref
        .read(identityServiceProvider)
        .signUpWithEmailPassword(
          email: email,
          password: password,
          displayName: displayName,
        ),
  );

  Future<void> updateDisplayName({
    required String uid,
    required String displayName,
  }) => _run(
    IdentityLoadingMethod.confirmName,
    () => ref
        .read(identityServiceProvider)
        .updateDisplayName(uid: uid, displayName: displayName),
  );

  Future<void> signOut() => _run(
    IdentityLoadingMethod.signOut,
    ref.read(identityServiceProvider).signOut,
  );

  Future<void> _run<T>(
    IdentityLoadingMethod method,
    Future<Result<T>> Function() operation,
  ) async {
    state = state.copyWith(loadingMethod: method, error: null);
    final result = await operation();
    result.fold(
      (failure) => state = state.copyWith(
        loadingMethod: IdentityLoadingMethod.none,
        error: failure,
      ),
      (_) => state = state.copyWith(loadingMethod: IdentityLoadingMethod.none),
    );
  }
}
