import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../database.dart';

class PipelineDatabaseUpdateScreen extends StatefulWidget {
  final DatabaseData database;

  const PipelineDatabaseUpdateScreen({super.key, required this.database});

  @override
  State<PipelineDatabaseUpdateScreen> createState() =>
      _PipelineDatabaseUpdateScreenState();
}

class _PipelineDatabaseUpdateScreenState
    extends State<PipelineDatabaseUpdateScreen> with InputValidationMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final pipelineDatabase = sl<PipelineDatabaseUpdateStream>();

  @override
  void initState() {
    super.initState();
    pipelineDatabase.fetchInitialCallBack(widget.database);
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
              Text("Pipeline Database Update",
                  style: context.textTheme.headlineSmall),
              SizedBox(height: 2.h),
              StreamBuilder<String>(
                  stream: pipelineDatabase.subTitle,
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
                stream: pipelineDatabase.pagePosition,
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
                context, "Pipeline Updated Successfully", true);
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
                stream: pipelineDatabase.pagePosition,
                builder: (context, snapshot) {
                  final position = snapshot.hasData ? snapshot.data ?? 0 : 0;
                  return Column(
                    children: [
                      Column(children: _buildBody(position)),
                      Dimensions.kVerticalSpaceMedium,
                      StreamBuilder<int>(
                          stream: pipelineDatabase.pagePosition,
                          builder: (_, snapshot) {
                            final count =
                                snapshot.hasData ? snapshot.data ?? 0 : 0;
                            return TicketBottomActionButton(
                              position: count,
                              lastPosition: 7,
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
      //     stream: pipelineDatabase.pagePosition,
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

  List<Widget> _buildPipelineDetailUI() {
    return [
      CustomTextFormField(
        label: "Scope",
        controller: pipelineDatabase.scopeController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Price (in Lakhs)",
        controller: pipelineDatabase.priceInLakhsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "I5 Winning Prob.(%)",
        required: true,
        streamList: pipelineDatabase.winningProbList,
        valueListInit: pipelineDatabase.winningProbListInit,
        onChanged: (params) {
          pipelineDatabase.winningProb(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Stage",
        required: false,
        streamList: pipelineDatabase.stageList,
        valueListInit: pipelineDatabase.stageListInit,
        onChanged: (params) {
          pipelineDatabase.stage(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Status",
        required: false,
        streamList: pipelineDatabase.statusList,
        valueListInit: pipelineDatabase.statusListInit,
        onChanged: (params) {
          pipelineDatabase.status(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Product",
        required: true,
        streamList: pipelineDatabase.productList,
        valueListInit: pipelineDatabase.productListInit,
        onChanged: (params) {
          pipelineDatabase.product(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Priority",
        required: true,
        streamList: pipelineDatabase.priorityList,
        valueListInit: pipelineDatabase.priorityListInit,
        onChanged: (params) {
          pipelineDatabase.priority(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Action",
        required: true,
        streamList: pipelineDatabase.nextActionList,
        valueListInit: pipelineDatabase.nextActionListInit,
        onChanged: (params) {
          pipelineDatabase.nextAction(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Next Followup BY",
        required: true,
        streamList: pipelineDatabase.nextFollowupByList,
        valueListInit: pipelineDatabase.nextFollowupByListInit,
        onChanged: (params) {
          pipelineDatabase.nextFollowupBy(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      StreamBuilder<String>(
          stream: pipelineDatabase.nextFollowupDateInit,
          builder: (context, snapshot) {
            return CustomDateTimeTextFormField(
              label: "Next Followup",
              required: true,
              controller: TextEditingController(text: snapshot.data ?? ''),
              onPressed: () async {
                DateTime date = await PickDateTime.date(context,
                    selectedDate: pipelineDatabase.nextFollowupDate.valueOrNull,
                    startDate: DateTime.now());
                TimeOfDay time = await PickDateTime.time(context);
                pipelineDatabase.selectedNextFollowupDate(date, time, context);
                setState(() {});
              },
            );
          }),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support Required",
        required: false,
        streamList: pipelineDatabase.supportRequiredList,
        valueListInit: pipelineDatabase.supportRequiredListInit,
        onChanged: (params) {
          pipelineDatabase.supportRequired(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Support AM",
        required: false,
        streamList: pipelineDatabase.supportAmList,
        valueListInit: pipelineDatabase.supportAmListInit,
        onChanged: (params) {
          pipelineDatabase.supportAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Field AM",
        required: false,
        streamList: pipelineDatabase.fieldAmList,
        valueListInit: pipelineDatabase.fieldAmListInit,
        onChanged: (params) {
          pipelineDatabase.fieldAm(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Status",
        required: true,
        streamList: pipelineDatabase.dbStatusList,
        valueListInit: pipelineDatabase.dbStatusListInit,
        onChanged: (params) {
          pipelineDatabase.dbStatus(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Customer Visit/Demo",
        required: false,
        streamList: pipelineDatabase.customerVisitList,
        valueListInit: pipelineDatabase.customerVisitListInit,
        onChanged: (params) {
          pipelineDatabase.customerVisit(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        controller: pipelineDatabase.newCallRemarksController,
        maxLines: 3,
        required: true,
      ),
    ];
  }

  List<Widget> _buildCompanyDetailUI() {
    return [
      CustomTextFormField(
        label: "Customer Name",
        controller: pipelineDatabase.customerNameController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Gst No",
        controller: pipelineDatabase.gstNoController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "DB Source",
        required: true,
        streamList: pipelineDatabase.dbSourceList,
        valueListInit: pipelineDatabase.dbSourceListInit,
        onChanged: (params) {
          pipelineDatabase.dbSource(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Industry",
        required: true,
        streamList: pipelineDatabase.industryList,
        valueListInit: pipelineDatabase.industryListInit,
        onChanged: (params) {
          pipelineDatabase.industry(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Vertical",
        required: true,
        streamList: pipelineDatabase.verticalList,
        valueListInit: pipelineDatabase.verticalListInit,
        onChanged: (params) {
          pipelineDatabase.vertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Sub Vertical",
        required: true,
        streamList: pipelineDatabase.subVerticalList,
        valueListInit: pipelineDatabase.subVerticalListInit,
        onChanged: (params) {
          pipelineDatabase.subVertical(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomStreamDropDownWidget(
        label: "Segment",
        required: true,
        streamList: pipelineDatabase.segmentList,
        valueListInit: pipelineDatabase.segmentListInit,
        onChanged: (params) {
          pipelineDatabase.segment(params);
          setState(() {});
        },
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Employee",
        controller: pipelineDatabase.noOfEmployeeController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Turn Over (in Crs.)",
        controller: pipelineDatabase.turnOverController,
        required: true,
        keyboardType: TextInputType.number,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Custom Products",
        controller: pipelineDatabase.customProductsController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Existing Relation",
        controller: pipelineDatabase.existingRelationController,
        required: false,
      ),
      // Dimensions.kVerticalSpaceSmaller,
      // CustomTextFormField(
      //   label: "Remarks",
      //   controller: pipelineDatabase.remarksController,
      //   required: false,
      //   maxLines: 3,
      // ),
    ];
  }

  List<Widget> _buildAddressDetailUI() {
    return [
      CustomTextFormField(
        label: "State",
        controller: pipelineDatabase.stateController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "City",
        controller: pipelineDatabase.cityController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Area",
        controller: pipelineDatabase.areaController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Address",
        controller: pipelineDatabase.addressController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Pincode",
        controller: pipelineDatabase.pinCodeController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Website",
        controller: pipelineDatabase.websiteController,
        required: true,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Phone Number",
        controller: pipelineDatabase.phoneNumberController,
        required: true,
      ),
    ];
  }

  List<Widget> _buildExistingSoftwareDetailUI() {
    return <Widget>[
      CustomTextFormField(
        label: "Current Software",
        controller: pipelineDatabase.currentSoftwareController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "No. Of Users",
        controller: pipelineDatabase.noOfUsersController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Procurement Year",
        controller: pipelineDatabase.procurementYearController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildKeyContactDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: pipelineDatabase.kNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: pipelineDatabase.kNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: pipelineDatabase.kDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: pipelineDatabase.kEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: pipelineDatabase.kWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: pipelineDatabase.kLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildDecisionMakerDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: pipelineDatabase.dNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Number",
        controller: pipelineDatabase.dNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: pipelineDatabase.dDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: pipelineDatabase.dEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: pipelineDatabase.dWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Linkedin/FB Id",
        controller: pipelineDatabase.dLinkedinController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildFieldActivityDetailUI() {
    return [
      CustomTextFormField(
        label: "Name",
        controller: pipelineDatabase.fNameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Mobile Number",
        controller: pipelineDatabase.fNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Design & Dept",
        controller: pipelineDatabase.fDesignDeptController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "E-Mail Id",
        controller: pipelineDatabase.fEmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Whatsapp Number",
        controller: pipelineDatabase.fWhatsappNumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "Remarks",
        maxLines: 4,
        controller: pipelineDatabase.fRemarksController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildOtherContactPersonDetailUI() {
    return [
      CustomTextFormField(
        label: "CP1-Name/ Design/ Dept",
        controller: pipelineDatabase.cp1NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Number",
        controller: pipelineDatabase.cp1NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP1-Email",
        controller: pipelineDatabase.cp1EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Name/ Design/ Dept",
        controller: pipelineDatabase.cp2NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Number",
        controller: pipelineDatabase.cp2NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP2-Email",
        controller: pipelineDatabase.cp2EmailController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Name/ Design/ Dept",
        controller: pipelineDatabase.cp3NameController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Number",
        controller: pipelineDatabase.cp3NumberController,
        required: false,
      ),
      Dimensions.kVerticalSpaceSmaller,
      CustomTextFormField(
        label: "CP3-Email",
        controller: pipelineDatabase.cp3EmailController,
        required: false,
      ),
    ];
  }

  List<Widget> _buildBody(position) {
    switch (position) {
      case 0:
        return _buildPipelineDetailUI();
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
        return _buildFieldActivityDetailUI();
      case 7:
        return _buildOtherContactPersonDetailUI();
    }
    return <Widget>[];
  }

  void onBack() {
    if (_formKey.currentState!.validate()) {
      pipelineDatabase.backPage();
    }
  }

  void onNext() {
    if (_formKey.currentState!.validate()) {
      pipelineDatabase.nextPage();
    }
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      pipelineDatabase.onSubmit(context, widget.database);
    }
  }
}
