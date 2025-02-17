class CommonList {
  int? id;
  String? name;

  CommonList({this.id, this.name});

  CommonList.fromJson(Map<String, dynamic> json) {
    if (json['leave_type'] != null) {
      id = json['leave_type_id'];
      name = json['leave_type'];
    }
    if (json['first_name'] != null) {
      id = json['employee_id'];
      name = json['first_name'];
    }
    if (json['permission_type'] != null) {
      id = json['permission_type_id'];
      name = json['permission_type'];
    }
    if (json['shift_name'] != null) {
      id = json['shift_id'];
      name = json['shift_name'];
    }
    if (json['lookup_meaning'] != null) {
      id = json['lookuplines_id'];
      name = json['lookup_meaning'];
    }
    if (json['country_name'] != null) {
      id = json['country_id'];
      name = json['country_name'];
    }
    if (json['state_name'] != null) {
      id = json['state_id'];
      name = json['state_name'];
    }
    if (json['city_name'] != null) {
      id = json['city_id'];
      name = json['city_name'];
    }
    if (json['project_name'] != null) {
      id = json['project_id'];
      name = json['project_name'];
    }
    if (json['employee_name'] != null) {
      id = json['id'];
      name = json['employee_name'];
    }
    if (json['employee_name'] != null) {
      id = json['employee_id'];
      name = json['employee_name'];
    }
    if (json['s_lead_source_name'] != null) {
      id = json['s_lead_source_id'];
      name = json['s_lead_source_name'];
    }
    if (json['s_lead_industry_name'] != null) {
      id = json['s_lead_industry_id'];
      name = json['s_lead_industry_name'];
    }
    if (json['s_lead_segment_name'] != null) {
      id = json['s_lead_segment_id'];
      name = json['s_lead_segment_name'];
    }
    if (json['s_lead_vertical_name'] != null) {
      id = json['s_lead_vertical_id'];
      name = json['s_lead_vertical_name'];
    }
    if (json['s_lead_sub_vertical_name'] != null) {
      id = json['s_lead_sub_vertical_id'];
      name = json['s_lead_sub_vertical_name'];
    }
    if (json['product_name'] != null) {
      id = json['product_id'];
      name = json['product_name'];
    }
    if (json['s_lead_stage_name'] != null) {
      id = json['s_lead_stage_id'];
      name = json['s_lead_stage_name'];
    }
    if (json['s_lead_outcome_name'] != null) {
      id = json['s_lead_outcome_id'];
      name = json['s_lead_outcome_name'];
    }
    if (json['call_status_name'] != null) {
      id = json['call_status_id'];
      name = json['call_status_name'];
    }
    if (json['call_response_name'] != null) {
      id = json['call_response_id'];
      name = json['call_response_name'];
    }
    if (json['priority_name'] != null) {
      id = json['priority_id'];
      name = json['priority_name'];
    }
    if (json['next_action_name'] != null) {
      id = json['next_action_id'];
      name = json['next_action_name'];
    }
    if (json['support_required_name'] != null) {
      id = json['support_required_id'];
      name = json['support_required_name'];
    }
    if (json['db_status_name'] != null) {
      id = json['db_status_id'];
      name = json['db_status_name'];
    }
    if (json['status_name'] != null) {
      id = json['status_id'];
      name = json['status_name'];
    }
    if (json['winning_prob_name'] != null) {
      id = json['winning_prob_id'];
      name = json['winning_prob_name'];
    }
    if (json['department_name'] != null) {
      id = json['department_id'];
      name = json['department_name'];
    }
    if (json['task_type_name'] != null) {
      id = json['task_type_id'];
      name = json['task_type_name'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
