import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meet_gdsc_appdev_task/screens/signup.dart';

import '../constants/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var photourl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfilePic();
  }

  Future fetchProfilePic() async {
    setState(() {
      photourl = FirebaseAuth.instance.currentUser!.photoURL ??
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    });
  }

  final picker = ImagePicker();
  var _imageFile;
  int count = 0;

  Future pickImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    _imageFile = File(pickedFile!.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref("profilepic").child(
          FirebaseAuth.instance.currentUser!.uid + DateTime.now().toString(),
        );
    UploadTask uploadTask;

    uploadTask = ref.putFile(_imageFile);

    var uploadedlink;
    uploadTask.whenComplete(() async {
      uploadedlink = await ref.getDownloadURL();
      await FirebaseAuth.instance.currentUser?.updatePhotoURL(uploadedlink);
      setState(() {
        fetchProfilePic();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/gdsc_logo.svg",
                height: 20,
              ),
              SizedBox(
                height: 30,
                child: VerticalDivider(
                  color: Colors.grey.shade500,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Google Developer Student Clubs",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "D. J. Sanghvi College of Engineering",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ],
          ),
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 500,
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(photourl),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              FirebaseAuth.instance.currentUser!.displayName ??
                                  "Chavan Meet Dinesh",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser!.email ??
                                  "60004230269@svkmgrp.com",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/gdsc_logo.svg",
                            height: 30,
                          ),
                          Column(
                            children: [
                              Text(
                                "Google Developer Student Clubs",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "D. J. Sanghvi College of Engineering",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w300),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => const SignUp(),
                      transition: Transition.rightToLeftWithFade);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 18,
                    ),
                    Text(
                      " Log Out",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "DJSCE GDSC'23 Task by Meet Chavan SY - 60004230269",
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 11,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
