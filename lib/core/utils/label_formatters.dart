import 'package:intl/intl.dart';

class LabelFormatters {
  LabelFormatters._();

  static String formatRoiPercentage(double value) {
    return '${value.toInt()}%';
  }

  static String formatPnlValue(double value) {
    
    return NumberFormat.compact().format(value);
  }
}