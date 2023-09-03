import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meet_gdsc_appdev_task/screens/signup.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Get.offAll(() => const SignUp(),
                transition: Transition.rightToLeftWithFade);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(photourl),
              Center(
                  child: Text(
                      "Logout, ${FirebaseAuth.instance.currentUser!.displayName}")),
            ],
          )),
    );
  }
}
