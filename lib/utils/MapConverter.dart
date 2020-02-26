class MapConverter {
  static List<T> toList<T>(dynamic objectList, T Function(dynamic) function) {
    print(objectList);
    if (objectList == null || (objectList is List && objectList.isEmpty))
      return [];
      
    return objectList?.map((object) => function(object))?.toList()?.cast<T>();
  }

  static T toObject<T>(dynamic object, T Function(dynamic) function) {
    if (object == null || (object is Map && object.isEmpty)) return null;
    return function(object);
  }

  static DateTime toDateTime(dynamic object) {
    if (object == null || !(object is String)) return null;
    return DateTime.tryParse(object)?.toLocal();
  }
}
