import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class GenerateTicketScreen extends StatefulWidget {
  const GenerateTicketScreen({super.key});

  @override
  State<GenerateTicketScreen> createState() => _GenerateTicketScreenState();
}

class _GenerateTicketScreenState extends State<GenerateTicketScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<int, bool> _isExpanded = {};

  final generateTicket = sl<GenerateTicketStream>();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 7; i++) {
      _isExpanded[i] = true;
      // _isExpanded[i] = i == 0 ? true : false;
    }
    generateTicket.fetchInitialCallBack();
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
              Text("Generate Ticket", style: context.textTheme.headlineSmall),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size(context.deviceSize.width, 1.h),
            child: LinearProgressIndicator(
              minHeight: 1.h,
              value: 1,
              backgroundColor: appColor.blue100,
              color: appColor.blue100,
            ),
          ),
        ),
      ),
      body: BlocListener<SfaCrudBloc, SfaCrudState>(
        listener: (context, state) {
          if (state is SfaCrudSuccess) {
            Navigator.pop(context);
            AppAlerts.displaySnackBar(
                context, "Generate Ticket Successfully", true);
          }
          if (state is SfaCrudFailed) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(children: _buildBody()),
                Dimensions.kVerticalSpaceMedium,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ActionButton(
                    color: appColor.success600,
                    onPressed: onSubmit,
                    child: Text(
                      "Submit",
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: appColor.white),
                    ),
                  ),
                ),
                Dimensions.kVerticalSpaceLargest,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onBack() {
    if (_formKey.currentState!.validate()) {
      generateTicket.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      generateTicket.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      generateTicket.onSubmit(context);
    }
  }

  List<Widget> _buildBody() {
    return List.generate(7, (index) {
      return ExpansionPanelList(
        elevation: 0,
        expandIconColor: appColor.brand600,
        expandedHeaderPadding: Dimensions.kPaddingZero,
        expansionCallback: (int i, bool isExpanded) {
          _isExpanded[index] = isExpanded;
          // _isExpanded[index] = !_isExpanded[index]!;
          setState(() {});
        },
        children: [
          ExpansionPanel(
            backgroundColor: appColor.gray50,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                iconColor: appColor.brand600,
                title: Text(
                  _getSectionTitle(index),
                  style: context.textTheme.titleLarge
                      ?.copyWith(color: appColor.brand600),
                ),
                selectedColor: appColor.brand600,
              );
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _getSectionContent(index),
            ),
            isExpanded: _isExpanded[index] ?? false,
          ),
        ],
      );
    });
  }

  String _getSectionTitle(int position) {
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
        return "Field Activity Details";
      case 6:
        return "Other Contact Person Details";
      default:
        return "Unknown Section";
    }
  }

  Widget _getSectionContent(int position) {
    switch (position) {
      case 0:
        return Column(children: _buildCompanyDetailUI());
      case 1:
        return Column(children: _buildAddressDetailUI());
      case 2:
        return Column(children: _buildExistingSoftwareDetailUI());
      case 3:
        return Column(children: _buildKeyContactDetailUI());
      case 4:
        return Column(children: _buildDecisionMakerDetailUI());
      case 5:
        return Column(children: _buildFieldActivityDetailUI());
      case 6:
        return Column(children: _buildOtherContactPersonDetailUI());
      default:
        return Container();
    }
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: generateTicket.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: generateTicket.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: generateTicket.dbSourceList,
        valueListInit: generateTicket.dbSourceListInit,
        onChanged: (params) {
          generateTicket.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: generateTicket.industryList,
        valueListInit: generateTicket.industryListInit,
        onChanged: (params) {
          generateTicket.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: generateTicket.verticalList,
        valueListInit: generateTicket.verticalListInit,
        onChanged: (params) {
          generateTicket.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: generateTicket.subVerticalList,
        valueListInit: generateTicket.subVerticalListInit,
        onChanged: (params) {
          generateTicket.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: generateTicket.segmentList,
        valueListInit: generateTicket.segmentListInit,
        onChanged: (params) {
          generateTicket.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: generateTicket.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: generateTicket.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: generateTicket.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: generateTicket.existingRelationController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: generateTicket.remarksController,
        required: false,
        maxLines: 3,
      ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: generateTicket.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: generateTicket.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: generateTicket.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: generateTicket.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: generateTicket.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: generateTicket.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: generateTicket.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: generateTicket.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: generateTicket.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: generateTicket.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: generateTicket.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: generateTicket.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: generateTicket.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: generateTicket.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildFieldActivityDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.fNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Mobile Number",
        controller: generateTicket.fNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.fDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.fEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.fWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        maxLines: 4,
        controller: generateTicket.fRemarksController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: generateTicket.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: generateTicket.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: generateTicket.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: generateTicket.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: generateTicket.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: generateTicket.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: generateTicket.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: generateTicket.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: generateTicket.cp3EmailController,
        required: false,
      ),
    ];
  }
}

/*
class _GenerateTicketScreenState extends State<GenerateTicketScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final generateTicket = sl<GenerateTicketStream>();

  @override
  void initState() {
    super.initState();
    generateTicket.fetchInitialCallBack();
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
              Text("Generate Ticket", style: context.textTheme.headlineSmall),
              SizedBox(height: 2.h),
              StreamBuilder<String>(
                  stream: generateTicket.subTitle,
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
                stream: generateTicket.pagePosition,
                builder: (context, snapshot) {
                  final count = snapshot.hasData ? snapshot.data ?? 0 : 0;
                  return LinearProgressIndicator(
                    minHeight: 5.h,
                    value: count / 6,
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
                context, "Generate Ticket Successfully", true);
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
                stream: generateTicket.pagePosition,
                builder: (context, snapshot) {
                  final position = snapshot.hasData ? snapshot.data ?? 0 : 0;
                  return Column(
                    children: [
                      Column(children: _buildBody(position)),
                      Dimensions.kVerticalSpaceMedium,
                      StreamBuilder<int>(
                          stream: generateTicket.pagePosition,
                          builder: (_, snapshot) {
                            final count =
                                snapshot.hasData ? snapshot.data ?? 0 : 0;
                            return TicketBottomActionButton(
                              position: count,
                              lastPosition: 6,
                              onPressedBack: onBack,
                              onPressedNext: onNext,
                              onPressedSubmit: onSubmit,
                            );
                          }),
                      Dimensions.kVerticalSpaceLargest,
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: StreamBuilder<int>(
      //     stream: generateTicket.pagePosition,
      //     builder: (_, snapshot) {
      //       final count = snapshot.hasData ? snapshot.data ?? 0 : 0;
      //       return TicketBottomActionButton(
      //         position: count,
      //         onPressedBack: onBack,
      //         onPressedNext: onNext,
      //         onPressedSubmit: onSubmit,
      //       );
      //     }),
    );
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: generateTicket.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: generateTicket.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: generateTicket.dbSourceList,
        valueListInit: generateTicket.dbSourceListInit,
        onChanged: (params) {
          generateTicket.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: generateTicket.industryList,
        valueListInit: generateTicket.industryListInit,
        onChanged: (params) {
          generateTicket.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: generateTicket.verticalList,
        valueListInit: generateTicket.verticalListInit,
        onChanged: (params) {
          generateTicket.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: generateTicket.subVerticalList,
        valueListInit: generateTicket.subVerticalListInit,
        onChanged: (params) {
          generateTicket.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: generateTicket.segmentList,
        valueListInit: generateTicket.segmentListInit,
        onChanged: (params) {
          generateTicket.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: generateTicket.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: generateTicket.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: generateTicket.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: generateTicket.existingRelationController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: generateTicket.remarksController,
        required: false,
        maxLines: 3,
      ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: generateTicket.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: generateTicket.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: generateTicket.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: generateTicket.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: generateTicket.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: generateTicket.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: generateTicket.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: generateTicket.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: generateTicket.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: generateTicket.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: generateTicket.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: generateTicket.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: generateTicket.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: generateTicket.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildFieldActivityDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: generateTicket.fNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Mobile Number",
        controller: generateTicket.fNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: generateTicket.fDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: generateTicket.fEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: generateTicket.fWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        maxLines: 4,
        controller: generateTicket.fRemarksController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: generateTicket.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: generateTicket.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: generateTicket.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: generateTicket.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: generateTicket.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: generateTicket.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: generateTicket.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: generateTicket.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: generateTicket.cp3EmailController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildBody(position) {
    switch (position) {
      case 0:
        return _buildCompanyDetailUI();
      case 1:
        return _buildAddressDetailUI();
      case 2:
        return _buildExistingSoftwareDetailUI();
      case 3:
        return _buildKeyContactDetailUI();
      case 4:
        return _buildDecisionMakerDetailUI();
      case 5:
        return _buildFieldActivityDetailUI();
      case 6:
        return _buildOtherContactPersonDetailUI();
      default:
        return <Widget>[];
    }
  }

  void onBack() {
    if (_formKey.currentState!.validate()) {
      generateTicket.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      generateTicket.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      generateTicket.onSubmit(context);
    }
  }
}
*/
