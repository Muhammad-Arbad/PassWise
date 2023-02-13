
class AddVisitorModel {
  String? name;
  String? phoneNo;
  String? cnic;
  String? reason;
  String? qrcode;
  String? date;
  String? image;

  AddVisitorModel(
      {this.name,
        this.phoneNo,
        this.cnic,
        this.reason,
        this.qrcode,
        this.date,
      this.image});

  AddVisitorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNo = json['phone_no'];
    cnic = json['cnic'];
    reason = json['reason'];
    qrcode = json['qrcode'];
    date = json['date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {

    print(this.name);
    print(this.phoneNo);
    print(this.cnic);
    print(this.reason);
    print(this.qrcode);
    print(this.date);
    print(this.image);
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['cnic'] = this.cnic;
    data['reason'] = this.reason;
    data['qrcode'] = this.qrcode;
    data['date'] = this.date;
    data['image'] = this.image;
    return data;
  }
}