class ChatContactModel {
  List<ChatContact>? chatContact;
  int? chatContactCount;

  ChatContactModel({this.chatContact, this.chatContactCount});

  ChatContactModel.fromJson(Map<String, dynamic> json) {
    if (json['chat_contact'] != null) {
      chatContact = <ChatContact>[];
      json['chat_contact'].forEach((v) {
        chatContact!.add(ChatContact.fromJson(v));
      });
    }
    chatContactCount = json['chat_contact_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (chatContact != null) {
      data['chat_contact'] = chatContact!.map((v) => v.toJson()).toList();
    }
    data['chat_contact_count'] = chatContactCount;
    return data;
  }
}

class ChatContact {
  String? employeeName;
  int? employeeId;
  String? employeeNumber;
  String? phoneNumber;
  String? email;
  String? departmentName;
  String? designation;
  String? avatar;

  ChatContact(
      {this.employeeName,
      this.employeeId,
      this.employeeNumber,
      this.phoneNumber,
      this.email,
      this.departmentName,
      this.designation,
      this.avatar});

  ChatContact.fromJson(Map<String, dynamic> json) {
    employeeName = json['employee_name'];
    employeeId = json['employee_id'];
    employeeNumber = json['employee_number'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    departmentName = json['department_name'];
    designation = json['designation'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['employee_name'] = employeeName;
    data['employee_id'] = employeeId;
    data['employee_number'] = employeeNumber;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['department_name'] = departmentName;
    data['designation'] = designation;
    data['avatar'] = avatar;
    return data;
  }
}
