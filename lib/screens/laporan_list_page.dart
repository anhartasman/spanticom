import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/ReportFilter.dart';
import 'package:spanticom/bloc/user_report_list/bloc.dart';
import 'package:spanticom/injection_container.dart' as di;
import 'package:spanticom/screens/detail_laporan.dart';
import 'package:spanticom/theme/colors/Warna.dart';
import 'package:spanticom/theme/colors/light_colors.dart';
import 'package:spanticom/widgets/TampilanDialog.dart';
import 'package:spanticom/widgets/report_item.dart';

class laporan_list_page extends StatelessWidget {
  final String status;
  const laporan_list_page(this.status, {super.key});

  Text subheading(String title) {
    return Text(
      title,
      style: TextStyle(
          color: LightColors.kDarkBlue,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDE5D4),
      appBar: AppBar(
        title: const Text("Daftar Laporan"),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Color(0xFF072541),
      ), //A
      body: BlocProvider<UserReportListBloc>(
        create: (BuildContext context) => di.sl<UserReportListBloc>()
          ..add(UserReportListBlocRetrieve(ReportFilter(status: status))),
        child: SafeArea(
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: BlocConsumer<UserReportListBloc, UserReportListBlocState>(
                listener: (context, state) {
              if (state is UserReportListBlocStateOnError) {
                TampilanDialog.showDialogAlert(state.errorMessage);
              }
            }, builder: (BuildContext context, state) {
              if (state is UserReportListBlocStateOnStarted) {
                return Center(
                  child: SpinKitWave(
                    color: Warna.warnaUtama,
                    size: 50.0,
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.reportList.length,
                itemBuilder: (BuildContext context, int index) {
                  final theReport = state.reportList[index];
                  return InkWell(
                    onTap: () =>
                        Get.to(detail_laporan(theReport))?.then((value) {
                      if (value == true) {
                        Get.back();
                      }
                    }),
                    child: report_item(theReport),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
