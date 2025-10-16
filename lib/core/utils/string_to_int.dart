int safeIntParse(dynamic value) {
  if(value == null) return 0;
  if(value is int) return value;
  if(value is double) return value.toInt();
  if(value is String) {
    return int.tryParse(value.split('.').first) ?? 0;
  }
  return 0;

}