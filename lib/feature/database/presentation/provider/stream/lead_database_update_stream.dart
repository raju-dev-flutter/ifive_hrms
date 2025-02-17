import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/core/core.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../feature.dart';

class LeadDatabaseUpdateStream {
  LeadDatabaseUpdateStream(
      {required TicketDropdownUseCase ticketDropdownUseCase,
      required IndustryBasedVerticalDropdownUseCase
          industryBasedVerticalDropdownUseCase,
      required VerticalBasedSubVerticalDropdownUseCase
          verticalBasedSubVerticalDropdownUseCase})
      : _ticketDropdownUseCase = ticketDropdownUseCase,
        _industryBasedVerticalDropdownUseCase =
            industryBasedVerticalDropdownUseCase,
        _verticalBasedSubVerticalDropdownUseCase =
            verticalBasedSubVerticalDropdownUseCase;

  final TicketDropdownUseCase _ticketDropdownUseCase;
  final IndustryBasedVerticalDropdownUseCase
      _industryBasedVerticalDropdownUseCase;
  final VerticalBasedSubVerticalDropdownUseCase
      _verticalBasedSubVerticalDropdownUseCase;

  final _subTitle = BehaviorSubject<String>.seeded("");
  final _pagePosition = BehaviorSubject<int>.seeded(0);

  /// Lead Details
  late TextEditingController leadSourceController = TextEditingController();
  late TextEditingController meetingParticipantsController =
      TextEditingController();
  late TextEditingController newCallRemarksController = TextEditingController();

  final _nextFollowupDate = BehaviorSubject<DateTime?>();
  final _nextFollowupDateInit = BehaviorSubject<String>();

  final _meetingOutcomeList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _meetingOutcomeListInit = BehaviorSubject<CommonList>();

  final _customerVisitList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _customerVisitListInit = BehaviorSubject<CommonList>();

  final _productList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _productListInit = BehaviorSubject<CommonList>();

  final _priorityList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _priorityListInit = BehaviorSubject<CommonList>();

  final _nextActionList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _nextActionListInit = BehaviorSubject<CommonList>();

  final _nextFollowupByList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _nextFollowupByListInit = BehaviorSubject<CommonList>();

  final _supportRequiredList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _supportRequiredListInit = BehaviorSubject<CommonList>();

  final _supportAmList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _supportAmListInit = BehaviorSubject<CommonList>();

  final _fieldAmList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _fieldAmListInit = BehaviorSubject<CommonList>();

  final _dbStatusList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _dbStatusListInit = BehaviorSubject<CommonList>();

  /// Company Details
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController gstNoController = TextEditingController();
  late TextEditingController noOfEmployeeController = TextEditingController();
  late TextEditingController turnOverController = TextEditingController();
  late TextEditingController customProductsController = TextEditingController();
  late TextEditingController existingRelationController =
      TextEditingController();
  late TextEditingController remarksController = TextEditingController();

  final _dbSourceList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _dbSourceListInit = BehaviorSubject<CommonList>();

  final _industryList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _industryListInit = BehaviorSubject<CommonList>();

  final _verticalList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _verticalListInit = BehaviorSubject<CommonList>();

  final _subVerticalList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _subVerticalListInit = BehaviorSubject<CommonList>();

  final _segmentList = BehaviorSubject<List<CommonList>>.seeded([]);
  final _segmentListInit = BehaviorSubject<CommonList>();

  /// Address Details
  late TextEditingController stateController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController areaController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController pinCodeController = TextEditingController();
  late TextEditingController websiteController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();

  /// Existing Software Details
  late TextEditingController currentSoftwareController =
      TextEditingController();
  late TextEditingController noOfUsersController = TextEditingController();
  late TextEditingController procurementYearController =
      TextEditingController();

  /// Key Contact Details
  late TextEditingController kNameController = TextEditingController();
  late TextEditingController kNumberController = TextEditingController();
  late TextEditingController kDesignDeptController = TextEditingController();
  late TextEditingController kEmailController = TextEditingController();
  late TextEditingController kWhatsappNumberController =
      TextEditingController();
  late TextEditingController kLinkedinController = TextEditingController();

  /// Decision Maker Details
  late TextEditingController dNameController = TextEditingController();
  late TextEditingController dNumberController = TextEditingController();
  late TextEditingController dDesignDeptController = TextEditingController();
  late TextEditingController dEmailController = TextEditingController();
  late TextEditingController dWhatsappNumberController =
      TextEditingController();
  late TextEditingController dLinkedinController = TextEditingController();

  /// Field Activity Details
  late TextEditingController fNameController = TextEditingController();
  late TextEditingController fNumberController = TextEditingController();
  late TextEditingController fDesignDeptController = TextEditingController();
  late TextEditingController fEmailController = TextEditingController();
  late TextEditingController fWhatsappNumberController =
      TextEditingController();
  late TextEditingController fRemarksController = TextEditingController();

  /// Other Contact Person Details
  late TextEditingController cp1NameController = TextEditingController();
  late TextEditingController cp1NumberController = TextEditingController();
  late TextEditingController cp1EmailController = TextEditingController();

  late TextEditingController cp2NameController = TextEditingController();
  late TextEditingController cp2NumberController = TextEditingController();
  late TextEditingController cp2EmailController = TextEditingController();

  late TextEditingController cp3NameController = TextEditingController();
  late TextEditingController cp3NumberController = TextEditingController();
  late TextEditingController cp3EmailController = TextEditingController();

  ValueStream<String> get subTitle => _subTitle;

  ValueStream<int> get pagePosition => _pagePosition;

  ValueStream<DateTime?> get nextFollowupDate => _nextFollowupDate.stream;

  ValueStream<String> get nextFollowupDateInit => _nextFollowupDateInit.stream;

  Stream<List<CommonList>> get meetingOutcomeList => _meetingOutcomeList;

  Stream<List<CommonList>> get customerVisitList => _customerVisitList;

  Stream<List<CommonList>> get productList => _productList;

  Stream<List<CommonList>> get priorityList => _priorityList;

  Stream<List<CommonList>> get nextActionList => _nextActionList;

  Stream<List<CommonList>> get nextFollowupByList => _nextFollowupByList;

  Stream<List<CommonList>> get supportRequiredList => _supportRequiredList;

  Stream<List<CommonList>> get supportAmList => _supportAmList;

  Stream<List<CommonList>> get fieldAmList => _fieldAmList;

  Stream<List<CommonList>> get dbStatusList => _dbStatusList;

  Stream<List<CommonList>> get dbSourceList => _dbSourceList;

  Stream<List<CommonList>> get industryList => _industryList;

  Stream<List<CommonList>> get verticalList => _verticalList;

  Stream<List<CommonList>> get subVerticalList => _subVerticalList;

  Stream<List<CommonList>> get segmentList => _segmentList;

  ValueStream<CommonList> get meetingOutcomeListInit => _meetingOutcomeListInit;

  ValueStream<CommonList> get customerVisitListInit => _customerVisitListInit;

  ValueStream<CommonList> get productListInit => _productListInit;

  ValueStream<CommonList> get priorityListInit => _priorityListInit;

  ValueStream<CommonList> get nextActionListInit => _nextActionListInit;

  ValueStream<CommonList> get nextFollowupByListInit => _nextFollowupByListInit;

  ValueStream<CommonList> get supportRequiredListInit =>
      _supportRequiredListInit;

  ValueStream<CommonList> get supportAmListInit => _supportAmListInit;

  ValueStream<CommonList> get fieldAmListInit => _fieldAmListInit;

  ValueStream<CommonList> get dbStatusListInit => _dbStatusListInit;

  ValueStream<CommonList> get dbSourceListInit => _dbSourceListInit;

  ValueStream<CommonList> get industryListInit => _industryListInit;

  ValueStream<CommonList> get verticalListInit => _verticalListInit;

  ValueStream<CommonList> get subVerticalListInit => _subVerticalListInit;

  ValueStream<CommonList> get segmentListInit => _segmentListInit;

  void fetchInitialCallBack(DatabaseData database) async {
    _pagePosition.sink.add(0);
    _subTitle.sink.add(title(_pagePosition.valueOrNull!));

    /// Company Details
    customerNameController =
        TextEditingController(text: database.companyName ?? "");
    gstNoController = TextEditingController(text: database.companyGst ?? "");
    noOfEmployeeController =
        TextEditingController(text: "${database.companyNoOfEmployee ?? ''}");
    turnOverController =
        TextEditingController(text: '${database.companyTurnOver ?? ""}');
    customProductsController =
        TextEditingController(text: database.companyCustomProducts ?? "");
    existingRelationController = TextEditingController(
        text: '${database.companyExistingRelation ?? ""}');
    remarksController =
        TextEditingController(text: database.companyRemarks ?? "");

    /// Address Details
    stateController = TextEditingController(text: database.addressState ?? "");
    cityController = TextEditingController(text: database.addressCity ?? "");
    areaController = TextEditingController(text: database.addressArea ?? "");
    addressController =
        TextEditingController(text: database.addressAddress ?? "");
    pinCodeController =
        TextEditingController(text: "${database.addressPincode ?? " "}");
    websiteController =
        TextEditingController(text: database.addressWebsite ?? "");
    phoneNumberController =
        TextEditingController(text: database.addressPhone ?? "");

    /// Existing Software Details
    currentSoftwareController =
        TextEditingController(text: database.currentSoftware ?? "");
    noOfUsersController =
        TextEditingController(text: "${database.noOfUsers ?? " "}");
    procurementYearController =
        TextEditingController(text: database.procurementYear ?? "");

    /// Key Contact Details
    kNameController = TextEditingController(text: database.keyName ?? "");
    kNumberController = TextEditingController(text: database.keyNumber ?? "");
    kDesignDeptController =
        TextEditingController(text: database.keyDesign ?? "");
    kEmailController = TextEditingController(text: database.keyEmail ?? "");
    kWhatsappNumberController =
        TextEditingController(text: "${database.keyWhatsapp ?? " "}");
    kLinkedinController =
        TextEditingController(text: database.keyLinkedin ?? "");

    /// Decision Maker Details
    dNameController = TextEditingController(text: database.makerName ?? "");
    dNumberController = TextEditingController(text: database.makerNumber ?? "");
    dDesignDeptController =
        TextEditingController(text: database.makerDesign ?? "");
    dEmailController = TextEditingController(text: database.makerEmail ?? "");
    dWhatsappNumberController =
        TextEditingController(text: database.makerWhatsapp ?? "");
    dLinkedinController =
        TextEditingController(text: database.makerLinkedin ?? "");

    /// Other Contact Person Details
    cp1NameController = TextEditingController(text: database.cp1Name ?? "");
    cp1NumberController = TextEditingController(text: database.cp1Number ?? "");
    cp1EmailController = TextEditingController(text: database.cp1Email ?? "");

    cp2NameController = TextEditingController(text: database.cp2Name ?? "");
    cp2NumberController = TextEditingController(text: database.cp2Number ?? "");
    cp2EmailController = TextEditingController(text: database.cp2Email ?? "");

    cp3NameController = TextEditingController(text: database.cp3Name ?? "");
    cp3NumberController = TextEditingController(text: database.cp3Number ?? "");
    cp3EmailController = TextEditingController(text: database.cp3Email ?? "");

    final response = await _ticketDropdownUseCase();

    response.fold(
      (_) => null,
      (_) {
        if (_.meetingOutcome!.isNotEmpty) {
          _meetingOutcomeList.sink.add(_.meetingOutcome ?? []);
        }
        if (_.supportRequired!.isNotEmpty) {
          _customerVisitList.sink.add(_.supportRequired ?? []);
        }
        if (_.product!.isNotEmpty) {
          _productList.sink.add(_.product ?? []);
        }
        if (_.priority!.isNotEmpty) {
          _priorityList.sink.add(_.priority ?? []);
        }
        if (_.nextAction!.isNotEmpty) {
          _nextActionList.sink.add(_.nextAction ?? []);
        }
        if (_.employeeList!.isNotEmpty) {
          _nextFollowupByList.sink.add(_.employeeList ?? []);
          _supportAmList.sink.add(_.employeeList ?? []);
          _fieldAmList.sink.add(_.employeeList ?? []);
        }
        if (_.supportRequired!.isNotEmpty) {
          _supportRequiredList.sink.add(_.supportRequired ?? []);
        }
        if (_.dbStatus!.isNotEmpty) {
          _dbStatusList.sink.add(_.dbStatus ?? []);
        }
        if (_.dbsource!.isNotEmpty) {
          _dbSourceList.sink.add(_.dbsource ?? []);
          for (var db in _.dbsource ?? []) {
            if (db.id.toString() == database.companyDbSource) {
              _dbSourceListInit.sink.add(db);
              break;
            }
          }
        }
        if (_.industry!.isNotEmpty) {
          _industryList.sink.add(_.industry ?? []);
          for (var i in _.industry ?? []) {
            if (i.id.toString() == database.companyIndustry) {
              _industryListInit.sink.add(i);
              break;
            }
          }
        }
        if (_.segment!.isNotEmpty) {
          _segmentList.sink.add(_.segment ?? []);
          for (var s in _.segment ?? []) {
            if (s.id.toString() == database.companySegment) {
              _segmentListInit.sink.add(s);
              break;
            }
          }
        }
      },
    );

    final industryBasedVertical = await _industryBasedVerticalDropdownUseCase(
        IndustryParams(int.parse(database.companyIndustry ?? '0')));
    industryBasedVertical.fold(
      (_) => null,
      (_) {
        if (_.vertical!.isNotEmpty) {
          _verticalList.sink.add(_.vertical ?? []);
          for (var v in _.vertical ?? []) {
            if (v.id.toString() == database.companyVertical) {
              _verticalListInit.sink.add(v);
              break;
            }
          }
        }
      },
    );

    final verticalBasedSubVertical =
        await _verticalBasedSubVerticalDropdownUseCase(
            VerticalParams(int.parse(database.companyVertical ?? '0')));
    verticalBasedSubVertical.fold(
      (_) => null,
      (_) {
        if (_.subVertical!.isNotEmpty) {
          _subVerticalList.sink.add(_.subVertical ?? []);
          for (var sv in _.subVertical ?? []) {
            if (sv.id.toString() == database.companySubVertical) {
              _subVerticalListInit.sink.add(sv);
              break;
            }
          }
        }
      },
    );
  }

  void nextPage() {
    if (_pagePosition.valueOrNull == 0 || _pagePosition.valueOrNull != 7) {
      _pagePosition.sink.add(_pagePosition.valueOrNull! + 1);
      _subTitle.sink.add(title(_pagePosition.valueOrNull!));
    }
  }

  void backPage() {
    if (_pagePosition.valueOrNull != 0) {
      _pagePosition.sink.add(_pagePosition.valueOrNull! - 1);
      _subTitle.sink.add(title(_pagePosition.valueOrNull!));
    }
  }

  String title(position) {
    switch (position) {
      case 0:
        return "Lead Details";
      case 1:
        return "Company Details";
      case 2:
        return "Address Details";
      case 3:
        return "Existing Software Details";
      case 4:
        return "Key Contact Details";
      case 5:
        return "Decision Maker Details";
      case 6:
        return "Field Activity Details";
      case 7:
        return "Other Contact Person Details";
    }
    return "";
  }

  /// Company Details
  void dbSource(params) {
    _dbSourceListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void industry(params) {
    _industryListInit.sink.add(CommonList(id: params.value, name: params.name));
    _verticalList.sink.add([]);
    _verticalListInit.sink.add(CommonList());
    industryBasedVertical(params.value);
  }

  void industryBasedVertical(int id) async {
    final response =
        await _industryBasedVerticalDropdownUseCase(IndustryParams(id));
    response.fold(
      (_) => null,
      (_) {
        if (_.vertical!.isNotEmpty) {
          _verticalList.sink.add(_.vertical ?? []);
        }
      },
    );
  }

  void vertical(params) {
    _verticalListInit.sink.add(CommonList(id: params.value, name: params.name));
    _subVerticalList.sink.add([]);
    _subVerticalListInit.sink.add(CommonList());
    verticalBasedSubVertical(params.value);
  }

  void verticalBasedSubVertical(int id) async {
    final response =
        await _verticalBasedSubVerticalDropdownUseCase(VerticalParams(id));
    response.fold(
      (_) => null,
      (_) {
        if (_.subVertical!.isNotEmpty) {
          _subVerticalList.sink.add(_.subVertical ?? []);
        }
      },
    );
  }

  void subVertical(params) {
    _subVerticalListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void segment(params) {
    _segmentListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void meetingOutcome(params) {
    _meetingOutcomeListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void customerVisit(params) {
    _customerVisitListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void product(params) {
    _productListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void priority(params) {
    _priorityListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void nextAction(params) {
    _nextActionListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void nextFollowupBy(params) {
    _nextFollowupByListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void selectedNextFollowupDate(
      DateTime date, TimeOfDay time, BuildContext context) {
    _nextFollowupDate.sink.add(date);
    _nextFollowupDateInit.sink
        .add("${DateFormat('yyyy-MM-dd').format(date)} ${time.to24hours()}:00");
  }

  void supportRequired(params) {
    _supportRequiredListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void supportAm(params) {
    _supportAmListInit.sink
        .add(CommonList(id: params.value, name: params.name));
  }

  void fieldAm(params) {
    _fieldAmListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void dbStatus(params) {
    _dbStatusListInit.sink.add(CommonList(id: params.value, name: params.name));
  }

  void onSubmit(BuildContext context, DatabaseData database) {
    final leadDetails = {
      "lead_id": database.leadId,
      "lead_source": leadSourceController.text,
      "meeting_participants": meetingParticipantsController.text,
      "meeting_outcome": _meetingOutcomeListInit.valueOrNull?.id ?? "",
      "customer_visit": _customerVisitListInit.valueOrNull!.name ?? "",

      ///
      "priority_id": _priorityListInit.valueOrNull!.id ?? "",
      "next_action_id": _nextActionListInit.valueOrNull!.id ?? "",
      "support_required_id": _supportRequiredListInit.valueOrNull!.id ?? "",
      "db_status_id": _dbStatusListInit.valueOrNull!.id ?? "",
      "customer_visit_id": _customerVisitListInit.valueOrNull!.id ?? "",

      ///

      "product": _productListInit.valueOrNull!.id ?? "",
      "priority": _priorityListInit.valueOrNull!.name ?? "",
      "next_action": _nextActionListInit.valueOrNull!.name ?? "",
      "next_followup": _nextFollowupDateInit.valueOrNull ?? "",
      "next_follow_up_by": _nextFollowupByListInit.valueOrNull!.id ?? "",
      "support_required": _supportRequiredListInit.valueOrNull!.name ?? "",
      "support_person": _supportAmListInit.valueOrNull!.id ?? "",
      "field_person": _fieldAmListInit.valueOrNull!.id ?? "",
      "db_status": _dbStatusListInit.valueOrNull!.name ?? "",
      "remarks": newCallRemarksController.text,
    };

    final companyDetails = {
      "company_name": customerNameController.text,
      "company_gst": gstNoController.text,
      "company_db_source": _dbSourceListInit.valueOrNull?.id ?? 0,
      "company_industry": _industryListInit.valueOrNull?.id ?? 0,
      "company_vertical": _verticalListInit.valueOrNull?.id ?? 0,
      "company_sub_vertical": _subVerticalListInit.valueOrNull?.id ?? 0,
      "company_segment": _segmentListInit.valueOrNull?.id ?? 0,
      "company_no_of_employee": noOfEmployeeController.text,
      "company_turn_over": turnOverController.text,
      "company_custom_products": customProductsController.text,
      "company_existing_relation": existingRelationController.text,
      "company_remarks": remarksController.text,
    };

    final addressDetails = {
      "address_state": stateController.text,
      "address_city": cityController.text,
      "address_area": areaController.text,
      "address_pincode": pinCodeController.text,
      "address_address": addressController.text,
      "address_website": websiteController.text,
      "address_phone": phoneNumberController.text,
    };

    final existingSoftwareDetails = {
      "current_software": currentSoftwareController.text,
      "no_of_users": noOfUsersController.text,
      "procurement_year": procurementYearController.text,
    };

    final keyContactDetails = {
      "key_name": kNameController.text,
      "key_number": kNumberController.text,
      "key_design": kDesignDeptController.text,
      "key_email": kEmailController.text,
      "key_whatsapp": kWhatsappNumberController.text,
      "key_linkedin": kLinkedinController.text,
    };

    final decisionMakerDetails = {
      "maker_name": dNameController.text,
      "maker_number": dNumberController.text,
      "maker_design": dDesignDeptController.text,
      "maker_email": dEmailController.text,
      "maker_whatsapp": dWhatsappNumberController.text,
      "maker_linkedin": dLinkedinController.text,
    };

    final fieldActivityDetails = {
      "field_name": fNameController.text,
      "field_number": fNumberController.text,
      "field_design": fDesignDeptController.text,
      "field_email": fEmailController.text,
      "field_whatsapp": fWhatsappNumberController.text,
      "field_remarks": fRemarksController.text,
    };

    final otherContactPersonDetails = {
      "cp1_name": cp1NameController.text,
      "cp1_number": cp1NumberController.text,
      "cp1_email": cp1EmailController.text,
      "cp2_name": cp2NameController.text,
      "cp2_number": cp2NumberController.text,
      "cp2_email": cp2EmailController.text,
      "cp3_name": cp3NameController.text,
      "cp3_number": cp3NumberController.text,
      "cp3_email": cp3EmailController.text,
    };

    final body = {
      ...leadDetails,
      ...companyDetails,
      ...addressDetails,
      ...existingSoftwareDetails,
      ...keyContactDetails,
      ...decisionMakerDetails,
      ...fieldActivityDetails,
      ...otherContactPersonDetails
    };

    Logger().d(body);

    BlocProvider.of<SfaCrudBloc>(context)
        .add(GenerateTicketEvent(type: 'Lead', body: body));
  }

  void onClear() {
    /// Lead Details
    leadSourceController.clear();
    meetingParticipantsController.clear();
    newCallRemarksController.clear();

    /// Company Details
    customerNameController.clear();
    gstNoController.clear();
    noOfEmployeeController.clear();
    turnOverController.clear();
    customProductsController.clear();
    existingRelationController.clear();
    remarksController.clear();

    /// Address Details
    stateController.clear();
    cityController.clear();
    areaController.clear();
    addressController.clear();
    pinCodeController.clear();
    websiteController.clear();
    phoneNumberController.clear();

    /// Existing Software Details
    currentSoftwareController.clear();
    noOfUsersController.clear();
    procurementYearController.clear();

    /// Key Contact Details
    kNameController.clear();
    kNumberController.clear();
    kDesignDeptController.clear();
    kEmailController.clear();
    kWhatsappNumberController.clear();
    kLinkedinController.clear();

    /// Decision Maker Details
    dNameController.clear();
    dNumberController.clear();
    dDesignDeptController.clear();
    dEmailController.clear();
    dWhatsappNumberController.clear();
    dLinkedinController.clear();

    /// Field Activity Details
    fNameController.clear();
    fNumberController.clear();
    fDesignDeptController.clear();
    fEmailController.clear();
    fWhatsappNumberController.clear();
    fRemarksController.clear();

    /// Decision Maker Details
    cp1NameController.clear();
    cp1NumberController.clear();
    cp1EmailController.clear();
    cp2NameController.clear();
    cp2NumberController.clear();
    cp2EmailController.clear();
    cp3NameController.clear();
    cp3NumberController.clear();
    cp3EmailController.clear();
  }
}
