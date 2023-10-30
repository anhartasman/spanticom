import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:spanticom/architectures/domain/entities/UserAccount.dart';
import 'package:spanticom/architectures/domain/entities/UserAuth.dart';
import 'package:spanticom/bloc/user_login/bloc.dart';
import 'package:spanticom/routes/app_routes.dart';
import 'package:spanticom/services/auth_service.dart';
import 'package:spanticom/theme/colors/Warna.dart';
import 'package:spanticom/theme/decorations/box_decoration.dart';
import 'package:spanticom/theme/decorations/input_decoration.dart';
import 'package:spanticom/widgets/TampilanDialog.dart';

class login_admin extends StatefulWidget {
  const login_admin();
  @override
  State<login_admin> createState() => _login_adminState();
}

class _login_adminState extends State<login_admin> {
  final formKey = GlobalKey<FormBuilderState>();
  TextEditingController _etEmail = new TextEditingController();
  TextEditingController _etPassword = new TextEditingController();

  void submitForm() {
    try {
      if (!formKey.currentState!.validate()) {
        throw ("Lengkapi form");
      }
      final passwordFirst = _etPassword.text;
      if (passwordFirst.length < 6) {
        throw ("Minimal password 6 karakter");
      }
      final userAuth = UserAuth(
        email: _etEmail.text,
        password: _etPassword.text,
      );
      BlocProvider.of<UserLoginBloc>(context).add(UserLoginBlocStart(userAuth));
    } catch (e) {
      TampilanDialog.showDialogAlert(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF5E8B7),
      appBar: AppBar(
        title: const Text("Login User"),
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
        backgroundColor: Color(0xFFCD5C08),
      ), //
      body: SafeArea(
        child: FormBuilder(
          key: formKey,
          child: BlocConsumer<UserLoginBloc, UserLoginBlocState>(
              listener: (context, state) {
            if (state is UserLoginOnSuccess) {
              final authService = Get.find<AuthService>();
              authService.setIsLoggedIn(
                true,
                newUser: state.theAccount,
              );
              // TampilanDialog.showDialogSuccess("Login berhasil");
              Future.delayed(Duration(milliseconds: 500))
                  .then((value) => Get.offNamed(Routes.homeRoute));
            } else if (state is UserLoginOnError) {
              TampilanDialog.showDialogAlert(state.errorMessage);
            }
          }, builder: (context, state) {
            if (state is UserLoginOnStarted) {
              return Center(
                child: SpinKitWave(
                  color: Warna.warnaUtama,
                  size: 50.0,
                ),
              );
            }
            return SingleChildScrollView(
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
                          child: Text("Email",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: box_field_abu.copyWith(
                              color: Color(0xFFC1D8C3),
                            ),
                            child: new FormBuilderTextField(
                              name: "email",
                              controller: _etEmail,
                              decoration: text_field_abu,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.email(),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 25.0,
                            left: 16,
                          ),
                          child: Text("Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: box_field_abu.copyWith(
                              color: Color(0xFFC1D8C3),
                            ),
                            child: new FormBuilderTextField(
                              name: "password",
                              controller: _etPassword,
                              decoration: text_field_abu,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                              ]),
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
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
                          onTap: submitForm,
                          child: Container(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18),
                            ),
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                            width: width - 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF6A9C89),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.authRegisterRoute),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Tidak memiliki akun ? "),
                        Text(
                          "Daftar disini",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
