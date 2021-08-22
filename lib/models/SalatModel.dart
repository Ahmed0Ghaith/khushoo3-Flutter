class SalatModel {
  int? code;
  String? status;
  List<Data> data = [];

  SalatModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  Timings? timings;
  Date? date;
  Meta? meta;

  Data.fromJson(Map<String, dynamic> json) {
    timings =
        json['timings'] != null ? new Timings.fromJson(json['timings']) : null;
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }
}

class Timings {
  String? fajr;
  String? sunrise;
  String? dhuhr;
  String? asr;
  String? sunset;
  String? maghrib;
  String? isha;
  String? imsak;
  String? midnight;
  List<String> image = [];

  Timings.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    sunset = json['Sunset'];
    maghrib = json['Maghrib'];
    isha = json['Isha'];
    imsak = json['Imsak'];
    midnight = json['Midnight'];
    image = [
      'assets/images/FR.jpg',
      'assets/images/SR.jpg',
      'assets/images/ZH.jpg',
      'assets/images/AS.jpg',
      'assets/images/MA.jpg',
      'assets/images/AS.jpg',
    ];
  }
}

class Date {
  String? readable;
  String? timestamp;
  Gregorian? gregorian;
  Hijri? hijri;

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    timestamp = json['timestamp'];
    gregorian = json['gregorian'] != null
        ? new Gregorian.fromJson(json['gregorian'])
        : null;
    hijri = json['hijri'] != null ? new Hijri.fromJson(json['hijri']) : null;
  }
}

class Gregorian {
  String? date;
  String? format;
  String? day;

  Month? month;
  String? year;
  Designation? designation;

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];

    month = json['month'] != null ? new Month.fromJson(json['month']) : null;
    year = json['year'];
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
  }
}

class Month {
  int? number;
  String? en;

  Month.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    en = json['en'];
  }
}

class Designation {
  String? abbreviated;
  String? expanded;

  Designation({this.abbreviated, this.expanded});

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json['abbreviated'];
    expanded = json['expanded'];
  }
}

class Hijri {
  String? date;
  String? format;
  String? day;

  Month? month;
  String? year;
  Designation? designation;
  List<Null>? holidays = [];

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];

    month = json['month'] != null ? new Month.fromJson(json['month']) : null;
    year = json['year'];
    designation = json['designation'] != null
        ? new Designation.fromJson(json['designation'])
        : null;
  }
}

class Meta {
  double? latitude;
  double? longitude;
  String? timezone;
  Method? method;
  String? latitudeAdjustmentMethod;
  String? midnightMode;
  String? school;
  Offset? offset;

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    method =
        json['method'] != null ? new Method.fromJson(json['method']) : null;
    latitudeAdjustmentMethod = json['latitudeAdjustmentMethod'];
    midnightMode = json['midnightMode'];
    school = json['school'];
    offset =
        json['offset'] != null ? new Offset.fromJson(json['offset']) : null;
  }
}

class Method {
  int? id;
  String? name;
  Params? params;

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    params =
        json['params'] != null ? new Params.fromJson(json['params']) : null;
  }
}

class Params {
  double? fajr;
  double? isha;

  Params.fromJson(Map<String, dynamic> json) {
    fajr = json['Fajr'];
    isha = json['Isha'];
  }
}

class Offset {
  int? imsak;
  int? fajr;
  int? sunrise;
  int? dhuhr;
  int? asr;
  int? maghrib;
  int? sunset;
  int? isha;
  int? midnight;

  Offset.fromJson(Map<String, dynamic> json) {
    imsak = json['Imsak'];
    fajr = json['Fajr'];
    sunrise = json['Sunrise'];
    dhuhr = json['Dhuhr'];
    asr = json['Asr'];
    maghrib = json['Maghrib'];
    sunset = json['Sunset'];
    isha = json['Isha'];
    midnight = json['Midnight'];
  }
}

class SalatTodayModel {
  String? Date;
  String? Salat;
  String? Time;
  String? Image;

  SalatTodayModel.fromJson(Map<String, dynamic> json) {
    Date = json['Date'];
    Date = json['Salat'];
    Date = json['Time'];
    Date = json['Image'];
  }
}
