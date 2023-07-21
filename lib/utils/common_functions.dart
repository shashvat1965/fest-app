class CommonFunctions {
  static DateTime? timeStampConverter(String? timeStamp) {
    DateTime? date = (timeStamp == null ? null : DateTime.parse(timeStamp));
    return date;
  }

  static getCorrectTimeString(DateTime date) {
    return '${(date.hour) > 12 ? date.hour % 12 : (date.hour == 0 ? 12 : (date.hour > 9 ? date.hour : '0' + date.hour.toString()))}:${(date.minute > 9 ? date.minute : '0' + date.minute.toString())} ${date.hour >= 12 ? 'PM' : 'AM'}';
  }

  static String monthConverter(int month) {
    switch (month) {
      case 10:
        return 'OCT';
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
      default:
        return 'NA';
    }
  }
}
