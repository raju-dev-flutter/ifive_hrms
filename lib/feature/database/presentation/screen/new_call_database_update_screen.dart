import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class NewCallDatabaseUpdateScreen extends StatefulWidget {
  final DatabaseData database;

  const NewCallDatabaseUpdateScreen({super.key, required this.database});

  @override
  State<NewCallDatabaseUpdateScreen> createState() =>
      _NewCallDatabaseUpdateScreenState();
}

class _NewCallDatabaseUpdateScreenState
    extends State<NewCallDatabaseUpdateScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final newCallDatabase = sl<NewCallDatabaseUpdateStream>();

  @override
  void initState() {
    super.initState();
    newCallDatabase.fetchInitialCallBack(widget.database);
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
              Text("New call Database Update",
                  style: context.textTheme.headlineSmall),
              SizedBox(height: 2.h),
              StreamBuilder<String>(
                  stream: newCallDatabase.subTitle,
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
                stream: newCallDatabase.pagePosition,
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
                context, "NewCall Updated Successfully", true);
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
                stream: newCallDatabase.pagePosition,
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
          stream: newCallDatabase.pagePosition,
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

  List<Widget> _buildNewCallDetailUI() {
    return [
      CustomTextFormField(
        label: "Lead Source",
        controller: newCallDatabase.leadSourceController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Call Status",
        required: true,
        streamList: newCallDatabase.callStatusList,
        valueListInit: newCallDatabase.callStatusListInit,
        onChanged: (params) {
          newCallDatabase.callStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Call Response",
        required: false,
        streamList: newCallDatabase.callResponseList,
        valueListInit: newCallDatabase.callResponseListInit,
        onChanged: (params) {
          newCallDatabase.callResponse(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Product",
        required: true,
        streamList: newCallDatabase.productList,
        valueListInit: newCallDatabase.productListInit,
        onChanged: (params) {
          newCallDatabase.product(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Priority",
        required: true,
        streamList: newCallDatabase.priorityList,
        valueListInit: newCallDatabase.priorityListInit,
        onChanged: (params) {
          newCallDatabase.priority(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Action",
        required: true,
        streamList: newCallDatabase.nextActionList,
        valueListInit: newCallDatabase.nextActionListInit,
        onChanged: (params) {
          newCallDatabase.nextAction(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Followup BY",
        required: true,
        streamList: newCallDatabase.nextFollowupByList,
        valueListInit: newCallDatabase.nextFollowupByListInit,
        onChanged: (params) {
          newCallDatabase.nextFollowupBy(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      StreamBuilder<String>(
          stream: newCallDatabase.nextFollowupDateInit,
          builder: (context, snapshot) {
            return CustomDateTimeTextFormField(
              label: "Next Followup",
              required: true,
              controller: TextEditingController(text: snapshot.data ?? ''),
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: newCallDatabase.nextFollowupDate.valueOrNull,
                    startDate: DateTime.now());
                TimeOfDay time = await PickDateTime.time(context);
                newCallDatabase.selectedNextFollowupDate(date, time, context);
                setState(() {});
              },
            );
          }),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support Required",
        required: false,
        streamList: newCallDatabase.supportRequiredList,
        valueListInit: newCallDatabase.supportRequiredListInit,
        onChanged: (params) {
          newCallDatabase.supportRequired(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support AM",
        required: false,
        streamList: newCallDatabase.supportAmList,
        valueListInit: newCallDatabase.supportAmListInit,
        onChanged: (params) {
          newCallDatabase.supportAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Field AM",
        required: false,
        streamList: newCallDatabase.fieldAmList,
        valueListInit: newCallDatabase.fieldAmListInit,
        onChanged: (params) {
          newCallDatabase.fieldAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Status",
        required: true,
        streamList: newCallDatabase.dbStatusList,
        valueListInit: newCallDatabase.dbStatusListInit,
        onChanged: (params) {
          newCallDatabase.dbStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: newCallDatabase.newCallRemarksController,
        maxLines: 3,
        required: true,
      ),
    ];
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: newCallDatabase.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: newCallDatabase.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: newCallDatabase.dbSourceList,
        valueListInit: newCallDatabase.dbSourceListInit,
        onChanged: (params) {
          newCallDatabase.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: newCallDatabase.industryList,
        valueListInit: newCallDatabase.industryListInit,
        onChanged: (params) {
          newCallDatabase.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: newCallDatabase.verticalList,
        valueListInit: newCallDatabase.verticalListInit,
        onChanged: (params) {
          newCallDatabase.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: newCallDatabase.subVerticalList,
        valueListInit: newCallDatabase.subVerticalListInit,
        onChanged: (params) {
          newCallDatabase.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: newCallDatabase.segmentList,
        valueListInit: newCallDatabase.segmentListInit,
        onChanged: (params) {
          newCallDatabase.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: newCallDatabase.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: newCallDatabase.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: newCallDatabase.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: newCallDatabase.existingRelationController,
        required: false,
      ),
      // Dimensions.kVerticalSpaceSmaller,
      // CustomTextFormField(
      //   label: "Remarks",
      //   controller: newCallDatabase.remarksController,
      //   required: false,
      //   maxLines: 3,
      // ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: newCallDatabase.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: newCallDatabase.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: newCallDatabase.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: newCallDatabase.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: newCallDatabase.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: newCallDatabase.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: newCallDatabase.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: newCallDatabase.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: newCallDatabase.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: newCallDatabase.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: newCallDatabase.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: newCallDatabase.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: newCallDatabase.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: newCallDatabase.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: newCallDatabase.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: newCallDatabase.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: newCallDatabase.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: newCallDatabase.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: newCallDatabase.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: newCallDatabase.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: newCallDatabase.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: newCallDatabase.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: newCallDatabase.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: newCallDatabase.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: newCallDatabase.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: newCallDatabase.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: newCallDatabase.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: newCallDatabase.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: newCallDatabase.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: newCallDatabase.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: newCallDatabase.cp3EmailController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildBody(position) {
    switch (position) {
      case 0:
        return _buildNewCallDetailUI();
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
      newCallDatabase.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      newCallDatabase.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      newCallDatabase.onSubmit(context, widget.database);
    }
  }
}
