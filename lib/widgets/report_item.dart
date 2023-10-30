import 'package:flutter/material.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/helpers/extensions/ext_string.dart';
import 'package:spanticom/theme/colors/light_colors.dart';

class report_item extends StatelessWidget {
  final UserReport theReport;
  report_item(this.theReport);
  @override
  Widget build(BuildContext context) {
    final textColor = Color(0xFF445D48);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Color(0xFFD6CC99),
        child: ListTile(
          title: Text(
            theReport.name,
            style: TextStyle(
              color: textColor,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kelas " + theReport.className,
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
              Text(
                theReport.dateTime.toTanggal("dd MMM yyyy"),
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
