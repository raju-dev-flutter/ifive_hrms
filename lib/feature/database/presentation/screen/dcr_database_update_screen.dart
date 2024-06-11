import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class DcrDatabaseUpdateScreen extends StatefulWidget {
  final DatabaseData database;

  const DcrDatabaseUpdateScreen({super.key, required this.database});

  @override
  State<DcrDatabaseUpdateScreen> createState() =>
      _DcrDatabaseUpdateScreenState();
}

class _DcrDatabaseUpdateScreenState extends State<DcrDatabaseUpdateScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final dcrDatabase = sl<DcrDatabaseUpdateStream>();

  @override
  void initState() {
    super.initState();
    dcrDatabase.fetchInitialCallBack(widget.database);
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
              Text("Dcr Database Update",
                  style: context.textTheme.headlineSmall),
              SizedBox(height: 2.h),
              StreamBuilder<String>(
                  stream: dcrDatabase.subTitle,
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
                stream: dcrDatabase.pagePosition,
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
                context, "Dcr Updated Successfully", true);
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
                stream: dcrDatabase.pagePosition,
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
          stream: dcrDatabase.pagePosition,
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

  List<Widget> _buildDcrDetailUI() {
    return [
      CustomTextFormField(
        label: "Lead Source",
        controller: dcrDatabase.leadSourceController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Call Status",
        required: true,
        streamList: dcrDatabase.callStatusList,
        valueListInit: dcrDatabase.callStatusListInit,
        onChanged: (params) {
          dcrDatabase.callStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Call Response",
        required: false,
        streamList: dcrDatabase.callResponseList,
        valueListInit: dcrDatabase.callResponseListInit,
        onChanged: (params) {
          dcrDatabase.callResponse(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Product",
        required: true,
        streamList: dcrDatabase.productList,
        valueListInit: dcrDatabase.productListInit,
        onChanged: (params) {
          dcrDatabase.product(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Priority",
        required: true,
        streamList: dcrDatabase.priorityList,
        valueListInit: dcrDatabase.priorityListInit,
        onChanged: (params) {
          dcrDatabase.priority(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Action",
        required: true,
        streamList: dcrDatabase.nextActionList,
        valueListInit: dcrDatabase.nextActionListInit,
        onChanged: (params) {
          dcrDatabase.nextAction(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Followup BY",
        required: true,
        streamList: dcrDatabase.nextFollowupByList,
        valueListInit: dcrDatabase.nextFollowupByListInit,
        onChanged: (params) {
          dcrDatabase.nextFollowupBy(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      StreamBuilder<String>(
          stream: dcrDatabase.nextFollowupDateInit,
          builder: (context, snapshot) {
            return CustomDateTimeTextFormField(
              label: "Next Followup",
              required: true,
              controller: TextEditingController(text: snapshot.data ?? ''),
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: dcrDatabase.nextFollowupDate.valueOrNull,
                    startDate: DateTime.now());
                TimeOfDay time = await PickDateTime.time(context);
                dcrDatabase.selectedNextFollowupDate(date, time, context);
                setState(() {});
              },
            );
          }),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support Required",
        required: false,
        streamList: dcrDatabase.supportRequiredList,
        valueListInit: dcrDatabase.supportRequiredListInit,
        onChanged: (params) {
          dcrDatabase.supportRequired(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support AM",
        required: false,
        streamList: dcrDatabase.supportAmList,
        valueListInit: dcrDatabase.supportAmListInit,
        onChanged: (params) {
          dcrDatabase.supportAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Field AM",
        required: false,
        streamList: dcrDatabase.fieldAmList,
        valueListInit: dcrDatabase.fieldAmListInit,
        onChanged: (params) {
          dcrDatabase.fieldAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Status",
        required: true,
        streamList: dcrDatabase.dbStatusList,
        valueListInit: dcrDatabase.dbStatusListInit,
        onChanged: (params) {
          dcrDatabase.dbStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: dcrDatabase.newCallRemarksController,
        maxLines: 3,
        required: true,
      ),
    ];
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: dcrDatabase.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: dcrDatabase.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: dcrDatabase.dbSourceList,
        valueListInit: dcrDatabase.dbSourceListInit,
        onChanged: (params) {
          dcrDatabase.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: dcrDatabase.industryList,
        valueListInit: dcrDatabase.industryListInit,
        onChanged: (params) {
          dcrDatabase.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: dcrDatabase.verticalList,
        valueListInit: dcrDatabase.verticalListInit,
        onChanged: (params) {
          dcrDatabase.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: dcrDatabase.subVerticalList,
        valueListInit: dcrDatabase.subVerticalListInit,
        onChanged: (params) {
          dcrDatabase.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: dcrDatabase.segmentList,
        valueListInit: dcrDatabase.segmentListInit,
        onChanged: (params) {
          dcrDatabase.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: dcrDatabase.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: dcrDatabase.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: dcrDatabase.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: dcrDatabase.existingRelationController,
        required: false,
      ),
      // Dimensions.kVerticalSpaceSmaller,
      // CustomTextFormField(
      //   label: "Remarks",
      //   controller: dcrDatabase.remarksController,
      //   required: false,
      //   maxLines: 3,
      // ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: dcrDatabase.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: dcrDatabase.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: dcrDatabase.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: dcrDatabase.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: dcrDatabase.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: dcrDatabase.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: dcrDatabase.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: dcrDatabase.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: dcrDatabase.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: dcrDatabase.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: dcrDatabase.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: dcrDatabase.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: dcrDatabase.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: dcrDatabase.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: dcrDatabase.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: dcrDatabase.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: dcrDatabase.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: dcrDatabase.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: dcrDatabase.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: dcrDatabase.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: dcrDatabase.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: dcrDatabase.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: dcrDatabase.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: dcrDatabase.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: dcrDatabase.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: dcrDatabase.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: dcrDatabase.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: dcrDatabase.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: dcrDatabase.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: dcrDatabase.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: dcrDatabase.cp3EmailController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildBody(position) {
    switch (position) {
      case 0:
        return _buildDcrDetailUI();
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
      dcrDatabase.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      dcrDatabase.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      dcrDatabase.onSubmit(context, widget.database);
    }
  }
}
