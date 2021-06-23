extension ObjectCollections on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;

  bool? get asBool =>  this != null ? this as bool? : null;
  int? get asInt =>  this != null ? this as int? : null;
  double? get asDouble =>  this != null ? this as double? : null;
  String? get asString =>  this != null ? this as String? : null;
  T? asClassType<T>() => this != null ? this as T? : null;

  T? onNullOrElse<T>(T action(), {T orElse()?}) {
    if(this != null) {
      return orElse != null ? orElse() : null;
    }
    return action() ?? (orElse != null ? orElse() : null);
  }

  T? onNotNullOrElse<T>(T action(), {T orElse()?}) {
   if(this == null) {
     return orElse != null ? orElse() : null;
   }
   return action() ?? (orElse != null ? orElse() : null);
 }

  bool isGivenClassType<T>() => this != null && this is T && this.runtimeType == T;
}

extension BoolCollections on bool? {
   bool get isBool => this != null && this is bool && this.runtimeType == bool;
}

extension ListCollections on List? {
  bool get isEmptyList => this != null && this is List && this.runtimeType == List
    && this!.length <= 0;
  bool get isNotEmptyList => this != null && this is List && this.runtimeType == List
    && this!.length > 0;
}

extension MapCollections on Map? {
  bool get isEmptyMap => this != null && this is Map && this.runtimeType == Map
    && this!.length <= 0;
  bool get isNotEmptyMap => this != null && this is Map && this.runtimeType == Map
    && this!.length > 0;

  bool isValueByKeyExists(String key) => this != null && this is Map && this.runtimeType == Map
    && this![key] != null;
}

extension NumCollections on num? {
   bool get isInt => this != null && this is int && this.runtimeType == int && (this! % 1) == 0;
   bool get isDouble => this != null && this is double && this.runtimeType == double;
}


extension StringCollections on String? {
  bool get isEmptyString => this != null && this is String && this.runtimeType == String
    && this!.length <= 0;
  bool get isNotEmptyString => this != null && this is String && this.runtimeType == String
    && this!.length > 0;

  bool get isInt => this != null && int.tryParse(this!) != null;
  bool get isDouble => this != null && double.tryParse(this!) != null;

  int? toInt({int orElse()?}) {
    if(this == null) {
      return orElse != null ? orElse() : null;
    }
    return int.tryParse(this!) ?? (orElse != null ? orElse() : null);
  }

  double? toDouble({double orElse()?}) {
    if(this == null) {
      return orElse != null ? orElse() : null;
    }
    return double.tryParse(this!) ?? (orElse != null ? orElse() : null);
  }
}
