class ProfileModel {
  bool? success;
  String? roleId;
  String? factoryName;
  String? name;
  String? fathername;
  String? code;
  String? reportingName;
  String? reportingCode;
  String? reportingPhone;
  String? culturablearea;
  String? canearea;
  String? phonenumber;
  int? count;
  int? villagecount;
  int? id;
  String? aadhar;
  String? bankAccount;
  List<Zonal>? zonal;
  String? address;
  List<Plot>? plot;
  List<Centar>? centar;

  ProfileModel(
      {this.success,
      this.roleId,
      this.factoryName,
      this.name,
      this.code,
      this.reportingName,
      this.reportingCode,
      this.reportingPhone,
      this.culturablearea,
      this.canearea,
      this.phonenumber,
      this.count,
      this.villagecount,
      this.id,
      this.aadhar,
      this.bankAccount,
      this.zonal,
      this.address,
      this.plot,
      this.centar,
      this.fathername});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    roleId = json['role_id'];
    factoryName = json['factoryname'];
    name = json['name'];
    aadhar = json['aadhar_number'];
    bankAccount = json['account_number'];
    fathername = json['fathername'];
    code = json['code'];
    reportingName = json['reporting_name'];
    reportingCode = json['reporting_code'];
    reportingPhone = json['reporting_phone'];
    culturablearea = json['culturablearea'];
    canearea = json['canearea'];
    phonenumber = json['phonenumber'];
    count = json['count'];
    villagecount = json['villagecount'];
    id = json['id'];
    if (json['zonal'] != null) {
      zonal = <Zonal>[];
      json['zonal'].forEach((v) {
        zonal!.add(new Zonal.fromJson(v));
      });
    }
    address = json['address'];
    if (json['plot'] != null) {
      plot = <Plot>[];
      json['plot'].forEach((v) {
        plot!.add(new Plot.fromJson(v));
      });
    }
    if (json['centar'] != null) {
      centar = <Centar>[];
      json['centar'].forEach((v) {
        centar!.add(new Centar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['role_id'] = this.roleId;
    data['factoryname'] = this.factoryName;
    data['name'] = this.name;
    data['fathername'] = this.fathername;
    data['code'] = this.code;
    data['reporting_name'] = this.reportingName;
    data['reporting_code'] = this.reportingCode;
    data['reporting_phone'] = this.reportingPhone;
    data['culturablearea'] = this.culturablearea;
    data['canearea'] = this.canearea;
    data['phonenumber'] = this.phonenumber;
    data['count'] = this.count;
    data['villagecount'] = this.villagecount;
    data['id'] = this.id;
    if (this.zonal != null) {
      data['zonal'] = this.zonal!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    if (this.plot != null) {
      data['plot'] = this.plot!.map((v) => v.toJson()).toList();
    }
    if (this.centar != null) {
      data['centar'] = this.centar!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Zonal {
  String? statename;
  String? districtname;
  String? villagename;

  Zonal({this.statename, this.districtname, this.villagename});

  Zonal.fromJson(Map<String, dynamic> json) {
    statename = json['statename'];
    districtname = json['districtname'];
    villagename = json['villagename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statename'] = this.statename;
    data['districtname'] = this.districtname;
    data['villagename'] = this.villagename;
    return data;
  }
}

class Plot {
  int? plotid;
  String? cfaName;
  String? cfaCode;
  String? cfaPhone;
  String? stateName;
  String? districtName;
  String? villageName;
  String? caneArea;
  String? cropType;
  String? caneVariety;
  String? startDate;
  String? delete_btn;
  String? delete_type;
  String? harvesting;
  String? estimated;
  int? share;

  Plot(
      {this.plotid,
      this.harvesting,
      this.estimated,
      this.share,
      this.cfaName,
      this.cfaCode,
      this.cfaPhone,
      this.stateName,
      this.districtName,
      this.villageName,
      this.caneArea,
      this.cropType,
      this.caneVariety,
      this.delete_btn,
      this.delete_type,
      this.startDate});

  Plot.fromJson(Map<String, dynamic> json) {
    plotid = json['plotid'];
    cfaName = json['cfa_name'];
    cfaCode = json['cfa_code'];
    share = json['plot_share'];
    estimated = json['estimated_yield'];
    harvesting = json['harvesting_date'];
    cfaPhone = json['cfa_phone'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    villageName = json['village_name'];
    caneArea = json['cane_area'];
    cropType = json['crop_type'];
    caneVariety = json['cane_variety'];
    startDate = json['start_date'];
    delete_btn = json['delete_btn'];
    delete_type = json['delete_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plotid'] = this.plotid;
    data['cfa_name'] = this.cfaName;
    data['cfa_code'] = this.cfaCode;
    data['cfa_phone'] = this.cfaPhone;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['village_name'] = this.villageName;
    data['cane_area'] = this.caneArea;
    data['crop_type'] = this.cropType;
    data['cane_variety'] = this.caneVariety;
    data['start_date'] = this.startDate;
    return data;
  }
}

class Centar {
  String? centre;
  String? society;
  String? village;
  String? villagecode;
  String? district;

  Centar({this.centre, this.society, this.village, this.district});

  Centar.fromJson(Map<String, dynamic> json) {
    centre = json['centre'];
    society = json['society'];
    village = json['village'];
    villagecode = json['villagecode'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['centre'] = this.centre;
    data['society'] = this.society;
    data['village'] = this.village;
    data['villagecode'] = this.villagecode;
    data['district'] = this.district;
    return data;
  }
}
