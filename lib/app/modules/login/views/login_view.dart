import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // const Color textColor = Color(0xFF7174BD);
    const Color buttonColor = Color(0xFF5000CA);
    const Color backgroundInput = Color(0xFFF5F5F5);

    // Font Size
    double heading = 30.0;
    double textField = 18.0;
    double textButton = 20.0;

    // Size
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,// Change this color as needed
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash/gambar_atas.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),

                SizedBox(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          'Login Here!',
                          style: GoogleFonts.holtwoodOneSc(
                            color: buttonColor,
                            fontSize: heading,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: height * 0.010),
                              child: TextFormField(
                                style: GoogleFonts.inter(
                                    fontSize: textField,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black
                                ),
                               controller: controller.emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: backgroundInput,
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.inter(
                                      fontSize: textField,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                ),
                                validator: (value){
                                  if (value!.isEmpty){
                                    return 'Email tidak boleh kosong!';
                                  }else if (!EmailValidator.validate(value)){
                                    return 'Email tidak sesuai';
                                  }else if (!value.endsWith('@smk.belajar.id')){
                                    return 'Email harus menggunakan @smk.belajar.id';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40, vertical: height * 0.010),
                                child: Obx(()=>
                                    TextFormField(
                                      style: GoogleFonts.inter(
                                          fontSize: textField,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black
                                      ),
                                      controller: controller.passwordController,
                                      obscureText: controller.isPasswordHidden.value,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: backgroundInput,
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: InkWell(
                                          child: Icon(
                                            controller.isPasswordHidden.value
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                          onTap: (){
                                            controller.isPasswordHidden.value =! controller.isPasswordHidden.value;
                                          },
                                        ),
                                        hintText: 'Password',
                                        hintStyle: GoogleFonts.inter(
                                            fontSize: textField,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 20.0),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please input password';
                                        } else if (value.length < 8){
                                          return 'Panjang password harus lebih dari 8';
                                        }
                                        // Validasi setidaknya satu huruf besar
                                        else if (!value.contains(RegExp(r'[A-Z]'))) {
                                          return 'Password harus mengandung satu huruf besar';
                                        }
                                        // Validasi setidaknya satu karakter khusus
                                        else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                                          return 'Password harus mengandung satu karakter khusus';
                                        }
                                        // Validasi setidaknya satu angka
                                        else if (!value.contains(RegExp(r'[0-9]'))) {
                                          return 'Password harus mengandung minimal 1 angka';
                                        }
                                        return null;
                                      },
                                    ),
                                )
                            ),
                          ],
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: Obx(() => controller.loadinglogin.value?
                                  const CircularProgressIndicator(
                                    color: buttonColor,
                                  ): ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  5.5))),
                                      onPressed: () => controller.loginPost(),
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.inter(
                                            fontSize: textButton,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                  )
                              )
                              ),

                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: FittedBox(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        child: Text(
                                          'Belum punya akun?',
                                          style: GoogleFonts.holtwoodOneSc(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: ()=> Get.offAllNamed(Routes.REGISTER),
                                        child: FittedBox(
                                          child: Text('Register',
                                              style: GoogleFonts.holtwoodOneSc(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: buttonColor,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  ),

                ),

                Flexible(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/splash/gambar_bawah.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
