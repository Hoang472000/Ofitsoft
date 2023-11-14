class ReplyEntity {
  int? id;
  int? userId;
  String? userName;
  String? description;
  String? createDate;


  ReplyEntity(
      {this.id,
        this.userId,
        this.userName,
        this.description,
      this.createDate});


  // Factory constructor for JSON conversion
  factory ReplyEntity.fromJson(Map<String, dynamic> json) {
    print("HoangCV: reply: json: ${json}");
    return ReplyEntity(
      id: json['id'] ?? -1,
      userId: json['user_id'] ?? -1,
      userName: json['user_name'] ?? '',
      description: ((json['description'] ?? '') as String).replaceAll('<p>', '').replaceAll('</p>', ''),
      createDate: json['create_date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'user_id': userId,
      'description': description,
      'create_date': createDate,
    };
  }

}

