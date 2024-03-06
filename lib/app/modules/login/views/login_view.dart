import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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

    // Variabel menampung lebar dan tinggi
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                        child: AutoSizeText(
                          'Login Here!',
                          style: GoogleFonts.holtwoodOneSc(
                            color: buttonColor,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              child: TextFormField(
                                style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black
                                ),
                               controller: controller.emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: backgroundInput,
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: 'Email',
                                  hintStyle: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 20.0),
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
                                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                child: Obx(()=>
                                    TextFormField(
                                      style: GoogleFonts.inter(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
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
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 15.0, horizontal: 20.0),
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty){
                                          return 'Password tidak boleh kosong!';
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      )
                                  )
                              )
                              ),

                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 20),
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
                                    TextButton(
                                      onPressed: (){
                                        Get.to( Get.toNamed(Routes.REGISTER), transition: Transition.fadeIn);
                                      },
                                      child: FittedBox(
                                        child: Text('Register',
                                            style: GoogleFonts.holtwoodOneSc(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: buttonColor,
                                            )),
                                      ),
                                    ),
                                  ],
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
