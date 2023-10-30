import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/ReportChanges.dart';
import 'package:spanticom/architectures/domain/entities/ReportFilter.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/helpers/extensions/ext_string.dart';
import 'package:spanticom/services/auth_service.dart';

class ReportRemoteDataSource {
  static Future<List<UserReport>> reportList(ReportFilter theFilter) async {
    List<UserReport> reportList = [];
    final authService = Get.find<AuthService>();
    CollectionReference col = FirebaseFirestore.instance.collection('report');
    Query nameQuery = col.where(
      "status",
      isEqualTo: theFilter.status,
    );
    if (!authService.isAdmin) {
      debugPrint("Cari berdasarkan userId " + authService.theUser!.id);
      nameQuery = nameQuery.where(
        "userId",
        isEqualTo: authService.theUser!.id,
      );
    }

    final QuerySnapshot result = await nameQuery.get();

    result.docs.forEach((element) async {
      var theData = element.data() as Map<String, dynamic>;
      debugPrint("Parsing: " + jsonEncode(theData));

      String report = theData["report"];
      reportList.add(UserReport(
        id: element.id,
        dateTime: DateTime.parse(theData["dateTime"]),
        userId: theData["userId"],
        name: theData["name"],
        email: theData["email"],
        doneNote: theData["doneNote"] ?? "",
        phone: theData["phone"],
        status: theData["status"],
        className: theData["className"],
        report: report.replaceAll("\\n", "\n"),
      ));
    });

    return reportList;
  }

  static Future<void> saveReport(UserReport theReport) async {
    final databaseReference = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Map<String, dynamic> reportMap = theReport.toMap();
    reportMap["dateTime"] = theReport.dateTime.toTanggal("yyyy-MM-dd");
    reportMap["userId"] = _auth.currentUser!.uid;

    DocumentReference ref =
        await databaseReference.collection('report').add(reportMap);
  }

  static Future<void> processReport(ReportChanges reportChange) async {
    final databaseReference = FirebaseFirestore.instance;

    var changeData = {
      "status": reportChange.statusChange,
      (reportChange.statusChange == "active" ? "dateActive" : "dateDone"):
          DateTime.now().toTanggal("yyyy-MM-dd HH:mm:ss"),
    };
    if (reportChange.statusChange == "done") {
      changeData["doneNote"] = reportChange.noteChange;
    }
    await databaseReference
        .collection('report')
        .doc(reportChange.reportId)
        .update(changeData);
  }
}
