class QnAModel {
  int? id;
  String? ques;
  String? reply;

  QnAModel({this.id, this.ques, this.reply});

  QnAModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ques = json['ques'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ques'] = this.ques;
    data['reply'] = this.reply;
    return data;
  }
}
