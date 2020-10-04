class leaddetailsmodel {
  String success;
  String responseMsg;
  String leadStatusLabel;
  String leadRemarksLabel;
  String leadSubmitLabel;
  String leadCallDateLabel;
  String leadCallTimeLabel;
  String leadFormTitle;
  String leadCurrentStatus;
  List<LeadStatus> leadStatus;
  LeadData leadData;
  String callBackCount;
  int callBackAlertShow;
  String callBackAlertText;

  leaddetailsmodel(
      {this.success,
        this.responseMsg,
        this.leadStatusLabel,
        this.leadRemarksLabel,
        this.leadSubmitLabel,
        this.leadCallDateLabel,
        this.leadCallTimeLabel,
        this.leadFormTitle,
        this.leadCurrentStatus,
        this.leadStatus,
        this.leadData,
        this.callBackCount,
        this.callBackAlertShow,
        this.callBackAlertText});

  leaddetailsmodel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseMsg = json['response_msg'];
    leadStatusLabel = json['lead_status_label'];
    leadRemarksLabel = json['lead_remarks_label'];
    leadSubmitLabel = json['lead_submit_label'];
    leadCallDateLabel = json['lead_call_date_label'];
    leadCallTimeLabel = json['lead_call_time_label'];
    leadFormTitle = json['lead_form_title'];
    leadCurrentStatus = json['lead_current_status'];
    if (json['lead_status'] != null) {
      leadStatus = new List<LeadStatus>();
      json['lead_status'].forEach((v) {
        leadStatus.add(new LeadStatus.fromJson(v));
      });
    }
    leadData = json['lead_data'] != null
        ? new LeadData.fromJson(json['lead_data'])
        : null;
    callBackCount = json['call_back_count'];
    callBackAlertShow = json['call_back_alert_show'];
    callBackAlertText = json['call_back_alert_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['response_msg'] = this.responseMsg;
    data['lead_status_label'] = this.leadStatusLabel;
    data['lead_remarks_label'] = this.leadRemarksLabel;
    data['lead_submit_label'] = this.leadSubmitLabel;
    data['lead_call_date_label'] = this.leadCallDateLabel;
    data['lead_call_time_label'] = this.leadCallTimeLabel;
    data['lead_form_title'] = this.leadFormTitle;
    data['lead_current_status'] = this.leadCurrentStatus;
    if (this.leadStatus != null) {
      data['lead_status'] = this.leadStatus.map((v) => v.toJson()).toList();
    }
    if (this.leadData != null) {
      data['lead_data'] = this.leadData.toJson();
    }
    data['call_back_count'] = this.callBackCount;
    data['call_back_alert_show'] = this.callBackAlertShow;
    data['call_back_alert_text'] = this.callBackAlertText;
    return data;
  }
}

class LeadStatus {
  String id;
  String name;

  LeadStatus({this.id, this.name});

  LeadStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class LeadData {
  String leadId;
  String leadTitle;
  List<LeadDetails> leadDetails;

  LeadData({this.leadId, this.leadTitle, this.leadDetails});

  LeadData.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    leadTitle = json['lead_title'];
    if (json['lead_details'] != null) {
      leadDetails = new List<LeadDetails>();
      json['lead_details'].forEach((v) {
        leadDetails.add(new LeadDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_id'] = this.leadId;
    data['lead_title'] = this.leadTitle;
    if (this.leadDetails != null) {
      data['lead_details'] = this.leadDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadDetails {
  String leadLabel;
  String leadValue;

  LeadDetails({this.leadLabel, this.leadValue});

  LeadDetails.fromJson(Map<String, dynamic> json) {
    leadLabel = json['lead_label'];
    leadValue = json['lead_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lead_label'] = this.leadLabel;
    data['lead_value'] = this.leadValue;
    return data;
  }
}
