class DatabaseDataModel {
  DatabaseModel? databaseModel;

  DatabaseDataModel({this.databaseModel});

  DatabaseDataModel.fromJson(Map<String, dynamic> json) {
    databaseModel = json['database_data'] != null
        ? DatabaseModel.fromJson(json['database_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (databaseModel != null) {
      data['database_data'] = databaseModel!.toJson();
    }
    return data;
  }
}

class DatabaseModel {
  int? currentPage;
  List<DatabaseData>? database;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  String? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  DatabaseModel(
      {this.currentPage,
      this.database,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  DatabaseModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      database = <DatabaseData>[];
      json['data'].forEach((v) {
        database!.add(DatabaseData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (database != null) {
      data['data'] = database!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class DatabaseData {
  int? leadId;
  String? companyName;
  String? companyGst;
  String? companyDbSource;
  String? companyDbSourceName;
  String? companyIndustry;
  String? companyIndustryName;
  String? companyVertical;
  String? companyVerticalName;
  String? companySubVertical;
  String? companySubVerticalName;
  String? companySegment;
  String? companySegmentName;
  int? companyTurnOver;
  int? companyNoOfEmployee;
  String? companyCustomProducts;
  int? companyExistingRelation;
  String? companyRemarks;
  String? addressState;
  String? addressCity;
  String? addressArea;
  int? addressPincode;
  String? addressAddress;
  String? addressWebsite;
  String? addressPhone;
  String? currentSoftware;
  int? noOfUsers;
  String? procurementYear;
  String? keyName;
  String? keyNumber;
  String? keyDesign;
  String? keyEmail;
  int? keyWhatsapp;
  String? keyLinkedin;
  String? makerName;
  String? makerNumber;
  String? makerDesign;
  String? makerEmail;
  String? makerWhatsapp;
  String? makerLinkedin;
  String? cp1Name;
  String? cp1Number;
  String? cp1Email;
  String? cp2Name;
  String? cp2Number;
  String? cp2Email;
  String? cp3Name;
  String? cp3Number;
  String? cp3Email;
  String? dbStatus;
  String? leadSourceId;
  String? leadSourceName;
  int? nextFollowedById;
  String? nextFollowedByName;
  int? productId;
  String? productName;
  String? priority;
  String? supportRequired;
  String? nextAction;
  int? supportPersonId;
  String? supportPersonName;
  int? fieldPerson;
  String? fieldPersonName;

  DatabaseData(
      {this.leadId,
      this.companyName,
      this.companyGst,
      this.companyDbSource,
      this.companyDbSourceName,
      this.companyIndustry,
      this.companyIndustryName,
      this.companyVertical,
      this.companyVerticalName,
      this.companySubVertical,
      this.companySubVerticalName,
      this.companySegment,
      this.companySegmentName,
      this.companyTurnOver,
      this.companyNoOfEmployee,
      this.companyCustomProducts,
      this.companyExistingRelation,
      this.companyRemarks,
      this.addressState,
      this.addressCity,
      this.addressArea,
      this.addressPincode,
      this.addressAddress,
      this.addressWebsite,
      this.addressPhone,
      this.currentSoftware,
      this.noOfUsers,
      this.procurementYear,
      this.keyName,
      this.keyNumber,
      this.keyDesign,
      this.keyEmail,
      this.keyWhatsapp,
      this.keyLinkedin,
      this.makerName,
      this.makerNumber,
      this.makerDesign,
      this.makerEmail,
      this.makerWhatsapp,
      this.makerLinkedin,
      this.cp1Name,
      this.cp1Number,
      this.cp1Email,
      this.cp2Name,
      this.cp2Number,
      this.cp2Email,
      this.cp3Name,
      this.cp3Number,
      this.cp3Email,
      this.dbStatus,
      this.leadSourceId,
      this.leadSourceName,
      this.nextFollowedById,
      this.nextFollowedByName,
      this.productId,
      this.productName,
      this.priority,
      this.supportRequired,
      this.nextAction,
      this.supportPersonId,
      this.supportPersonName,
      this.fieldPerson,
      this.fieldPersonName});

  DatabaseData.fromJson(Map<String, dynamic> json) {
    leadId = json['lead_id'];
    companyName = json['company_name'];
    companyGst = json['company_gst'];
    companyDbSource = json['company_db_source'];
    companyDbSourceName = json['company_db_source_name'];
    companyIndustry = json['company_industry'];
    companyIndustryName = json['company_industry_name'];
    companyVertical = json['company_vertical'];
    companyVerticalName = json['company_vertical_name'];
    companySubVertical = json['company_sub_vertical'];
    companySubVerticalName = json['company_sub_vertical_name'];
    companySegment = json['company_segment'];
    companySegmentName = json['company_segment_name'];
    companyTurnOver = json['company_turn_over'];
    companyNoOfEmployee = json['company_no_of_employee'];
    companyCustomProducts = json['company_custom_products'];
    companyExistingRelation = json['company_existing_relation'];
    companyRemarks = json['company_remarks'];
    addressState = json['address_state'];
    addressCity = json['address_city'];
    addressArea = json['address_area'];
    addressPincode = json['address_pincode'];
    addressAddress = json['address_address'];
    addressWebsite = json['address_website'];
    addressPhone = json['address_phone'];
    currentSoftware = json['current_software'];
    noOfUsers = json['no_of_users'];
    procurementYear = json['procurement_year'];
    keyName = json['key_name'];
    keyNumber = json['key_number'];
    keyDesign = json['key_design'];
    keyEmail = json['key_email'];
    keyWhatsapp = json['key_whatsapp'];
    keyLinkedin = json['key_linkedin'];
    makerName = json['maker_name'];
    makerNumber = json['maker_number'];
    makerDesign = json['maker_design'];
    makerEmail = json['maker_email'];
    makerWhatsapp = json['maker_whatsapp'];
    makerLinkedin = json['maker_linkedin'];
    cp1Name = json['cp1_name'];
    cp1Number = json['cp1_number'];
    cp1Email = json['cp1_email'];
    cp2Name = json['cp2_name'];
    cp2Number = json['cp2_number'];
    cp2Email = json['cp2_email'];
    cp3Name = json['cp3_name'];
    cp3Number = json['cp3_number'];
    cp3Email = json['cp3_email'];
    dbStatus = json['db_status'];
    leadSourceId = json['lead_source_id'];
    leadSourceName = json['lead_source_name'];
    nextFollowedById = json['next_followed_by_id'];
    nextFollowedByName = json['next_followed_by_name'];
    productId = json['product_id'];
    productName = json['product_name'];
    priority = json['priority'];
    supportRequired = json['support_required'];
    nextAction = json['next_action'];
    supportPersonId = json['support_person_id'];
    supportPersonName = json['support_person_name'];
    fieldPerson = json['field_person'];
    fieldPersonName = json['field_person_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lead_id'] = leadId;
    data['company_name'] = companyName;
    data['company_gst'] = companyGst;
    data['company_db_source'] = companyDbSource;
    data['company_db_source_name'] = companyDbSourceName;
    data['company_industry'] = companyIndustry;
    data['company_industry_name'] = companyIndustryName;
    data['company_vertical'] = companyVertical;
    data['company_vertical_name'] = companyVerticalName;
    data['company_sub_vertical'] = companySubVertical;
    data['company_sub_vertical_name'] = companySubVerticalName;
    data['company_segment'] = companySegment;
    data['company_segment_name'] = companySegmentName;
    data['company_turn_over'] = companyTurnOver;
    data['company_no_of_employee'] = companyNoOfEmployee;
    data['company_custom_products'] = companyCustomProducts;
    data['company_existing_relation'] = companyExistingRelation;
    data['company_remarks'] = companyRemarks;
    data['address_state'] = addressState;
    data['address_city'] = addressCity;
    data['address_area'] = addressArea;
    data['address_pincode'] = addressPincode;
    data['address_address'] = addressAddress;
    data['address_website'] = addressWebsite;
    data['address_phone'] = addressPhone;
    data['current_software'] = currentSoftware;
    data['no_of_users'] = noOfUsers;
    data['procurement_year'] = procurementYear;
    data['key_name'] = keyName;
    data['key_number'] = keyNumber;
    data['key_design'] = keyDesign;
    data['key_email'] = keyEmail;
    data['key_whatsapp'] = keyWhatsapp;
    data['key_linkedin'] = keyLinkedin;
    data['maker_name'] = makerName;
    data['maker_number'] = makerNumber;
    data['maker_design'] = makerDesign;
    data['maker_email'] = makerEmail;
    data['maker_whatsapp'] = makerWhatsapp;
    data['maker_linkedin'] = makerLinkedin;
    data['cp1_name'] = cp1Name;
    data['cp1_number'] = cp1Number;
    data['cp1_email'] = cp1Email;
    data['cp2_name'] = cp2Name;
    data['cp2_number'] = cp2Number;
    data['cp2_email'] = cp2Email;
    data['cp3_name'] = cp3Name;
    data['cp3_number'] = cp3Number;
    data['cp3_email'] = cp3Email;
    data['db_status'] = dbStatus;
    data['lead_source_id'] = leadSourceId;
    data['lead_source_name'] = leadSourceName;
    data['next_followed_by_id'] = nextFollowedById;
    data['next_followed_by_name'] = nextFollowedByName;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['priority'] = priority;
    data['support_required'] = supportRequired;
    data['next_action'] = nextAction;
    data['support_person_id'] = supportPersonId;
    data['support_person_name'] = supportPersonName;
    data['field_person'] = fieldPerson;
    data['field_person_name'] = fieldPersonName;
    return data;
  }
}
