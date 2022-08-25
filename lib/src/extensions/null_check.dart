part of floy;

extension NullCheckObject on Object? {
  bool isNull() => this == null;
  bool isNotNull() => this != null;
}

