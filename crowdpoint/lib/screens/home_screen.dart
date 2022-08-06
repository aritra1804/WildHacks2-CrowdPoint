// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crowdpoint/HelperMethods/comment_data.dart';
import 'package:crowdpoint/HelperMethods/common_utils.dart';
import 'package:crowdpoint/HelperMethods/complaint_data.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_model.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? position;
  File? imageFile;
  final TextEditingController commentController = TextEditingController();

  initVars() async {
    position = await determinePosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future clickImage() async {
    var imgPicker = ImagePicker();
    var imageFile =
        await imgPicker.pickImage(source: ImageSource.camera, imageQuality: 90);

    if (imageFile != null) {
      print("You selected  image : " + imageFile.path);
      return File(imageFile.path);
    } else {
      print("You have not taken image");
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

  @override
  Widget build(BuildContext context) {
    UserModel user = UserModel(
        aadharNo: "54555",
        email: widget.user.email!,
        name: widget.user.displayName!,
        dpurl: widget.user.photoURL!);
    // return Scaffold(
    //   body: SafeArea(
    //       child: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CircleAvatar(
    //           radius: 50,
    //           backgroundImage: NetworkImage(widget.user.photoURL ?? ""),
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Text(widget.user.displayName ?? "Not Available"),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Text(widget.user.email ?? "Not Available")
    //       ],
    //     ),
    //   )),
    // );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<String> urls = await getUrl("jfmefefmf");
          ComplaintModel complaintModel = ComplaintModel(
              dateTime: DateTime.now(),
              user: UserModel(
                  aadharNo: "54555",
                  email: widget.user.email!,
                  name: widget.user.displayName!,
                  dpurl: widget.user.photoURL!),
              description: "hi there this is a sample description",
              latlng: LatLng(15.26556, 16.452223),
              id: "jfmefefmf",
              photoUrls: urls);
          ComplaintData.uploadComplaint(complaintModel);
          print("Uploaded");
        },
        child: Text('+'),
      ),
      body: Center(
        child: StreamBuilder<List<ComplaintModel>>(
          stream: ComplaintData.getComplaintsStream(),
          builder: (context, AsyncSnapshot<List<ComplaintModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var comp = snapshot.data![index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: Column(children: [
                        CarouselSlider(
                            items: comp.photoUrls
                                .map((pic) => Image.network(pic))
                                .toList(),
                            options: CarouselOptions()),
                        Text(comp.description),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  ComplaintData.upvoteComplaint(comp);
                                },
                                icon: Icon(Icons.thumbs_up_down_sharp)),
                            Text(comp.upVotes.toString()),
                            SizedBox(
                              width: 22,
                            ),
                            IconButton(
                                onPressed: () {
                                  ComplaintData.downVoteComplaint(comp);
                                },
                                icon: Icon(Icons.thumb_down_sharp)),
                            Text(comp.downVotes.toString())
                          ],
                        ),
                        comp.comments != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: comp.comments!.commentList.length,
                                itemBuilder: (context, index) {
                                  return Text(comp
                                      .comments!.commentList[index].comment);
                                },
                              )
                            : Container(),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: TextField(
                                controller: commentController,
                              ),
                            ),
                            MaterialButton(
                                onPressed: () {
                                  CommentData.addComment(
                                      comp.id,
                                      CommentModel(
                                          comment: commentController.text,
                                          dateTime: DateTime.now(),
                                          user: user));
                                },
                                padding: const EdgeInsets.all(15),
                                color: Colors.blue,
                                child: Text("Comment"))
                          ],
                        )
                      ]),
                    );
                  });
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
