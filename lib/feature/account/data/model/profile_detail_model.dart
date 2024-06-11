class ProfileDetailModel {
  Profile? profile;
  Personal? personal;
  Contact? contact;
  List<Null>? salary;
  List<TrainingCertification>? trainingCertification;
  List<Education>? education;
  List<Experience>? experience;
  List<Skills>? skills;
  List<VisaImmigration>? visaImmigration;

  ProfileDetailModel(
      {this.profile,
      this.personal,
      this.contact,
      this.salary,
      this.trainingCertification,
      this.education,
      this.experience,
      this.skills,
      this.visaImmigration});

  ProfileDetailModel.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    personal =
        json['personal'] != null ? Personal.fromJson(json['personal']) : null;
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    if (json['salary'] != null) {
      salary = <Null>[];
    }
    if (json['training_certification'] != null) {
      trainingCertification = <TrainingCertification>[];
      json['training_certification'].forEach((v) {
        trainingCertification!.add(TrainingCertification.fromJson(v));
      });
    }
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(Education.fromJson(v));
      });
    }
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(Experience.fromJson(v));
      });
    }
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
    if (json['visa_immigration'] != null) {
      visaImmigration = <VisaImmigration>[];
      json['visa_immigration'].forEach((v) {
        visaImmigration!.add(VisaImmigration.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['personal'] = personal;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    data['salary'] = salary;
    if (trainingCertification != null) {
      data['training_certification'] =
          trainingCertification!.map((v) => v.toJson()).toList();
    }
    if (education != null) {
      data['education'] = education!.map((v) => v.toJson()).toList();
    }
    if (experience != null) {
      data['experience'] = experience!.map((v) => v.toJson()).toList();
    }
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    if (visaImmigration != null) {
      data['visa_immigration'] =
          visaImmigration!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Profile {
  int? employeeId;
  String? employeeNumber;
  String? firstName;
  String? lastName;
  String? avatar;
  String? workTelephoneNumber;
  String? email;
  String? dateOfBirth;
  dynamic bloodGroup;
  String? empType;

  Profile(
      {this.employeeId,
      this.employeeNumber,
      this.firstName,
      this.lastName,
      this.avatar,
      this.workTelephoneNumber,
      this.email,
      this.dateOfBirth,
      this.bloodGroup,
      this.empType});

  Profile.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    employeeNumber = json['employee_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
    workTelephoneNumber = json['work_telephone_number'];
    email = json['email'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    empType = json['emp_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['employee_id'] = employeeId;
    data['employee_number'] = employeeNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    data['work_telephone_number'] = workTelephoneNumber;
    data['email'] = email;
    data['date_of_birth'] = dateOfBirth;
    data['blood_group'] = bloodGroup;
    data['emp_type'] = empType;
    return data;
  }
}

class Personal {
  int? id;
  int? employeeId;
  String? gender;
  String? maritalStatus;
  String? nationality;
  int? motherTongue;
  String? religion;
  String? language;
  String? dateOfBirth;
  int? age;
  String? bloodGroup;
  String? personalMail;
  String? personalMobile;
  String? passportNumber;
  String? passportExpiryDate;
  String? drivingLicenceNumber;
  String? drivingLicenceExpiryDate;
  String? idName;
  String? idNumber;
  String? idName1;
  String? idNumber1;
  String? vehicleType;
  String? vehicleNumber;
  String? fatherName;
  String? motherName;
  String? spouseName;
  String? spouseDob;
  String? spouseAge;
  String? husbandName;
  String? noOfChildren;
  String? childrenName1;
  String? childrenName2;
  String? childrenDob1;
  String? childrenDob2;
  String? childrenName;
  String? childrenDob;
  String? childrenAge;
  String? aadharNumber;
  String? panNumber;
  String? fatherDob;
  dynamic fatherAge;
  String? motherDob;
  dynamic motherAge;
  String? fatherAadharNumber;
  String? motherAadharNumber;
  String? spouceAadharNumber;
  String? husbandAadharNumber;
  String? updatedAt;
  String? createdAt;
  int? createdBy;
  int? lastUpdatedBy;
  int? companyId;
  int? locationId;
  int? organizationId;
  String? nationalityName;
  String? motherTongueName;
  String? bloodGroupName;
  String? genderName;
  String? maritalStatusName;

  Personal(
      {this.id,
      this.employeeId,
      this.gender,
      this.maritalStatus,
      this.nationality,
      this.motherTongue,
      this.religion,
      this.language,
      this.dateOfBirth,
      this.age,
      this.bloodGroup,
      this.personalMail,
      this.personalMobile,
      this.passportNumber,
      this.passportExpiryDate,
      this.drivingLicenceNumber,
      this.drivingLicenceExpiryDate,
      this.idName,
      this.idNumber,
      this.idName1,
      this.idNumber1,
      this.vehicleType,
      this.vehicleNumber,
      this.fatherName,
      this.motherName,
      this.spouseName,
      this.spouseDob,
      this.spouseAge,
      this.husbandName,
      this.noOfChildren,
      this.childrenName1,
      this.childrenName2,
      this.childrenDob1,
      this.childrenDob2,
      this.childrenName,
      this.childrenDob,
      this.childrenAge,
      this.aadharNumber,
      this.panNumber,
      this.fatherDob,
      this.fatherAge,
      this.motherDob,
      this.motherAge,
      this.fatherAadharNumber,
      this.motherAadharNumber,
      this.spouceAadharNumber,
      this.husbandAadharNumber,
      this.updatedAt,
      this.createdAt,
      this.createdBy,
      this.lastUpdatedBy,
      this.companyId,
      this.locationId,
      this.organizationId,
      this.nationalityName,
      this.motherTongueName,
      this.bloodGroupName,
      this.genderName,
      this.maritalStatusName});

  Personal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    nationality = json['nationality'];
    motherTongue = json['mother_tongue'];
    religion = json['religion'];
    language = json['language'];
    dateOfBirth = json['date_of_birth'];
    age = json['age'];
    bloodGroup = json['blood_group'];
    personalMail = json['personal_mail'];
    personalMobile = json['personal_mobile'];
    passportNumber = json['passport_number'];
    passportExpiryDate = json['passport_expiry_date'];
    drivingLicenceNumber = json['driving_licence_number'];
    drivingLicenceExpiryDate = json['driving_licence_expiry_date'];
    idName = json['id_name'];
    idNumber = json['id_number'];
    idName1 = json['id_name1'];
    idNumber1 = json['id_number1'];
    vehicleType = json['vehicle_type'];
    vehicleNumber = json['vehicle_number'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    spouseName = json['spouse_name'];
    spouseDob = json['spouse_dob'];
    spouseAge = json['spouse_age'];
    husbandName = json['husband_name'];
    noOfChildren = json['no_of_children'];
    childrenName1 = json['children_name1'];
    childrenName2 = json['children_name2'];
    childrenDob1 = json['children_dob1'];
    childrenDob2 = json['children_dob2'];
    childrenName = json['children_name'];
    childrenDob = json['children_dob'];
    childrenAge = json['children_age'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    fatherDob = json['father_dob'];
    fatherAge = json['father_age'];
    motherDob = json['mother_dob'];
    motherAge = json['mother_age'];
    fatherAadharNumber = json['father_aadhar_number'];
    motherAadharNumber = json['mother_aadhar_number'];
    spouceAadharNumber = json['spouce_aadhar_number'];
    husbandAadharNumber = json['husband_aadhar_number'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
    nationalityName = json['nationality_name'];
    motherTongueName = json['mother_tongue_name'];
    bloodGroupName = json['blood_group_name'];
    genderName = json['gender_name'];
    maritalStatusName = json['marital_status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['gender'] = gender;
    data['marital_status'] = maritalStatus;
    data['nationality'] = nationality;
    data['mother_tongue'] = motherTongue;
    data['religion'] = religion;
    data['language'] = language;
    data['date_of_birth'] = dateOfBirth;
    data['age'] = age;
    data['blood_group'] = bloodGroup;
    data['personal_mail'] = personalMail;
    data['personal_mobile'] = personalMobile;
    data['passport_number'] = passportNumber;
    data['passport_expiry_date'] = passportExpiryDate;
    data['driving_licence_number'] = drivingLicenceNumber;
    data['driving_licence_expiry_date'] = drivingLicenceExpiryDate;
    data['id_name'] = idName;
    data['id_number'] = idNumber;
    data['id_name1'] = idName1;
    data['id_number1'] = idNumber1;
    data['vehicle_type'] = vehicleType;
    data['vehicle_number'] = vehicleNumber;
    data['father_name'] = fatherName;
    data['mother_name'] = motherName;
    data['spouse_name'] = spouseName;
    data['spouse_dob'] = spouseDob;
    data['spouse_age'] = spouseAge;
    data['husband_name'] = husbandName;
    data['no_of_children'] = noOfChildren;
    data['children_name1'] = childrenName1;
    data['children_name2'] = childrenName2;
    data['children_dob1'] = childrenDob1;
    data['children_dob2'] = childrenDob2;
    data['children_name'] = childrenName;
    data['children_dob'] = childrenDob;
    data['children_age'] = childrenAge;
    data['aadhar_number'] = aadharNumber;
    data['pan_number'] = panNumber;
    data['father_dob'] = fatherDob;
    data['father_age'] = fatherAge;
    data['mother_dob'] = motherDob;
    data['mother_age'] = motherAge;
    data['father_aadhar_number'] = fatherAadharNumber;
    data['mother_aadhar_number'] = motherAadharNumber;
    data['spouce_aadhar_number'] = spouceAadharNumber;
    data['husband_aadhar_number'] = husbandAadharNumber;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;
    data['nationality_name'] = nationalityName;
    data['mother_tongue_name'] = this.motherTongueName;
    data['blood_group_name'] = bloodGroupName;
    data['gender_name'] = genderName;
    data['marital_status_name'] = maritalStatusName;
    return data;
  }
}

class Contact {
  int? id;
  int? employeeId;
  String? permanentStreetAddress;
  dynamic permanentCountry;
  dynamic permanentState;
  dynamic permanentCity;
  dynamic permanentPostalCode;
  String? permanentLocality;
  String? currentStreetAddress;
  dynamic currentCountry;
  dynamic currentState;
  dynamic currentCity;
  dynamic currentPostalCode;
  String? emergencyContacts;
  String? sameAddress;
  String? currentLocality;
  String? createdAt;
  String? currentStreet;
  String? currentFlatNo;
  String? permanentStreet;
  String? permanentFlatNo;
  String? updatedAt;
  int? createdBy;
  int? lastUpdatedBy;
  int? locationId;
  int? companyId;
  int? organization;
  String? permanentCountryName;
  String? currentCountryName;
  String? permanentStateName;
  String? currentStateName;
  String? permanentCityName;
  String? currentCityName;

  Contact(
      {this.id,
      this.employeeId,
      this.permanentStreetAddress,
      this.permanentCountry,
      this.permanentState,
      this.permanentCity,
      this.permanentPostalCode,
      this.permanentLocality,
      this.currentStreetAddress,
      this.currentCountry,
      this.currentState,
      this.currentCity,
      this.currentPostalCode,
      this.emergencyContacts,
      this.sameAddress,
      this.currentLocality,
      this.createdAt,
      this.currentStreet,
      this.currentFlatNo,
      this.permanentStreet,
      this.permanentFlatNo,
      this.updatedAt,
      this.createdBy,
      this.lastUpdatedBy,
      this.locationId,
      this.companyId,
      this.organization,
      this.permanentCountryName,
      this.currentCountryName,
      this.permanentStateName,
      this.currentStateName,
      this.permanentCityName,
      this.currentCityName});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    permanentStreetAddress = json['permanent_street_address'];
    permanentCountry = json['permanent_country'];
    permanentState = json['permanent_state'];
    permanentCity = json['permanent_city'];
    permanentPostalCode = json['permanent_postal_code'];
    permanentLocality = json['permanent_locality'];
    currentStreetAddress = json['current_street_address'];
    currentCountry = json['current_country'];
    currentState = json['current_state'];
    currentCity = json['current_city'];
    currentPostalCode = json['current_postal_code'];
    emergencyContacts = json['emergency_contacts'];
    sameAddress = json['same_address'];
    currentLocality = json['current_locality'];
    createdAt = json['created_at'];
    currentStreet = json['current_street'];
    currentFlatNo = json['current_flat_no'];
    permanentStreet = json['permanent_street'];
    permanentFlatNo = json['permanent_flat_no'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    locationId = json['location_id'];
    companyId = json['company_id'];
    organization = json['organization'];
    permanentCountryName = json['permanent_country_name'];
    currentCountryName = json['current_country_name'];
    permanentStateName = json['permanent_state_name'];
    currentStateName = json['current_state_name'];
    permanentCityName = json['permanent_city_name'];
    currentCityName = json['current_city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['permanent_street_address'] = permanentStreetAddress;
    data['permanent_country'] = permanentCountry;
    data['permanent_state'] = permanentState;
    data['permanent_city'] = permanentCity;
    data['permanent_postal_code'] = permanentPostalCode;
    data['permanent_locality'] = permanentLocality;
    data['current_street_address'] = currentStreetAddress;
    data['current_country'] = currentCountry;
    data['current_state'] = currentState;
    data['current_city'] = currentCity;
    data['current_postal_code'] = currentPostalCode;
    data['emergency_contacts'] = emergencyContacts;
    data['same_address'] = sameAddress;
    data['current_locality'] = currentLocality;
    data['created_at'] = createdAt;
    data['current_street'] = currentStreet;
    data['current_flat_no'] = currentFlatNo;
    data['permanent_street'] = permanentStreet;
    data['permanent_flat_no'] = permanentFlatNo;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['location_id'] = locationId;
    data['company_id'] = companyId;
    data['organization'] = organization;
    data['permanent_country_name'] = permanentCountryName;
    data['current_country_name'] = currentCountryName;
    data['permanent_state_name'] = permanentStateName;
    data['current_state_name'] = currentStateName;
    data['permanent_city_name'] = permanentCityName;
    data['current_city_name'] = currentCityName;
    return data;
  }
}

class TrainingCertification {
  int? id;
  int? employeeId;
  String? courseName;
  String? certificateLevel;
  String? courseOfferedBy;
  String? courseDuration;
  String? description;
  String? certificateName;
  String? issueDate;
  String? files;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? companyId;
  int? locationId;
  int? organizationId;
  String? certificateLevelName;

  TrainingCertification(
      {this.id,
      this.employeeId,
      this.courseName,
      this.certificateLevel,
      this.courseOfferedBy,
      this.courseDuration,
      this.description,
      this.certificateName,
      this.issueDate,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.companyId,
      this.locationId,
      this.organizationId,
      this.certificateLevelName});

  TrainingCertification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    courseName = json['course_name'];
    certificateLevel = json['certificate_level'];
    courseOfferedBy = json['course_offered_by'];
    courseDuration = json['course_duration'];
    description = json['description'];
    certificateName = json['certificate_name'];
    issueDate = json['issue_date'];
    files = json['files'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
    certificateLevelName = json['certificate_level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['course_name'] = courseName;
    data['certificate_level'] = certificateLevel;
    data['course_offered_by'] = courseOfferedBy;
    data['course_duration'] = courseDuration;
    data['description'] = description;
    data['certificate_name'] = certificateName;
    data['issue_date'] = issueDate;
    data['files'] = files;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;
    data['certificate_level_name'] = certificateLevelName;
    return data;
  }
}

class Education {
  int? id;
  int? employeeId;
  String? educationLevel;
  String? other;
  String? institutionName;
  String? schoolName;
  String? schoolBoard;
  String? universityName;
  String? course;
  String? fromDate;
  String? toDate;
  String? percentage;
  String? files;
  String? cerFile;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? lastUpdatedBy;
  int? companyId;
  int? locationId;
  int? organizationId;
  String? educationLevelName;

  Education(
      {this.id,
      this.employeeId,
      this.educationLevel,
      this.other,
      this.institutionName,
      this.schoolName,
      this.schoolBoard,
      this.universityName,
      this.course,
      this.fromDate,
      this.toDate,
      this.percentage,
      this.files,
      this.cerFile,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.lastUpdatedBy,
      this.companyId,
      this.locationId,
      this.organizationId,
      this.educationLevelName});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    educationLevel = json['education_level'];
    other = json['other'];
    institutionName = json['institution_name'];
    schoolName = json['school_name'];
    schoolBoard = json['school_board'];
    universityName = json['university_name'];
    course = json['course'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    percentage = json['percentage'];
    files = json['files'];
    cerFile = json['cer_file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
    educationLevelName = json['education_level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['education_level'] = educationLevel;
    data['other'] = other;
    data['institution_name'] = institutionName;
    data['school_name'] = schoolName;
    data['school_board'] = schoolBoard;
    data['university_name'] = universityName;
    data['course'] = course;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['percentage'] = percentage;
    data['files'] = files;
    data['cer_file'] = cerFile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;
    data['education_level_name'] = educationLevelName;
    return data;
  }
}

class Experience {
  int? id;
  int? employeeId;
  String? organizationName;
  String? organizationWebsite;
  String? designation;
  int? ctc;
  String? experienceType;
  String? fromDate;
  String? toDate;
  String? reasonLeaving;
  String? refererName;
  String? refererContact;
  String? refererEmail;
  String? files;
  String? createdAt;
  String? updatedAt;
  String? cerFile;
  int? createdBy;
  int? lastUpdatedBy;
  int? companyId;
  int? locationId;
  int? organizationId;

  Experience(
      {this.id,
      this.employeeId,
      this.organizationName,
      this.organizationWebsite,
      this.designation,
      this.ctc,
      this.experienceType,
      this.fromDate,
      this.toDate,
      this.reasonLeaving,
      this.refererName,
      this.refererContact,
      this.refererEmail,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.cerFile,
      this.createdBy,
      this.lastUpdatedBy,
      this.companyId,
      this.locationId,
      this.organizationId});

  Experience.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    organizationName = json['organization_name'];
    organizationWebsite = json['organization_website'];
    designation = json['designation'];
    ctc = json['ctc'];
    experienceType = json['experience_type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    reasonLeaving = json['reason_leaving'];
    refererName = json['referer_name'];
    refererContact = json['referer_contact'];
    refererEmail = json['referer_email'];
    files = json['files'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cerFile = json['cer_file'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['organization_name'] = organizationName;
    data['organization_website'] = organizationWebsite;
    data['designation'] = designation;
    data['ctc'] = ctc;
    data['experience_type'] = experienceType;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['reason_leaving'] = reasonLeaving;
    data['referer_name'] = refererName;
    data['referer_contact'] = refererContact;
    data['referer_email'] = refererEmail;
    data['files'] = files;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cer_file'] = cerFile;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;
    return data;
  }
}

class Skills {
  int? id;
  int? employeeId;
  String? skill;
  String? version;
  String? competencyLevel;
  String? skillLastUsedYear;
  String? files;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? lastUpdatedBy;
  int? companyId;
  int? locationId;
  int? organizationId;
  String? competencyLevelName;

  Skills(
      {this.id,
      this.employeeId,
      this.skill,
      this.version,
      this.competencyLevel,
      this.skillLastUsedYear,
      this.files,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.lastUpdatedBy,
      this.companyId,
      this.locationId,
      this.organizationId,
      this.competencyLevelName});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    skill = json['skill'];
    version = json['version'];
    competencyLevel = json['competency_level'];
    skillLastUsedYear = json['skill_last_used_year'];
    files = json['files'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    lastUpdatedBy = json['last_updated_by'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
    competencyLevelName = json['competency_level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['skill'] = skill;
    data['version'] = version;
    data['competency_level'] = competencyLevel;
    data['skill_last_used_year'] = skillLastUsedYear;
    data['files'] = files;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['last_updated_by'] = lastUpdatedBy;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;
    data['competency_level_name'] = competencyLevelName;
    return data;
  }
}

class VisaImmigration {
  int? id;
  int? employeeId;
  String? passportNumber;
  String? passportIssuedDate;
  String? passportExpiryDate;
  String? visaCountry;
  String? visaTypeCode;
  String? visaNumber;
  String? visaIssuedDate;
  String? visaExpiryDate;
  String? files;
  String? iStatus;
  String? iReviewDate;
  String? issuingAuthority;
  String? inStatus;
  String? iExpiryDate;
  int? createdBy;
  String? createdAt;
  int? updatedBy;
  String? updatedAt;
  int? companyId;
  int? locationId;
  int? organizationId;
  String? visaCountryName;

  VisaImmigration(
      {this.id,
      this.employeeId,
      this.passportNumber,
      this.passportIssuedDate,
      this.passportExpiryDate,
      this.visaCountry,
      this.visaTypeCode,
      this.visaNumber,
      this.visaIssuedDate,
      this.visaExpiryDate,
      this.files,
      this.iStatus,
      this.iReviewDate,
      this.issuingAuthority,
      this.inStatus,
      this.iExpiryDate,
      this.createdBy,
      this.createdAt,
      this.updatedBy,
      this.updatedAt,
      this.companyId,
      this.locationId,
      this.organizationId,
      this.visaCountryName});

  VisaImmigration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    passportNumber = json['passport_number'];
    passportIssuedDate = json['passport_issued_date'];
    passportExpiryDate = json['passport_expiry_date'];
    visaCountry = json['visa_country'];
    visaTypeCode = json['visa_type_code'];
    visaNumber = json['visa_number'];
    visaIssuedDate = json['visa_issued_date'];
    visaExpiryDate = json['visa_expiry_date'];
    files = json['files'];
    iStatus = json['i_status'];
    iReviewDate = json['i_review_date'];
    issuingAuthority = json['issuing_authority'];
    inStatus = json['in_status'];
    iExpiryDate = json['i_expiry_date'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedBy = json['updated_by'];
    updatedAt = json['updated_at'];
    companyId = json['company_id'];
    locationId = json['location_id'];
    organizationId = json['organization_id'];
    visaCountryName = json['visa_country_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['passport_number'] = passportNumber;
    data['passport_issued_date'] = passportIssuedDate;
    data['passport_expiry_date'] = passportExpiryDate;
    data['visa_country'] = visaCountry;
    data['visa_type_code'] = visaTypeCode;
    data['visa_number'] = visaNumber;
    data['visa_issued_date'] = visaIssuedDate;
    data['visa_expiry_date'] = visaExpiryDate;
    data['files'] = files;
    data['i_status'] = iStatus;
    data['i_review_date'] = iReviewDate;
    data['issuing_authority'] = issuingAuthority;
    data['in_status'] = inStatus;
    data['i_expiry_date'] = iExpiryDate;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_by'] = updatedBy;
    data['updated_at'] = updatedAt;
    data['company_id'] = companyId;
    data['location_id'] = locationId;
    data['organization_id'] = organizationId;

    data['visa_country_name'] = visaCountryName;
    return data;
  }
}
