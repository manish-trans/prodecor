class PromoterLeadDetails{
  String success;
  String responseMsg;
  List<Leads> leads;
  String totalRecords;
  String leadsPopupText;
  String totalLeads;
  String totalLeadsLabel;
  String convertedLeads;
  String convertedLeadsLabel;
  List<JoiningStatus> joiningStatus;
  String joiningStatusLabel;
  String joiningIdLabel;
  String joiningRemarksLabel;
  String newLeads;
  String newLeadsText;
  String newLeadsRemarks;

  PromoterLeadDetails(
      {this.success,
        this.responseMsg,
        this.leads,
        this.totalRecords,
        this.leadsPopupText,
        this.totalLeads,
        this.totalLeadsLabel,
        this.convertedLeads,
        this.convertedLeadsLabel,
        this.joiningStatus,
        this.joiningStatusLabel,
        this.joiningIdLabel,
        this.joiningRemarksLabel,
        this.newLeads,
        this.newLeadsText,
        this.newLeadsRemarks});

  PromoterLeadDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    responseMsg = json['response_msg'];
    if (json['leads'] != null) {
      leads = new List<Leads>();
      json['leads'].forEach((v) {
        leads.add(new Leads.fromJson(v));
      });
    }
    totalRecords = json['total_records'];
    leadsPopupText = json['leads_popup_text'];
    totalLeads = json['total_leads'];
    totalLeadsLabel = json['total_leads_label'];
    convertedLeads = json['converted_leads'];
    convertedLeadsLabel = json['converted_leads_label'];
    if (json['joining_status'] != null) {
      joiningStatus = new List<JoiningStatus>();
      json['joining_status'].forEach((v) {
        joiningStatus.add(new JoiningStatus.fromJson(v));
      });
    }
    joiningStatusLabel = json['joining_status_label'];
    joiningIdLabel = json['joining_id_label'];
    joiningRemarksLabel = json['joining_remarks_label'];
    newLeads = json['new_leads'];
    newLeadsText = json['new_leads_text'];
    newLeadsRemarks = json['new_leads_remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['response_msg'] = this.responseMsg;
    if (this.leads != null) {
      data['leads'] = this.leads.map((v) => v.toJson()).toList();
    }
    data['total_records'] = this.totalRecords;
    data['leads_popup_text'] = this.leadsPopupText;
    data['total_leads'] = this.totalLeads;
    data['total_leads_label'] = this.totalLeadsLabel;
    data['converted_leads'] = this.convertedLeads;
    data['converted_leads_label'] = this.convertedLeadsLabel;
    if (this.joiningStatus != null) {
      data['joining_status'] =
          this.joiningStatus.map((v) => v.toJson()).toList();
    }
    data['joining_status_label'] = this.joiningStatusLabel;
    data['joining_id_label'] = this.joiningIdLabel;
    data['joining_remarks_label'] = this.joiningRemarksLabel;
    data['new_leads'] = this.newLeads;
    data['new_leads_text'] = this.newLeadsText;
    data['new_leads_remarks'] = this.newLeadsRemarks;
    return data;
  }
}

class Leads {
  String leadId;
  String leadTitle;
  String leadReadFlag;
  String leadReadCanSubmit;
  String leadMobile;
  String callbackBtn;
  List<LeadDetails> leadDetails;

  Leads(
      {this.leadId,
        this.leadTitle,
        this.leadReadFlag,
        this.leadReadCanSubmit,
        this.leadMobile,
        this.callbackBtn,
        this.leadDetails});

  Leads.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    leadTitle = json['lead_title'];
    leadReadFlag = json['lead_read_flag'];
    leadReadCanSubmit = json['lead_read_can_submit'];
    leadMobile = json['lead_mobile'];
    callbackBtn = json['callback_btn'];
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
    data['lead_read_flag'] = this.leadReadFlag;
    data['lead_read_can_submit'] = this.leadReadCanSubmit;
    data['lead_mobile'] = this.leadMobile;
    data['callback_btn'] = this.callbackBtn;
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

class JoiningStatus {
  String statusId;
  String statusText;

  JoiningStatus({this.statusId, this.statusText});

  JoiningStatus.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    statusText = json['status_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['status_text'] = this.statusText;
    return data;
  }
}
