class Results {
  String percentage;
  String result;

  Results({this.percentage, this.result});

  Results.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['percentage'] = this.percentage;
    data['result'] = this.result;
    return data;
  }
}
