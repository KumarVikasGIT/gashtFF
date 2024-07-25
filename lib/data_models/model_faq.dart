class Faq {
  int? id;
  String? title;
  String? description;

  Faq({this.id, this.title, this.description});

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class Model_Faq {
  String? status;
  List<Faq>? faqs;

  Model_Faq({this.status, this.faqs});

  Model_Faq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['faqs'] != null) {
      faqs = <Faq>[];
      json['faqs'].forEach((v) {
        faqs!.add(Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['faqs'] =faqs != null ? faqs!.map((v) => v?.toJson()).toList() : null;
    return data;
  }
}