import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class LeadDatabaseUpdateScreen extends StatefulWidget {
  final DatabaseData database;

  const LeadDatabaseUpdateScreen({super.key, required this.database});

  @override
  State<LeadDatabaseUpdateScreen> createState() =>
      _LeadDatabaseUpdateScreenState();
}

class _LeadDatabaseUpdateScreenState extends State<LeadDatabaseUpdateScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final leadDatabase = sl<LeadDatabaseUpdateStream>();

  @override
  void initState() {
    super.initState();
    leadDatabase.fetchInitialCallBack(widget.database);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: appColor.gray50,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 60.h),
        child: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          titleWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Lead Database Update",
                  style: context.textTheme.headlineSmall),
              SizedBox(height: 2.h),
              StreamBuilder<String>(
                  stream: leadDatabase.subTitle,
                  builder: (context, snapshot) {
                    final subTitle =
                        snapshot.hasData ? snapshot.data ?? "" : "";
                    return Text(
                      subTitle,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: appColor.blue600),
                    );
                  }),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(context.deviceSize.width, 5.h),
            child: StreamBuilder<int>(
                stream: leadDatabase.pagePosition,
                builder: (context, snapshot) {
                  final count = snapshot.hasData ? snapshot.data ?? 0 : 0;
                  return LinearProgressIndicator(
                    minHeight: 5.h,
                    value: count / 5,
                    backgroundColor: appColor.blue100,
                    color: appColor.blue600,
                  );
                }),
          ),
        ),
      ),
      body: BlocListener<SfaCrudBloc, SfaCrudState>(
        listener: (context, state) {
          if (state is SfaCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Lead Updated Successfully", true);
          }
          if (state is SfaCrudFailed) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: Dimensions.kPaddingAllMedium,
              child: StreamBuilder<int>(
                stream: leadDatabase.pagePosition,
                builder: (context, snapshot) {
                  final position = snapshot.hasData ? snapshot.data ?? 0 : 0;
                  return Column(children: _buildBody(position));
                },
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: StreamBuilder<int>(
          stream: leadDatabase.pagePosition,
          builder: (_, snapshot) {
            final count = snapshot.hasData ? snapshot.data ?? 0 : 0;
            return TicketBottomActionButton(
              position: count,
              onPressedBack: onBack,
              onPressedNext: onNext,
              onPressedSubmit: onSubmit,
            );
          }),
    );
  }

  List<Widget> _buildLeadDetailUI() {
    return [
      CustomTextFormField(
        label: "Lead Source",
        controller: leadDatabase.leadSourceController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Meeting Participants",
        controller: leadDatabase.meetingParticipantsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Meeting Outcome",
        required: false,
        streamList: leadDatabase.meetingOutcomeList,
        valueListInit: leadDatabase.meetingOutcomeListInit,
        onChanged: (params) {
          leadDatabase.meetingOutcome(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Product",
        required: true,
        streamList: leadDatabase.productList,
        valueListInit: leadDatabase.productListInit,
        onChanged: (params) {
          leadDatabase.product(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Priority",
        required: true,
        streamList: leadDatabase.priorityList,
        valueListInit: leadDatabase.priorityListInit,
        onChanged: (params) {
          leadDatabase.priority(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Action",
        required: true,
        streamList: leadDatabase.nextActionList,
        valueListInit: leadDatabase.nextActionListInit,
        onChanged: (params) {
          leadDatabase.nextAction(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Followup BY",
        required: true,
        streamList: leadDatabase.nextFollowupByList,
        valueListInit: leadDatabase.nextFollowupByListInit,
        onChanged: (params) {
          leadDatabase.nextFollowupBy(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      StreamBuilder<String>(
          stream: leadDatabase.nextFollowupDateInit,
          builder: (context, snapshot) {
            return CustomDateTimeTextFormField(
              label: "Next Followup",
              required: true,
              controller: TextEditingController(text: snapshot.data ?? ''),
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: leadDatabase.nextFollowupDate.valueOrNull,
                    startDate: DateTime.now());
                TimeOfDay time = await PickDateTime.time(context);
                leadDatabase.selectedNextFollowupDate(date, time, context);
                setState(() {});
              },
            );
          }),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support Required",
        required: false,
        streamList: leadDatabase.supportRequiredList,
        valueListInit: leadDatabase.supportRequiredListInit,
        onChanged: (params) {
          leadDatabase.supportRequired(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support AM",
        required: false,
        streamList: leadDatabase.supportAmList,
        valueListInit: leadDatabase.supportAmListInit,
        onChanged: (params) {
          leadDatabase.supportAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Field AM",
        required: false,
        streamList: leadDatabase.fieldAmList,
        valueListInit: leadDatabase.fieldAmListInit,
        onChanged: (params) {
          leadDatabase.fieldAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Status",
        required: true,
        streamList: leadDatabase.dbStatusList,
        valueListInit: leadDatabase.dbStatusListInit,
        onChanged: (params) {
          leadDatabase.dbStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Customer Visit/Demo",
        required: false,
        streamList: leadDatabase.customerVisitList,
        valueListInit: leadDatabase.customerVisitListInit,
        onChanged: (params) {
          leadDatabase.customerVisit(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: leadDatabase.newCallRemarksController,
        maxLines: 3,
        required: true,
      ),
    ];
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: leadDatabase.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: leadDatabase.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: leadDatabase.dbSourceList,
        valueListInit: leadDatabase.dbSourceListInit,
        onChanged: (params) {
          leadDatabase.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: leadDatabase.industryList,
        valueListInit: leadDatabase.industryListInit,
        onChanged: (params) {
          leadDatabase.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: leadDatabase.verticalList,
        valueListInit: leadDatabase.verticalListInit,
        onChanged: (params) {
          leadDatabase.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: leadDatabase.subVerticalList,
        valueListInit: leadDatabase.subVerticalListInit,
        onChanged: (params) {
          leadDatabase.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: leadDatabase.segmentList,
        valueListInit: leadDatabase.segmentListInit,
        onChanged: (params) {
          leadDatabase.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: leadDatabase.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: leadDatabase.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: leadDatabase.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: leadDatabase.existingRelationController,
        required: false,
      ),
      // Dimensions.kVerticalSpaceSmaller,
      // CustomTextFormField(
      //   label: "Remarks",
      //   controller: leadDatabase.remarksController,
      //   required: false,
      //   maxLines: 3,
      // ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: leadDatabase.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: leadDatabase.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: leadDatabase.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: leadDatabase.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: leadDatabase.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: leadDatabase.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: leadDatabase.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: leadDatabase.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: leadDatabase.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: leadDatabase.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: leadDatabase.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: leadDatabase.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: leadDatabase.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: leadDatabase.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: leadDatabase.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: leadDatabase.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: leadDatabase.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: leadDatabase.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: leadDatabase.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: leadDatabase.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: leadDatabase.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: leadDatabase.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: leadDatabase.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: leadDatabase.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: leadDatabase.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: leadDatabase.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: leadDatabase.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: leadDatabase.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: leadDatabase.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: leadDatabase.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: leadDatabase.cp3EmailController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildBody(position) {
    switch (position) {
      case 0:
        return _buildLeadDetailUI();
      case 1:
        return _buildCompanyDetailUI();
      case 2:
        return _buildAddressDetailUI();
      case 3:
        return _buildExistingSoftwareDetailUI();
      case 4:
        return _buildKeyContactDetailUI();
      case 5:
        return _buildDecisionMakerDetailUI();
      case 6:
        return _buildOtherContactPersonDetailUI();
    }
    return <Widget>[];
  }

  void onBack() {
    if (_formKey.currentState!.validate()) {
      leadDatabase.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      leadDatabase.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      leadDatabase.onSubmit(context, widget.database);
    }
  }
}
