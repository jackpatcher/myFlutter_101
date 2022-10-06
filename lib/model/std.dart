class Std {
  String userRegId;
  String stdId;
  String startName;
  String firstName;
  String lastName;
  String classLv;
  String room;
  String imgUrl;
  String tel;
  
 
  Std.fromJsonMap(Map<String, dynamic> map):
    userRegId = map["userRegId"],
    stdId = map["stdId"],
    startName = map["startName"],
    firstName = map['firstName'],
    lastName = map['lastName'],
    classLv = map['classLv'],
    room = map['room'],
    imgUrl = map['imgUrl'],
    tel = map['tel'];
   

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["userRegId"] = userRegId;
    data["stdId"] = stdId; 
    data["startName"] = startName;
    data["firstName"] = firstName;
    data["lastName"] = lastName;
    data["classLv "] = classLv;
    data["room"] = room;
    data["imgUrl"] = imgUrl;
    data["tel"] = tel;

    return data;
  }
}