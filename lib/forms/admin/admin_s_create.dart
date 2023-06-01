import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:society/forms/admin/admin_get_states.dart';
import 'package:society/forms/admin/admin_society_details.dart';
import 'package:society/forms/users/choose_socity.dart';
import 'package:society/forms/admin/temp.dart';
import 'package:society/services/get_api.dart';

import '../../../widgets/round_button.dart';
import '../../../widgets/text_field.dart';
import '../../services/models/post_society.dart';
import '../../utils/constants/constants.dart';
import '../../utils/constants/snak_bar.dart';
import '../../widgets/snack_bar.dart';

class AdminCreateSociety extends StatefulWidget {
  final String state;
  final String stateID;
  final String city;
  final String cityID;

  const AdminCreateSociety({
    Key? key,
    required this.state,
    required this.city,
    required this.stateID,
    required this.cityID,
  }) : super(key: key);

  @override
  State<AdminCreateSociety> createState() => _AdminCreateSocietyState();
}

class _AdminCreateSocietyState extends State<AdminCreateSociety> {
  bool isControllerNotEmpty = false;
  TextEditingController _societyNameController = TextEditingController();
  TextEditingController _societyRegController = TextEditingController();
  TextEditingController _societyAddressController = TextEditingController();

  void changeForward() {
    // log('run');
    bool isNotEmpty = _societyAddressController.text.isNotEmpty &&
        _societyNameController.text.isNotEmpty &&
        _societyRegController.text.isNotEmpty;

    setState(() {
      // log(isNotEmpty.toString());
      isControllerNotEmpty = isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    changeForward();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose City"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text("Country "),
                TextDataCustom(
                  onTap: () {},
                  text: 'India',
                ),
                SizedBox(height: 10),
                Text("State  "),
                TextDataCustom(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminGetStatePage(),
                      ),
                    );
                  },
                  text: widget.state,
                ),
                SizedBox(height: 10),
                Text("City "),
                TextDataCustom(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: widget.city,
                ),
                SizedBox(height: 10),
                Text("Name of society "),
                TextFieldCustom(
                  onChanged: (value) {
                    changeForward();
                    log(value);
                  },
                  hint: 'Name of society',
                  controller: _societyNameController,
                ),
                SizedBox(height: 10),
                Text("Name of no Reg"),
                TextFieldCustom(
                  onChanged: (value) {
                    log(value);
                    changeForward();
                  },
                  hint: 'Name of Reg no',
                  controller: _societyRegController,
                ),
                SizedBox(height: 10),
                Text("Address of the Society "),
                TextFieldCustom(
                  onChanged: (value) {
                    changeForward();
                  },
                  hint: 'Address of the Society',
                  controller: _societyAddressController,
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () async {
                    submitData();
                    log(isControllerNotEmpty.toString() + " sum on ");
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isControllerNotEmpty ? kblue : Colors.grey,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitData() async {
    var adminSocietyData = PostSocietyModel(
      stateId: widget.stateID,
      cityId: widget.cityID,
      societyRegNo: _societyRegController.text,
      societyName: _societyNameController.text,
      address: _societyAddressController.text,
      latitude: '00.00',
      longitude: '00.00',
    );

    log(adminSocietyData.toString());

    var response =
        await Esociety().AdminCreateSociety(adminSocietyData).catchError((err) {
      print(err);
    });
    if (response == null) return;

    print(response.toString() + " Response");

    Map<String, dynamic> responseMap =
        jsonDecode(response); // Parse response string into a Map

    bool isSuccess = responseMap["status"];
    String message = responseMap["message"];
    print(message);

    if (isSuccess) {
      print("Successful: Registration successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminSocietyDetails(),
        ),
      );
    } else {
      print("Unsuccessful: Registration failed");
      Utils().snackBar(message, context);
    }
  }
}

class TextDataCustom extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const TextDataCustom({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: Row(
          children: [
            Text("   "),
            Text(text),
          ],
        ),
      ),
    );
  }
}
