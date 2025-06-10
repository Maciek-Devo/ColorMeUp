/// Global lock used to temporarily disable all copy actions across the app.
///
/// When a copy action is executed we call
/// `CopyLock.lock(const Duration(milliseconds: 500))`.
/// Until the given duration elapses, `CopyLock.isLocked` will return `true`
/// and all copy buttons should ignore user interaction. This prevents the UI
/// from freezing due to rapid consecutive clipboard operations.
///
/// Użytkownik nie widzi, że przyciski są nieaktywne – po prostu kolejna próba
/// kopiowania w czasie blokady jest ignorowana.
class CopyLock {
  static bool _locked = false;

  /// Whether the copy lock is currently active.
  static bool get isLocked => _locked;

  CopyLock._();

  /// Activates the lock for the provided duration. If the lock is already
  /// active, calling this method has no additional effect.
  static void lock(Duration duration) {
    if (_locked) return;
    _locked = true;

    Future.delayed(duration, () => _locked = false);
  }
}
