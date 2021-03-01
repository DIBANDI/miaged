class ProfilModel {
  String loginprofil;
  String emailprofil;
  String phoneNumberprofil;
  String cityprofil;
  String stateprofil;
  String pincodeprofil;
  String dateprofil;

  ProfilModel(
      {this.loginprofil,
      this.emailprofil,
      this.phoneNumberprofil,
      this.cityprofil,
      this.stateprofil,
      this.pincodeprofil,
      this.dateprofil});

  ProfilModel.fromJson(Map<String, dynamic> json) {
    loginprofil = json['loginprofil'];
    emailprofil = json['emailprofil'];
    phoneNumberprofil = json['phoneNumberprofil'];
    cityprofil = json['cityprofil '];
    stateprofil = json['stateprofil'];
    pincodeprofil = json['pincodeprofil'];
    dateprofil = json['dateprofil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loginprofil'] = this.loginprofil;
    data['emailprofil'] = this.emailprofil;
    data['phoneNumberprofil'] = this.phoneNumberprofil;
    data['cityprofil'] = this.cityprofil;
    data['stateprofil'] = this.stateprofil;
    data['pincodeprofil'] = this.pincodeprofil;
    data['dateprofil'] = this.dateprofil;
    return data;
  }
}
