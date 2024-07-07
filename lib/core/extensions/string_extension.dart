extension StringExtensions on String? {
  /// Capitalizes the first letter of the string.
  String get capitalizeFirstLetter =>
      '${this![0].toUpperCase()}${this!.substring(1)}';

  /// Capitalizes the first letter of each word in the string.
  String get capitalizeAllWords =>
      this!.split(' ').map((word) => word.capitalizeFirstLetter).join(' ');

  /// Converts the string to title case.
  String toTitleCase() =>
      this!.split(' ').map((word) => word.capitalizeFirstLetter).join(' ');

  /// Checks if the string is null or empty.
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Checks if the string is null, empty, or contains only whitespace.
  bool get isNullOrWhitespace => this == null || this!.trim().isEmpty;

  /// Reverses the characters of the string.
  String get reverse => this!.split('').reversed.join('');

  /// Returns the numeric value of the string or null if conversion fails.
  num? toNumeric() {
    try {
      return num.parse(this!);
    } catch (_) {
      return null;
    }
  }

  /// Converts the string to an integer or null if conversion fails.
  int? toInt() => int.tryParse(this!);

  /// Converts the string to a double or null if conversion fails.
  double? toDouble() => double.tryParse(this!);

  /// Checks if the string represents a valid email address.
  bool get isValidEmail {
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(this!);
  }

  /// Checks if the string represents a valid URL.
  bool get isValidUrl {
    final regex = RegExp(
        r'^(?:http|https):\/\/[\w\-_]+(?:\.[\w\-_]+)+(?:[\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?$');
    return regex.hasMatch(this!);
  }

  /// Checks if the string represents a valid GUID
  bool get isGuid {
    final guidRegExp = RegExp(
        r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
    return guidRegExp.hasMatch(this!);
  }

  /// Truncates the string to the specified [maxLength] and appends [ellipsis] if truncation occurs.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (this!.length <= maxLength) return this!;
    return '${this!.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }
}
