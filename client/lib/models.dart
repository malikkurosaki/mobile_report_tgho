class ModelDashboard {
  List<Penjualan>? penjualan;
  Revenue? revenue;
  Avarage? avarage;
  Compliment? compliment;

  ModelDashboard({penjualan, revenue, avarage, compliment});

  ModelDashboard.fromJson(Map<String, dynamic> json) {
    if (json['penjualan'] != null) {
      penjualan = <Penjualan>[];
      json['penjualan'].forEach((v) {
        penjualan!.add(Penjualan.fromJson(v));
      });
    }
    revenue =
        json['revenue'] != null ? Revenue.fromJson(json['revenue']) : null;
    avarage =
        json['avarage'] != null ?  Avarage.fromJson(json['avarage']) : null;
    compliment = json['compliment'] != null
        ?  Compliment.fromJson(json['compliment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (penjualan != null) {
      data['penjualan'] = penjualan!.map((v) => v.toJson()).toList();
    }
    if (revenue != null) {
      data['revenue'] = revenue!.toJson();
    }
    if (avarage != null) {
      data['avarage'] = avarage!.toJson();
    }
    if (compliment != null) {
      data['compliment'] = compliment!.toJson();
    }
    return data;
  }
}

class Penjualan {
  String? group;
  String? total;
  String? net;
  int? prosentase;

  Penjualan({group, total, net, prosentase});

  Penjualan.fromJson(Map<String, dynamic> json) {
    group = json['group'];
    total = json['total'];
    net = json['net'];
    prosentase = json['prosentase'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['group'] = group;
    data['total'] = total;
    data['net'] = net;
    data['prosentase'] = prosentase;
    return data;
  }
}

class Revenue {
  String? gross;
  String? net;
  String? pax;
  int? bill;

  Revenue({gross, net, pax, bill});

  Revenue.fromJson(Map<String, dynamic> json) {
    gross = json['gross'];
    net = json['net'];
    pax = json['pax'];
    bill = json['bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['gross'] = gross;
    data['net'] = net;
    data['pax'] = pax;
    data['bill'] = bill;
    return data;
  }
}

class Avarage {
  String? net;
  String? gross;

  Avarage({net, gross});

  Avarage.fromJson(Map<String, dynamic> json) {
    net = json['net'];
    gross = json['gross'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['net'] = net;
    data['gross'] = gross;
    return data;
  }
}

class Compliment {
  int? total;
  String? pax;
  int? totalBill;

  Compliment({total, pax, totalBill});

  Compliment.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pax = json['pax'];
    totalBill = json['totalBill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['total'] = total;
    data['pax'] = pax;
    data['totalBill'] = totalBill;
    return data;
  }
}


class ModelOut {
  String? kodeOut;
  String? namaOut;

  ModelOut({kodeOut, namaOut});

  ModelOut.fromJson(Map<String, dynamic> json) {
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


class ModelDep {
  String? namaDept;
  String? unitBisnis;

  ModelDep({namaDept, unitBisnis});

  ModelDep.fromJson(Map<String, dynamic> json) {
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

class ModelDashboardV2 {
  String? name;
  Data? data;

  ModelDashboardV2({name, data});

  ModelDashboardV2.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data2 = <String, dynamic>{};
    data2['name'] = name;
    if (data != null) {
      data2['data'] = data!.toJson();
    }
    return data2;
  }
}

class Data {
  Sum? sSum;
  Sum? sAvg;
  Count? cCount;

  Data({sSum, sAvg, cCount});

  Data.fromJson(Map<String, dynamic> json) {
    sSum = json['_sum'] != null ? Sum.fromJson(json['_sum']) : null;
    sAvg = json['_avg'] != null ? Sum.fromJson(json['_avg']) : null;
    cCount = json['_count'] != null ? Count.fromJson(json['_count']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sSum != null) {
      data['_sum'] = sSum!.toJson();
    }
    if (sAvg != null) {
      data['_avg'] = sAvg!.toJson();
    }
    if (cCount != null) {
      data['_count'] = cCount!.toJson();
    }
    return data;
  }
}

class Sum {
  String? total;
  String? pax;
  String? net;
  String? taxrp;
  String? serrp;
  String? gtotal;
  String? cash;

  Sum(
      {total,
      pax,
      net,
      taxrp,
      serrp,
      gtotal,
      cash});

  Sum.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pax = json['pax'];
    net = json['net'];
    taxrp = json['taxrp'];
    serrp = json['serrp'];
    gtotal = json['gtotal'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pax'] = pax;
    data['net'] = net;
    data['taxrp'] = taxrp;
    data['serrp'] = serrp;
    data['gtotal'] = gtotal;
    data['cash'] = cash;
    return data;
  }
}

class Count {
  int? total;
  int? pax;
  int? net;
  int? taxrp;
  int? serrp;
  int? gtotal;
  int? cash;

  Count(
      {total,
      pax,
      net,
      taxrp,
      serrp,
      gtotal,
      cash});

  Count.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    pax = json['pax'];
    net = json['net'];
    taxrp = json['taxrp'];
    serrp = json['serrp'];
    gtotal = json['gtotal'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['pax'] = pax;
    data['net'] = net;
    data['taxrp'] = taxrp;
    data['serrp'] = serrp;
    data['gtotal'] = gtotal;
    data['cash'] = cash;
    return data;
  }
}


class ModelConfig {
  String? url;
  String? urlDev;
  bool? dev;

  ModelConfig({url, urlDev, dev});

  ModelConfig.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    urlDev = json['urlDev'];
    dev = json['dev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['urlDev'] = urlDev;
    data['dev'] = dev;
    return data;
  }
}

class ModelTotalrevenue {
  String? net;
  String? gross;
  String? total;
  String? pax;
  int? bill;

  ModelTotalrevenue({net, gross, total, pax, bill});

  ModelTotalrevenue.fromJson(Map<String, dynamic> json) {
    net = json['net'];
    gross = json['gross'];
    total = json['total'];
    pax = json['pax'];
    bill = json['bill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['net'] = net;
    data['gross'] = gross;
    data['total'] = total;
    data['pax'] = pax;
    data['bill'] = bill;
    return data;
  }
}


class ModelAverageBillPax {
  String? net;
  String? gtotal;
  String? total;

  ModelAverageBillPax({net, gtotal, total});

  ModelAverageBillPax.fromJson(Map<String, dynamic> json) {
    net = json['net'];
    gtotal = json['gtotal'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['net'] = net;
    data['gtotal'] = gtotal;
    data['total'] = total;
    return data;
  }
}

class ModelComplimetGross {
  int? food;
  int? beverage;

  ModelComplimetGross({food, beverage});

  ModelComplimetGross.fromJson(Map<String, dynamic> json) {
    food = json['food'];
    beverage = json['beverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['food'] = food;
    data['beverage'] = beverage;
    return data;
  }
}

class ModelSalesPerformance {
  int? bulan;
  int? net;

  ModelSalesPerformance({bulan, net});

  ModelSalesPerformance.fromJson(Map<String, dynamic> json) {
    bulan = json['bulan'];
    net = json['net'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['bulan'] = bulan;
    data['net'] = net;
    return data;
  }
}


class ModelSalesAvarage {
  int? bulan;
  double? net;

  ModelSalesAvarage({bulan, net});

  ModelSalesAvarage.fromJson(Map<String, dynamic> json) {
    bulan = json['bulan'];
    net = json['net'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =<String, dynamic>{};
    data['bulan'] = bulan;
    data['net'] = net;
    return data;
  }
}

class V2ModelSalesPerformanceWeek {
  List<Food>? food;
  List<Food>? beverage;
  List<Food>? other;

  V2ModelSalesPerformanceWeek({food, beverage, other});

  V2ModelSalesPerformanceWeek.fromJson(Map<String, dynamic> json) {
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(Food.fromJson(v));
      });
    }
    if (json['beverage'] != null) {
      beverage = <Food>[];
      json['beverage'].forEach((v) {
        beverage!.add(Food.fromJson(v));
      });
    }
    if (json['other'] != null) {
      other = <Food>[];
      json['other'].forEach((v) {
        other!.add(Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (food != null) {
      data['food'] = food!.map((v) => v.toJson()).toList();
    }
    if (beverage != null) {
      data['beverage'] = beverage!.map((v) => v.toJson()).toList();
    }
    if (other != null) {
      data['other'] = other!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Food {
  String? gtotal;
  String? net;
  String? total;
  String? tanggal;

  Food({gtotal, net, total, tanggal});

  Food.fromJson(Map<String, dynamic> json) {
    gtotal = json['gtotal'];
    net = json['net'];
    total = json['total'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gtotal'] = gtotal;
    data['net'] = net;
    data['total'] = total;
    data['tanggal'] = tanggal;
    return data;
  }
}






