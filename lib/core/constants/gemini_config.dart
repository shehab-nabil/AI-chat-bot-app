/// Supplied at build time, e.g.
/// `flutter run --dart-define=GEMINI_API_KEY=... [--dart-define=GEMINI_MODEL=...]`.
abstract final class GeminiConfig {
  static const apiKey = String.fromEnvironment('GEMINI_API_KEY');
  static const model = String.fromEnvironment(
    'GEMINI_MODEL',
    defaultValue: 'gemini-3.8-flash',
  );
}
