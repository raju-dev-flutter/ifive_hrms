import 'package:intl/intl.dart';

class Convert {
  static dynamic month(DateTime tm) {
    switch (tm.month) {
      case 1:
        return "JAN";

      case 2:
        return "FEB";

      case 3:
        return "MAR";

      case 4:
        return "APR";

      case 5:
        return "MAY";

      case 6:
        return "JUN";

      case 7:
        return "JUL";

      case 8:
        return "AUG";

      case 9:
        return "SEP";

      case 10:
        return "OCT";

      case 11:
        return "NOV";

      case 12:
        return "DEC";
    }
  }

  static dynamic day(DateTime td) {
    var tempDay = DateFormat('EEEE').format(td);
    switch (tempDay) {
      case 'Monday':
        return "MON";

      case 'Tuesday':
        return "TUE";

      case 'Wednesday':
        return "WED";

      case 'Thursday':
        return "THU";

      case 'Friday':
        return "FRI";

      case 'Saturday':
        return "SAT";

      case 'Sunday':
        return "SUN";
    }
  }
}
