import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/ReportChanges.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/bloc/process_report/bloc.dart';
import 'package:spanticom/screens/form_penanganan.dart';
import 'package:spanticom/services/auth_service.dart';
import 'package:spanticom/theme/colors/light_colors.dart';
import 'package:spanticom/widgets/TampilanDialog.dart';

class ReportStatusChanger extends StatelessWidget {
  final UserReport theReport;
  const ReportStatusChanger(this.theReport, {super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthService>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: BlocConsumer<ProcessReportBloc, ProcessReportBlocState>(
          listener: (context, state) {
        if (state is ProcessReportBlocStateOnSuccess) {
          Get.back(result: true);
        }
      }, builder: (context, state) {
        if (state is ProcessReportBlocStateOnStarted) {
          return Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Status Laporan",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      theReport.status,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  if (authService.isAdmin && theReport.status != "done")
                    Container(
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: LightColors.kGreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          switch (theReport.status) {
                            case "waiting":
                              TampilanDialog.showDialogKonfirm(
                                      "Proses laporan?")
                                  .then((value) {
                                if (value) {
                                  BlocProvider.of<ProcessReportBloc>(context)
                                      .add(ProcessReportBlocStart(ReportChanges(
                                    reportId: theReport.id,
                                    statusChange: "active",
                                    noteChange: "",
                                  )));
                                }
                              });
                              break;
                            case "active":
                              TampilanDialog.showDialogKonfirm(
                                      "Selesaikan laporan?")
                                  .then((value) {
                                if (value) {
                                  Get.to(form_penanganan(),
                                          preventDuplicates: false)
                                      ?.then((value) {
                                    if (value != null) {
                                      BlocProvider.of<ProcessReportBloc>(
                                              context)
                                          .add(ProcessReportBlocStart(
                                              ReportChanges(
                                        reportId: theReport.id,
                                        statusChange: "done",
                                        noteChange: value,
                                      )));
                                    }
                                  });
                                }
                              });
                              break;
                          }
                        },
                        child: Center(
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ]),
            if (theReport.status == "done")
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: _doneNote(theReport),
              ),
          ],
        );
      }),
      decoration: BoxDecoration(
          color: Color(0xFFFDE5D4), borderRadius: BorderRadius.circular(30.0)),
    );
  }
}

class _doneNote extends StatelessWidget {
  final UserReport theReport;
  const _doneNote(this.theReport, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Catatan Penanganan",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            theReport.doneNote,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
