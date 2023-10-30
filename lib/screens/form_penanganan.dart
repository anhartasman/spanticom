import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/UserReport.dart';
import 'package:spanticom/bloc/save_report/bloc.dart';
import 'package:spanticom/theme/colors/Warna.dart';
import 'package:spanticom/theme/decorations/box_decoration.dart';
import 'package:spanticom/theme/decorations/input_decoration.dart';
import 'package:spanticom/widgets/TampilanDialog.dart';

class form_penanganan extends StatefulWidget {
  const form_penanganan();
  @override
  State<form_penanganan> createState() => _form_penangananState();
}

class _form_penangananState extends State<form_penanganan> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController _etNote = new TextEditingController();

  void saveForm() async {
    if (!formKey.currentState!.saveAndValidate()) {
      TampilanDialog.showDialogAlert("Lengkapi form terlebih dahulu");
      return;
    }
    TampilanDialog.showDialogKonfirm("Kirim Laporan?").then((value) {
      if (value) {
        Get.back(result: _etNote.text);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black54,
    );
    return Scaffold(
      backgroundColor: Warna.unguMuda,
      appBar: AppBar(
        title: const Text("Form Penanganan"),
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
        backgroundColor: Colors.purple,
      ), //
      body: SafeArea(
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          left: 16,
                        ),
                        child: Text("Catatan Penanganan",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: box_field_abu,
                          child: new FormBuilderTextField(
                            name: "report",
                            controller: _etNote,
                            decoration: text_field_abu.copyWith(),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                            keyboardType: TextInputType.multiline,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                            maxLines: 4,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  width: width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      InkWell(
                        onTap: saveForm,
                        child: Container(
                          child: Text(
                            'Simpan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                          width: width - 40,
                          decoration: BoxDecoration(
                            color: Warna.unguTua,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
