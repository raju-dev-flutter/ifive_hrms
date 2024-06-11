import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../config/config.dart';

import '../../../../core/core.dart';
import '../../payroll.dart';

class PayrollDetailsScreen extends StatefulWidget {
  final String paySlipId;

  const PayrollDetailsScreen({super.key, required this.paySlipId});

  @override
  State<PayrollDetailsScreen> createState() => _PayrollDetailsScreenState();
}

class _PayrollDetailsScreenState extends State<PayrollDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();

  @override
  void initState() {
    super.initState();
    initialCallBack();
  }

  void initialCallBack() {
    BlocProvider.of<PaySlipDocumentCubit>(context)
        .paySlipDocument(widget.paySlipId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size(context.deviceSize.width, 52.h),
        child: CustomAppBar(
            onPressed: () => Navigator.pop(context), title: "Payslip"),
      ),
      body: BlocBuilder<PaySlipDocumentCubit, PaySlipDocumentState>(
        builder: (context, state) {
          if (state is PaySlipDocumentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PaySlipDocumentLoaded) {
            Logger().i(state.payroll.url ?? '');
            return Stack(
              children: [
                PDF(
                  enableSwipe: true,
                  swipeHorizontal: true,
                  autoSpacing: false,
                  pageFling: false,
                  onPageChanged: (int? current, int? total) =>
                      _pageCountController.add('${current! + 1} - $total'),
                  onViewCreated: (PDFViewController pdfViewController) async {
                    _pdfViewController.complete(pdfViewController);
                    final int currentPage =
                        await pdfViewController.getCurrentPage() ?? 0;
                    final int? pageCount =
                        await pdfViewController.getPageCount();
                    _pageCountController.add('${currentPage + 1} - $pageCount');
                  },
                ).cachedFromUrl(
                  state.payroll.url ?? '',
                  placeholder: (double progress) =>
                      Center(child: Text('$progress %')),
                  errorWidget: (dynamic error) =>
                      Center(child: Text(error.toString())),
                ),
              ],
            );
          }
          return Container();
        },
      ),
      floatingActionButton:
          BlocBuilder<PaySlipDocumentCubit, PaySlipDocumentState>(
        builder: (context, state) {
          if (state is PaySlipDocumentLoaded) {
            return FloatingActionButton(
              backgroundColor: appColor.brand800,
              child: const Icon(Icons.download),
              onPressed: () async {
                download(state.payroll.url ?? '');
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  Future download(String url) async {
    Logger().i('Url: $url');
    final fileName = url.split('/').last;

    try {
      // Fetch the file
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        // Save the file to the downloads directory
        var bytes = await consolidateHttpClientResponseBytes(response);
        final downloadDirectory = await getDownloadsDirectory();
        final filePath = '${downloadDirectory!.path}/$fileName';
        File file = File(filePath);
        await file.writeAsBytes(bytes);
        // Show download notification
        showDownloadNotification(filePath);
      } else {
        throw Exception('Failed to download PDF: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to download PDF: $e');
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      debugPrint((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  Future<void> showDownloadNotification(String filePath) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'ifive',
      'IFive Importance Notifications',
      importance: Importance.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download Completed',
      filePath,
      // 'Payslip downloaded successfully',
      platformChannelSpecifics,
      payload: filePath,
    );
  }
}
