import 'dart:io';

import 'package:crowdpoint/HelperMethods/common_utils.dart';
import 'package:crowdpoint/HelperMethods/complaint_data.dart';
import 'package:crowdpoint/dataProvider/appdata.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/complaint_model.dart';
import '../models/user_model.dart';

class GetDetails extends StatefulWidget {
  const GetDetails({Key? key}) : super(key: key);

  @override
  State<GetDetails> createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  List<String> urls = [];
  final TextEditingController descriptionController = TextEditingController();
  var id = DateTime.now();
  var photoId = "";
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<AppData>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kL1Color,
        foregroundColor: kBlackColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
          ),
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
        ),
        title: Text(
          "Enter Details",
          style: TextStyle(
            fontFamily: "Quicksand",
          ),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "Description: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.06,
                ),
              ),
              TextField(
                maxLines: 8,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Add a comment...",
                ),
                controller: descriptionController,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Upload photo: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size.width * 0.06,
                ),
              ),
              Row(
                children: [
                  Text(photoId),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      urls = await getUrl(id.toString());
                      photoId = '$id.png';
                      setState(() {});
                    },
                    child: Text("Choose"),
                  )
                ],
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  Position position = await determinePosition();
                  ComplaintModel complaintModel = ComplaintModel(
                      completed: false,
                      dateTime: id,
                      user: data.user!,
                      description: descriptionController.text,
                      latlng: LatLng(position.latitude, position.longitude),
                      id: id.toString(),
                      photoUrls: urls);
                  await ComplaintData.uploadComplaint(complaintModel);
                  Navigator.pop(context);
                },
                child: Text("Upload"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future clickImage() async {
    var imgPicker = ImagePicker();
    var imageFile =
        await imgPicker.pickImage(source: ImageSource.camera, imageQuality: 90);

    if (imageFile != null) {
      if (kDebugMode) {
        print("You selected  image : ${imageFile.path}");
      }
      return File(imageFile.path);
    } else {
      if (kDebugMode) {
        print("You have not taken image");
      }
    }
  }

  Future<List<String>> getUrl(String id) async {
    File file = await clickImage();
    List<String> list = [];
    String? u = await CommonUtils.uploadToFirebase(file, "$id/1");
    list.add(u!);
    list.add(u);
    return Future<List<String>>.value(list);
  }
}
