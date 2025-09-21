/// A helper class for storing constant values used across the project.
class ConstantsHelper {
  /// A list of route or API prefixes that should be removed
  /// when generating names.
  ///
  /// Example:
  /// - "dashboard/user/get" → "user/get"
  /// - "mobile/order/list" → "order/list"
  static List<String> allPrefixesToRemove = [];

  /// The default category name used when no specific category is found.
  static const String generalCategory = 'General';
}

const String LINE = "\n";
