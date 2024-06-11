import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifive_hrms/core/core.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../feature.dart';

class GenerateTicketStream {
  GenerateTicketStream(
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

  /// Company Details
  late TextEditingController customerNameController = TextEditingController();
  late TextEditingController gstNoController = TextEditingController();
  late TextEditingController noOfEmployeeController = TextEditingController();
  late TextEditingController turnOverController = TextEditingController();
  late TextEditingController customProductsController = TextEditingController();
  late TextEditingController existingRelationController =
      TextEditingController();
  late TextEditingController remarksController = TextEditingController();

  final _subTitle = BehaviorSubject<String>.seeded("");
  final _pagePosition = BehaviorSubject<int>.seeded(0);

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

  /// Other Contact Person Details
  ValueStream<String> get subTitle => _subTitle;

  ValueStream<int> get pagePosition => _pagePosition;

  Stream<List<CommonList>> get dbSourceList => _dbSourceList;

  Stream<List<CommonList>> get industryList => _industryList;

  Stream<List<CommonList>> get verticalList => _verticalList;

  Stream<List<CommonList>> get subVerticalList => _subVerticalList;

  Stream<List<CommonList>> get segmentList => _segmentList;

  ValueStream<CommonList> get dbSourceListInit => _dbSourceListInit;

  ValueStream<CommonList> get industryListInit => _industryListInit;

  ValueStream<CommonList> get verticalListInit => _verticalListInit;

  ValueStream<CommonList> get subVerticalListInit => _subVerticalListInit;

  ValueStream<CommonList> get segmentListInit => _segmentListInit;

  void fetchInitialCallBack() async {
    _pagePosition.sink.add(0);
    _subTitle.sink.add(title(_pagePosition.valueOrNull!));

    final response = await _ticketDropdownUseCase();

    response.fold(
      (_) => null,
      (_) {
        if (_.dbsource!.isNotEmpty) {
          _dbSourceList.sink.add(_.dbsource ?? []);
        }
        if (_.industry!.isNotEmpty) {
          _industryList.sink.add(_.industry ?? []);
        }
        if (_.vertical!.isNotEmpty) {
          _verticalList.sink.add(_.vertical ?? []);
        }
        if (_.subVertical!.isNotEmpty) {
          _subVerticalList.sink.add(_.subVertical ?? []);
        }
        if (_.segment!.isNotEmpty) {
          _segmentList.sink.add(_.segment ?? []);
        }
      },
    );
  }

  void nextPage() {
    if (_pagePosition.valueOrNull == 0 || _pagePosition.valueOrNull != 5) {
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
        return "Company Details";
      case 1:
        return "Address Details";
      case 2:
        return "Existing Software Details";
      case 3:
        return "Key Contact Details";
      case 4:
        return "Decision Maker Details";
      case 5:
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

  /*
        {
            "lead_id": 68, ---> update api
            
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
           
            "address_area": "Tnagar,Tnagar,T",
            "address_city": "Chennai,Chen",
            "address_pincode": 600017,
            "address_address": "D10, 2nd Floor, Parsn Complex No. 1, Kodambakkam Road, Before Palm Groove Hotel,      Chennai Tamil Nadu , 600002,41, Thiyagaraya Gramani Street, T Nagar Near Kodambakkam Railway Staionon, T Nagar Side      Chennai Tamil Nadu , 600017,41, Thiyagaraya Gramani Street, T Nagar Near Kodambakkam Railway Staionon, T Nagar Side      Chennai Tamil Nadu , 600017,41, Thiyagaraya Gramani Street, T Nagar Near Kodambakkam Railway Staionon, T Nagar Side      Chennai Tamil Nadu , 600017",
            "address_website": "nil",
            "address_phone": "(044) 28492257,044) 28492257,044) 28492257,044) 28492257",
            "name": "Sampath Kumar (Manager),Sampath Kumar (Manager),Sampath Kumar (Manager)",
            "phonenum": "(044) 28492257,044) 28492257,044) 28492257,044) 28492257",
            "desig": "",
            "email_id": "",
            "whatsapp": 0,
            "linked_in": "",
            "maker_name": "",
            "maker_number": "",
            "maker_desig": "",
            "maker_emailid": "",
            "maker_whatsapp": "",
            "maker_link": "",
            "company_db_name": "Website",
            "company_industry_name": "Services",
            "company_segment_name": "SME",
            "db_status": "DCR",
            "next_followed_by_id": 1,
            "next_followed_by_name": "SUPERADMIN",
            "lead_source_id": "1",
            "lead_source_name": "Website",
            "requirement_id": 2,
            "requirement_name": "ERP",
            "priority": "Low"
        },
   */

  void onSubmit(BuildContext context) {
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
      ...companyDetails,
      ...addressDetails,
      ...existingSoftwareDetails,
      ...keyContactDetails,
      ...decisionMakerDetails,
      ...otherContactPersonDetails
    };

    Logger().d(body);

    BlocProvider.of<SfaCrudBloc>(context)
        .add(GenerateTicketEvent(body: body, type: ""));
  }

  void onClear() {
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
