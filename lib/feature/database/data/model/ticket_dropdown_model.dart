import 'package:ifive_hrms/core/core.dart';

class TicketDropdownModel {
  List<CommonList>? dbsource;
  List<CommonList>? industry;
  List<CommonList>? segment;
  List<CommonList>? vertical;
  List<CommonList>? subVertical;

  List<CommonList>? product;
  List<CommonList>? stage;
  List<CommonList>? meetingOutcome;
  List<CommonList>? employeeList;
  List<CommonList>? callStatus;
  List<CommonList>? callResponse;
  List<CommonList>? priority;
  List<CommonList>? nextAction;
  List<CommonList>? supportRequired;
  List<CommonList>? dbStatus;

  List<CommonList>? status;
  List<CommonList>? winningProb;

  TicketDropdownModel(
      {this.dbsource,
      this.industry,
      this.segment,
      this.vertical,
      this.subVertical,
      this.product,
      this.stage,
      this.meetingOutcome,
      this.employeeList,
      this.callStatus,
      this.callResponse,
      this.priority,
      this.nextAction,
      this.supportRequired,
      this.dbStatus,
      this.status,
      this.winningProb});

  TicketDropdownModel.fromJson(Map<String, dynamic> json) {
    if (json['dbsource'] != null) {
      dbsource = <CommonList>[];
      json['dbsource'].forEach((v) {
        dbsource!.add(CommonList.fromJson(v));
      });
    }
    if (json['industry'] != null) {
      industry = <CommonList>[];
      json['industry'].forEach((v) {
        industry!.add(CommonList.fromJson(v));
      });
    }
    if (json['segment'] != null) {
      segment = <CommonList>[];
      json['segment'].forEach((v) {
        segment!.add(CommonList.fromJson(v));
      });
    }
    if (json['vertical'] != null) {
      vertical = <CommonList>[];
      json['vertical'].forEach((v) {
        vertical!.add(CommonList.fromJson(v));
      });
    }
    if (json['sub_vertical'] != null) {
      subVertical = <CommonList>[];
      json['sub_vertical'].forEach((v) {
        subVertical!.add(CommonList.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = <CommonList>[];
      json['product'].forEach((v) {
        product!.add(CommonList.fromJson(v));
      });
    }
    if (json['stage'] != null) {
      stage = <CommonList>[];
      json['stage'].forEach((v) {
        stage!.add(CommonList.fromJson(v));
      });
    }
    if (json['meeting_outcome'] != null) {
      meetingOutcome = <CommonList>[];
      json['meeting_outcome'].forEach((v) {
        meetingOutcome!.add(CommonList.fromJson(v));
      });
    }
    if (json['employee_list'] != null) {
      employeeList = <CommonList>[];
      json['employee_list'].forEach((v) {
        employeeList!.add(CommonList.fromJson(v));
      });
    }
    if (json['call_status'] != null) {
      callStatus = <CommonList>[];
      json['call_status'].forEach((v) {
        callStatus!.add(CommonList.fromJson(v));
      });
    }
    if (json['call_response'] != null) {
      callResponse = <CommonList>[];
      json['call_response'].forEach((v) {
        callResponse!.add(CommonList.fromJson(v));
      });
    }
    if (json['priority'] != null) {
      priority = <CommonList>[];
      json['priority'].forEach((v) {
        priority!.add(CommonList.fromJson(v));
      });
    }
    if (json['next_action'] != null) {
      nextAction = <CommonList>[];
      json['next_action'].forEach((v) {
        nextAction!.add(CommonList.fromJson(v));
      });
    }
    if (json['support_required'] != null) {
      supportRequired = <CommonList>[];
      json['support_required'].forEach((v) {
        supportRequired!.add(CommonList.fromJson(v));
      });
    }
    if (json['db_status'] != null) {
      dbStatus = <CommonList>[];
      json['db_status'].forEach((v) {
        dbStatus!.add(CommonList.fromJson(v));
      });
    }
    if (json['status'] != null) {
      status = <CommonList>[];
      json['status'].forEach((v) {
        status!.add(CommonList.fromJson(v));
      });
    }
    if (json['winning_prob'] != null) {
      winningProb = <CommonList>[];
      json['winning_prob'].forEach((v) {
        winningProb!.add(CommonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dbsource != null) {
      data['dbsource'] = dbsource!.map((v) => v.toJson()).toList();
    }
    if (industry != null) {
      data['industry'] = industry!.map((v) => v.toJson()).toList();
    }
    if (segment != null) {
      data['segment'] = segment!.map((v) => v.toJson()).toList();
    }
    if (vertical != null) {
      data['vertical'] = vertical!.map((v) => v.toJson()).toList();
    }
    if (subVertical != null) {
      data['sub_vertical'] = subVertical!.map((v) => v.toJson()).toList();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    if (stage != null) {
      data['stage'] = stage!.map((v) => v.toJson()).toList();
    }
    if (meetingOutcome != null) {
      data['meeting_outcome'] = meetingOutcome!.map((v) => v.toJson()).toList();
    }
    if (employeeList != null) {
      data['employee_list'] = employeeList!.map((v) => v.toJson()).toList();
    }
    if (callStatus != null) {
      data['call_status'] = callStatus!.map((v) => v.toJson()).toList();
    }
    if (callResponse != null) {
      data['call_response'] = callResponse!.map((v) => v.toJson()).toList();
    }
    if (priority != null) {
      data['priority'] = priority!.map((v) => v.toJson()).toList();
    }
    if (nextAction != null) {
      data['next_action'] = nextAction!.map((v) => v.toJson()).toList();
    }
    if (supportRequired != null) {
      data['support_required'] =
          supportRequired!.map((v) => v.toJson()).toList();
    }
    if (dbStatus != null) {
      data['db_status'] = dbStatus!.map((v) => v.toJson()).toList();
    }
    if (status != null) {
      data['status'] = status!.map((v) => v.toJson()).toList();
    }
    if (winningProb != null) {
      data['winning_prob'] = winningProb!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
