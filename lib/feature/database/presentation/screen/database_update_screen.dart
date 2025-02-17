import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class DatabaseUpdateScreen extends StatefulWidget {
  final DatabaseData database;

  const DatabaseUpdateScreen({super.key, required this.database});

  @override
  State<DatabaseUpdateScreen> createState() => _DatabaseUpdateScreenState();
}

class _DatabaseUpdateScreenState extends State<DatabaseUpdateScreen>
    with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final databaseUpdate = sl<DatabaseUpdateStream>();

  @override
  void initState() {
    super.initState();
    databaseUpdate.fetchInitialCallBack(widget.database);
    setState(() {});
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
                  stream: databaseUpdate.subTitle,
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
                stream: databaseUpdate.pagePosition,
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
                context, "Generate Ticket Successfully", true);
          }
          if (state is SfaCrudFailed) {
            AppAlerts.displaySnackBar(context, state.message, false);
          }
        },
        child: StreamBuilder<bool>(
            stream: databaseUpdate.pageLoading,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: Dimensions.kPaddingAllMedium,
                    child: StreamBuilder<int>(
                      stream: databaseUpdate.pagePosition,
                      builder: (context, snapshot) {
                        final position =
                            snapshot.hasData ? snapshot.data ?? 0 : 0;
                        return Column(
                          children: [
                            Column(children: _buildBody(position)),
                            Dimensions.kVerticalSpaceMedium,
                            StreamBuilder<int>(
                                stream: databaseUpdate.pagePosition,
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
              );
            }),
      ),
      // bottomNavigationBar: StreamBuilder<int>(
      //     stream: databaseUpdate.pagePosition,
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
        controller: databaseUpdate.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: databaseUpdate.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        initialData: widget.database.companyDbSourceName,
        streamList: databaseUpdate.dbSourceList,
        valueListInit: databaseUpdate.dbSourceListInit,
        onChanged: (params) {
          databaseUpdate.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        initialData: widget.database.companyIndustryName,
        streamList: databaseUpdate.industryList,
        valueListInit: databaseUpdate.industryListInit,
        onChanged: (params) {
          databaseUpdate.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        initialData: widget.database.companyVerticalName,
        streamList: databaseUpdate.verticalList,
        valueListInit: databaseUpdate.verticalListInit,
        onChanged: (params) {
          databaseUpdate.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        initialData: widget.database.companySubVerticalName,
        streamList: databaseUpdate.subVerticalList,
        valueListInit: databaseUpdate.subVerticalListInit,
        onChanged: (params) {
          databaseUpdate.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        initialData: widget.database.companySegmentName,
        streamList: databaseUpdate.segmentList,
        valueListInit: databaseUpdate.segmentListInit,
        onChanged: (params) {
          databaseUpdate.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: databaseUpdate.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: databaseUpdate.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: databaseUpdate.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: databaseUpdate.existingRelationController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: databaseUpdate.remarksController,
        required: false,
        maxLines: 3,
      ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      // CustomTextFormField(
      //   label: "State",
      //   controller: databaseUpdate.stateController,
      //   required: true,
      // ),
      // Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: databaseUpdate.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: databaseUpdate.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: databaseUpdate.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: databaseUpdate.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: databaseUpdate.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: databaseUpdate.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: databaseUpdate.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: databaseUpdate.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: databaseUpdate.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: databaseUpdate.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: databaseUpdate.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: databaseUpdate.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: databaseUpdate.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: databaseUpdate.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: databaseUpdate.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: databaseUpdate.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: databaseUpdate.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: databaseUpdate.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: databaseUpdate.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: databaseUpdate.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: databaseUpdate.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildFieldActivityDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: databaseUpdate.fNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Mobile Number",
        controller: databaseUpdate.fNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: databaseUpdate.fDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: databaseUpdate.fEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: databaseUpdate.fWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        maxLines: 4,
        controller: databaseUpdate.fRemarksController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: databaseUpdate.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: databaseUpdate.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: databaseUpdate.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: databaseUpdate.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: databaseUpdate.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: databaseUpdate.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: databaseUpdate.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: databaseUpdate.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: databaseUpdate.cp3EmailController,
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
    }
    return <Widget>[];
  }

  void onBack() {
    if (_formKey.currentState!.validate()) {
      databaseUpdate.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      databaseUpdate.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      databaseUpdate.onSubmit(context, widget.database);
    }
  }
}
