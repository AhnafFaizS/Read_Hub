import 'package:ahnaf_readhub/app/data/provider/storage_provider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10,
        title: Text('Profile Pengguna', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700),),
        leading: const Icon(
          Icons.person_rounded,
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),

              kontenUser(),

              const SizedBox(
                height: 20,
              ),

              Divider(
                color: Colors.grey.withOpacity(0.30),
                height: 1,
              ),

              const SizedBox(
                height: 40,
              ),

              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5000CA),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Get.toNamed(Routes.HISTORYPEMINJAMAN);
                  },
                  icon: const Icon(Icons.update, color: Colors.white,),
                  label: const Text(
                    "History Peminjaman",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              SizedBox(
                width: width,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF0000),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    controller.logout();
                  },
                  icon: const Icon(Icons.logout, color: Colors.white,),
                  label: const Text(
                    "Log Out",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget kontenUser(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/avatar.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),

              const SizedBox(
                width: 10,
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StorageProvider.read(StorageKey.namaLengkap),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      )
                    ),
                    Text(
                        StorageProvider.read(StorageKey.bio),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5000CA),
          ),
          onPressed: () {
            Get.toNamed(Routes.UPDATEPROFILE);
          },
          icon: const Icon(Icons.update, color: Colors.white,),
          label: const Text(
            "Update Profile",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}
