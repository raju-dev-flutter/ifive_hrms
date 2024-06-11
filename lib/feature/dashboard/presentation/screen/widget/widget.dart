import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../app/app.dart';
import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../feature.dart';

part 'dashboard_header_widget.dart';
part 'dashboard_attendance_status_widget.dart';
part 'dashboard_date_location_widget.dart';
part 'dashboard_services_widget.dart';
part 'dashboard_carousel_slider_widget.dart';
part 'today_leave_widget.dart';
part 'today_misspunch_widget.dart';
part 'today_odpermission_widget.dart';
part 'dashboard_leave_approval_screen.dart';
