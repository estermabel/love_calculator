class Results {
  String fname;
  String sname;
  String percentage;
  String result;

  Results({this.fname, this.sname, this.percentage, this.result});

  Results.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    sname = json['sname'];
    percentage = json['percentage'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['sname'] = this.sname;
    data['percentage'] = this.percentage;
    data['result'] = this.result;
    return data;
  }
}
