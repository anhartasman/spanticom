import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/bloc/member_info/bloc.dart';
import 'package:spanticom/bloc/process_report/bloc.dart';
import 'package:spanticom/dates_list.dart';
import 'package:spanticom/helpers/extensions/ext_string.dart';
import 'package:spanticom/theme/colors/Warna.dart';
import 'package:spanticom/theme/colors/light_colors.dart';
import 'package:spanticom/widgets/ReportStatusChanger.dart';
import 'package:spanticom/widgets/calendar_dates.dart';
import 'package:spanticom/widgets/task_container.dart';
import 'package:spanticom/screens/create_new_task_page.dart';
import 'package:spanticom/widgets/back_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:spanticom/injection_container.dart' as di;

class detail_laporan extends StatelessWidget {
  final UserReport theReport;
  const detail_laporan(this.theReport, {super.key});

  Widget _dashedText() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Text(
        '------------------------------------------',
        maxLines: 1,
        style:
            TextStyle(fontSize: 20.0, color: Colors.black12, letterSpacing: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MemberInfoBloc>(
            create: (BuildContext context) => di.sl<MemberInfoBloc>()
              ..add(MemberInfoBlocRetrieve(theReport.userId))),
        BlocProvider<ProcessReportBloc>(
            create: (BuildContext context) => di.sl<ProcessReportBloc>()),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFFD6CC99),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              0,
            ),
            child: ListView(
              children: <Widget>[
                MyBackButton(),
                SizedBox(height: 30.0),
                _StudentInfo(
                  name: theReport.name,
                  className: theReport.className,
                  phoneNumber: theReport.phone,
                ),
                _ReportDetail(theReport),
                ReportStatusChanger(theReport),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentInfo extends StatelessWidget {
  final String name;
  final String className;
  final String phoneNumber;

  _StudentInfo({
    required this.name,
    required this.className,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Info Siswa",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Nama : $name",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Kelas : $className",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: LightColors.kGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final Uri telLaunchUri = Uri(
                        scheme: 'tel',
                        path: phoneNumber,
                      );
                      launchUrl(telLaunchUri);
                    },
                    child: Center(
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xFF001524), borderRadius: BorderRadius.circular(30.0)),
    );
  }
}

class _ReporterInfo extends StatelessWidget {
  final String memberId;

  _ReporterInfo({
    required this.memberId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<MemberInfoBloc, MemberInfoBlocState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MemberInfoBlocStateOnStarted) {
              return Center(
                child: SpinKitWave(
                  color: Colors.white,
                  size: 50.0,
                ),
              );
            }
            if (state is MemberInfoBlocStateOnSuccess) {
              final memberInfo = state.memberInfo;
              final phoneNumber = memberInfo.userPhone;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Info Pelapor",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Nama : ${memberInfo.userName}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Email : ${memberInfo.userEmail}",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            phoneNumber,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: LightColors.kGreen,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              final Uri telLaunchUri = Uri(
                                scheme: 'tel',
                                path: phoneNumber,
                              );
                              launchUrl(telLaunchUri);
                            },
                            child: Center(
                              child: Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ],
              );
            }
            return Container();
          }),
      decoration: BoxDecoration(
          color: Color(0xFF445D48), borderRadius: BorderRadius.circular(30.0)),
    );
  }
}

class _ReportDetail extends StatelessWidget {
  final UserReport theReport;

  _ReportDetail(this.theReport);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Isi Laporan",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            theReport.dateTime.toTanggal("dd MMMM yyyy"),
            style: TextStyle(
              fontSize: 11.0,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              theReport.report,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _ReporterInfo(
              memberId: theReport.userId,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xFF445D48), borderRadius: BorderRadius.circular(30.0)),
    );
  }
}
