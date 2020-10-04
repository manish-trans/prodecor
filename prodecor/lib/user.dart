class User {
  String success;
  String responseMsg;
  UserData userData;
  int projectionsMenu;
  int scheduleApprovalMenu;
  int scheduleReportMenu;

  User(
      {this.success,
        this.responseMsg,
        this.userData,
        this.projectionsMenu,
        this.scheduleApprovalMenu,
        this.scheduleReportMenu});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseMsg = json['response_msg'];
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    projectionsMenu = json['projections_menu'];
    scheduleApprovalMenu = json['schedule_approval_menu'];
    scheduleReportMenu = json['schedule_report_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['response_msg'] = this.responseMsg;
    if (this.userData != null) {
      data['user_data'] = this.userData.toJson();
    }
    data['projections_menu'] = this.projectionsMenu;
    data['schedule_approval_menu'] = this.scheduleApprovalMenu;
    data['schedule_report_menu'] = this.scheduleReportMenu;
    return data;
  }
}

class UserData {
  String loginId;
  String userName;
  String authTocken;
  String userPic;

  UserData({this.loginId, this.userName, this.authTocken, this.userPic});

  UserData.fromJson(Map<String, dynamic> json) {
    loginId = json['login_id'];
    userName = json['user_name'];
    authTocken = json['auth_tocken'];
    userPic = json['user_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login_id'] = this.loginId;
    data['user_name'] = this.userName;
    data['auth_tocken'] = this.authTocken;
    data['user_pic'] = this.userPic;
    return data;
  }
}
