import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/FamilyMember.dart';
import 'package:spanticom/bloc/family_evaluation_history/family_evaluation_history_bloc.dart';
import 'package:spanticom/bloc/family_evaluation_history/family_evaluation_history_bloc_event.dart';
import 'package:spanticom/bloc/family_evaluation_save/family_evaluation_save_bloc.dart';
import 'package:spanticom/bloc/family_member_detail/bloc.dart';
import 'package:spanticom/bloc/save_report/save_report_bloc.dart';
import 'package:spanticom/bloc/user_login/user_login_bloc.dart';
import 'package:spanticom/bloc/user_register/user_register_bloc.dart';
import 'package:spanticom/helpers/extensions/ext_string.dart';
import 'package:spanticom/injection_container.dart' as di;
import 'package:spanticom/middlewares/member_guard.dart';
import 'package:spanticom/routes/app_routes.dart';
import 'package:spanticom/screens/child_profile.dart';
import 'package:spanticom/screens/evaluation_history.dart';
import 'package:spanticom/screens/form_evaluation.dart';
import 'package:spanticom/screens/form_laporan.dart';
import 'package:spanticom/screens/form_register.dart';
import 'package:spanticom/screens/home_page.dart';
import 'package:spanticom/screens/login_admin.dart';
import 'package:spanticom/screens/report_evaluation.dart';
import 'package:spanticom/screens/ruang_admin_page.dart';
import 'package:spanticom/screens/splash_screen.dart';

final appPages = [
  GetPage(
    name: Routes.homeRoute,
    page: () => splash_screen(),
  ),
  GetPage(
    name: Routes.homeMenuRoute,
    page: () {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor:
      //       LightColors.kLightYellow, // navigation bar color
      //   statusBarColor: Warna.warnaUtama, // status bar color
      // ));
      return HomePage();
    },
    middlewares: [
      MemberGuard(), // Add the middleware here
    ],
  ),
  GetPage(
    name: Routes.adminPageRoute,
    page: () {
      return ruang_admin_page();
    },
    middlewares: [
      MemberGuard(), // Add the middleware here
    ],
  ),
  GetPage(
    name: Routes.authLoginRoute,
    page: () => BlocProvider<UserLoginBloc>(
        create: (BuildContext context) => di.sl<UserLoginBloc>(),
        child: login_admin()),
  ),
  GetPage(
    name: Routes.authRegisterRoute,
    page: () => BlocProvider<UserRegisterBloc>(
        create: (BuildContext context) => di.sl<UserRegisterBloc>(),
        child: form_register()),
  ),
  GetPage(
    name: Routes.formReportRoute,
    page: () => BlocProvider<SaveReportBloc>(
      create: (BuildContext context) => di.sl<SaveReportBloc>(),
      child: form_laporan(),
    ),
  ),
  GetPage(
    name: Routes.formEvaluationRoute,
    page: () {
      final childId = Get.arguments["childId"];
      return BlocProvider<FamilyEvaluationSaveBloc>(
        create: (BuildContext context) => di.sl<FamilyEvaluationSaveBloc>(),
        child: form_evaluation(
          childId: childId,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.reportEvaluationRoute,
    page: () {
      FamilyMember theChild = Get.arguments;
      return MultiBlocProvider(
        providers: [
          BlocProvider<FamilyEvaluationSaveBloc>(
              create: (BuildContext context) =>
                  di.sl<FamilyEvaluationSaveBloc>()),
        ],
        child: report_evaluation(
          theChild: theChild,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.evaluationHistoryRoute,
    page: () {
      final childId = Get.arguments["childId"];
      final firstDate = Get.arguments["firstDate"] as DateTime;
      final lastDate = Get.arguments["lastDate"] as DateTime;
      print("search childId $childId");
      print("search firstDate $firstDate");
      print("search lastDate $lastDate");
      return MultiBlocProvider(
        providers: [
          BlocProvider<FamilyEvaluationHistoryBloc>(
              create: (BuildContext context) =>
                  di.sl<FamilyEvaluationHistoryBloc>()
                    ..add(FamilyEvaluationHistoryBlocStart(
                      firstDate.toTanggal("yyyy-MM-dd"),
                      lastDate.toTanggal("yyyy-MM-dd"),
                      childId,
                    ))),
        ],
        child: evaluation_history(
          childId: childId,
          firstDate: firstDate,
          lastDate: lastDate,
        ),
      );
    },
  ),
  GetPage(
    name: Routes.detailChildRoute,
    page: () {
      final id = Get.arguments["id"];
      final cardColor = Get.arguments["cardColor"] as Color;
      final circleColor = Get.arguments["circleColor"] as Color;
      return BlocProvider<FamilyMemberDetailBloc>(
        create: (BuildContext context) => di.sl<FamilyMemberDetailBloc>()
          ..add(FamilyMemberDetailBlocRetrieve(id)),
        child: child_profile(
          cardColor: cardColor,
          circleColor: circleColor,
        ),
      );
    },
  ),
];
