/// Helper class around product field conversion to/from JSON
class JsonHelper {
  /// Returns a [DateTime] from a JSON-encoded String (e.g. '2021-10-29T11:00:56.177379')
  static DateTime stringTimestampToDate(dynamic json) =>
      DateTime.parse(json as String);

  /// Returns a [DateTime] from a JSON-encoded String (e.g. '2021-10-29T11:00:56.177379')
  static DateTime? nullableStringTimestampToDate(dynamic json) =>
      json == null ? null : stringTimestampToDate(json);
}
