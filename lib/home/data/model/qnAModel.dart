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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ques'] = ques;
    data['reply'] = reply;
    return data;
  }
}
