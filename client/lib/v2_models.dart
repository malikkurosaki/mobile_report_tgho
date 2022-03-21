class V2ModelConfig {
  String? url;
  String? urlDev;
  bool? dev;
  bool? isDebug;

  V2ModelConfig({url, urlDev, dev, isDebug});

  V2ModelConfig.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    urlDev = json['urlDev'];
    dev = json['dev'];
    isDebug = json['isDebug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['urlDev'] = urlDev;
    data['dev'] = dev;
    data['isDebug'] = isDebug;
    return data;
  }
}


class V2ModelFood {
  String? net;
  String? gtotal;
  String? total;
  int? bill;
  int? compliTotal;
  int? compliLength;

  V2ModelFood(
      {net,
      gtotal,
      total,
      bill,
      compliTotal,
      compliLength});

  V2ModelFood.fromJson(Map<String, dynamic> json) {
    net = json['net'];
    gtotal = json['gtotal'];
    total = json['total'];
    bill = json['bill'];
    compliTotal = json['compliTotal'];
    compliLength = json['compliLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['net'] = net;
    data['gtotal'] = gtotal;
    data['total'] = total;
    data['bill'] = bill;
    data['compliTotal'] = compliTotal;
    data['compliLength'] = compliLength;
    return data;
  }
}


class V2ModelOut {
  String? kodeOut;
  String? namaOut;

  V2ModelOut({kodeOut, namaOut});

  V2ModelOut.fromJson(Map<String, dynamic> json) {
    kodeOut = json['kode_out'];
    namaOut = json['nama_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['kode_out'] = kodeOut;
    data['nama_out'] = namaOut;
    return data;
  }
}


class V2ModelDep {
  String? namaDept;
  String? unitBisnis;

  V2ModelDep({namaDept, unitBisnis});

  V2ModelDep.fromJson(Map<String, dynamic> json) {
    namaDept = json['nama_dept'];
    unitBisnis = json['unit_bisnis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_dept'] = namaDept;
    data['unit_bisnis'] = unitBisnis;
    return data;
  }
}

class V2ModelUser {
  dynamic id;
  String? name;
  String? email;
  String? password;

  V2ModelUser({id, name, email, password});

  V2ModelUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}


class V2ModelTotalRevenue {
  String? gtotal;
  String? total;
  String? net;

  V2ModelTotalRevenue({gtotal, total, net});

  V2ModelTotalRevenue.fromJson(Map<String, dynamic> json) {
    gtotal = json['gtotal'];
    total = json['total'];
    net = json['net'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gtotal'] = gtotal;
    data['total'] = total;
    data['net'] = net;
    return data;
  }
}

class V2ModelTop10 {
  String? id;
  int? qty;

  V2ModelTop10({this.id, this.qty});

  V2ModelTop10.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['qty'] = this.qty;
    return data;
  }
}




