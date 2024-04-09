import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/updateprofile_controller.dart';

class UpdateprofileView extends GetView<UpdateprofileController> {
  const UpdateprofileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightAppbar = AppBar().preferredSize.height;
    double bodyHeight = height - heightAppbar;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10,
        title: Text('Update Profile Pengguna', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),),
        centerTitle: false,
      ),
      body: Container(
        width: width,
        height: bodyHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Profile Pengguna',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF5000CA),
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  textformfieldProfile(
                    controller.namalengkapController,
                    "Nama Lengkap",
                    "Masukan Nama Lengakap"
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  textformfieldProfile(
                      controller.usernameController,
                      "Username",
                      "Masukan Username"
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  textformfieldProfile(
                      controller.emailController,
                      "Email",
                      "Masukan Email"
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  textformfieldProfile(
                      controller.bioController,
                      "Bio",
                      "Masukan Bio"
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  textformfieldProfile(
                      controller.teleponController,
                      "Telepin",
                      "Masukan Telepon"
                  ),

                  SizedBox(
                    height: height * 0.045,
                  ),

                  SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5000CA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        onPressed: (){
                          controller.updateProfilePost();
                        },
                        child: Obx(() => controller.loading.value?
                        const CircularProgressIndicator(
                          color: Color(0xFFF5F5F5),
                        ):  Text(
                          'Update Profile',
                          style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      )
                  )
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget textformfieldProfile(final controller, String hinText, String messageError){
    // const Color textColor = Color(0xFF7174BD);
    const Color backgroundInput = Color(0xFFF5F5F5);

    // Font Size
    double textField = 16.0;

    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(
          fontSize: textField,
          fontWeight: FontWeight.w600,
          color: Colors.black
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundInput,
        prefixIcon: const Icon(Icons.person),
        hintText: hinText,
        hintStyle: GoogleFonts.inter(
            fontSize: textField,
            fontWeight: FontWeight.w600,
            color: Colors.black
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value){
        if (value!.isEmpty){
          return messageError;
        }
        return null;
      },
    );
  }
}
