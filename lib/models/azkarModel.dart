class Azkar {
  List<Azkardata> azkar = [];

  Azkar.fromJson(Map<String, dynamic> json) {
    if (json['Azkar'] != null) {
      azkar = [];
      json['Azkar'].forEach((v) {
        azkar.add(new Azkardata.fromJson(v));
      });
    }
  }
}

class Azkardata {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? zekr;

  Azkardata(
      {this.category, this.count, this.description, this.reference, this.zekr});

  Azkardata.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    zekr = json['zekr'];
  }
}
