
class VisitorsDetailModel {

  String? sId;
  String? name;
  String? phoneNo;
  String? cId;
  String? cnic;
  String? reason;
  String? qrcode;
  String? date;
  int? iV;

  VisitorsDetailModel(
      {this.sId,
        this.name,
        this.phoneNo,
        this.cId,
        this.cnic,
        this.reason,
        this.qrcode,
        this.date,
        this.iV});

  VisitorsDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    phoneNo = json['phone_no'];
    cId = json['c_id'];
    cnic = json['cnic'];
    reason = json['reason'];
    qrcode = json['qrcode'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['c_id'] = this.cId;
    data['cnic'] = this.cnic;
    data['reason'] = this.reason;
    data['qrcode'] = this.qrcode;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}