// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crowdpoint/HelperMethods/comment_data.dart';
import 'package:crowdpoint/HelperMethods/common_utils.dart';
import 'package:crowdpoint/HelperMethods/complaint_data.dart';
import 'package:crowdpoint/constants.dart';
import 'package:crowdpoint/enums.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_model.dart';
import 'package:crowdpoint/models/reaction_info_model.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:crowdpoint/services/authentication.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:readmore/readmore.dart';

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
  int upvotes = 0, downvotes = 0;
  Stream<List<ComplaintModel>>? _stream;
  Position? position;
  File? imageFile;
  final TextEditingController commentController = TextEditingController();

  initVars() async {
    position = await determinePosition();
  }

  @override
  void initState() {
    // TODO: implement initState
    _stream = ComplaintData.getComplaintsStream();
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
    var size = MediaQuery.of(context).size;
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
      appBar: AppBar(
        backgroundColor: kL1Color,
        foregroundColor: kBlackColor,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.account_circle_outlined,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Authentication.signOut(context: context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            icon: Icon(Icons.logout_rounded),
          )
        ],
        title: Text(
          "CrowdPoint",
          style: TextStyle(
            fontFamily: "Quicksand",
          ),
        ),
      ),
      backgroundColor: kBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<String> urls = await getUrl("jfmefefmf");
          ComplaintModel complaintModel = ComplaintModel(
              completed: false,
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
      body: Container(
        width: size.width,
        height: size.height,
        child: StreamBuilder<List<ComplaintModel>>(
          stream: _stream,
          builder: (context, AsyncSnapshot<List<ComplaintModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              print('hiiii');
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var comp = snapshot.data![index];
                    print(comp);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 8,
                      ),
                      child: Container(
                        decoration: kBoxDecoration,
                        padding: const EdgeInsets.only(
                          // vertical: 12,
                          bottom: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: kTileUserNameDecoration,
                              height: size.height * 0.08,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    foregroundImage:
                                        NetworkImage(comp.user.dpurl),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    comp.user.name,
                                    style: TextStyle(
                                      fontSize: size.width * 0.05,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_horiz),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              decoration: kTileUserNameDecoration,
                              height: size.height * 0.4,
                              child: CarouselSlider(
                                items: comp.photoUrls
                                    .map((pic) => Image.network(pic))
                                    .toList(),
                                options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: size.height * 0.4,
                                  enlargeCenterPage: true,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              child: ReadMoreText(
                                comp.description,
                                trimMode: TrimMode.Length,
                                trimLength: 40,
                                colorClickableText: Colors.grey,
                                trimCollapsedText: 'more',
                                trimExpandedText: ' less',
                                style: TextStyle(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            StreamBuilder<List<ReactionInfoModel>>(
                                stream: ComplaintData.getVotescount(comp),
                                builder: (context, snapshot) {
                                  int up = 0, dp = 0;
                                  if (snapshot.hasData) {
                                    for (var data in snapshot.data!) {
                                      if (data.react == React.UPVOTE) {
                                        up++;
                                      } else if (data.react == React.DOWNVOTE) {
                                        dp++;
                                      }
                                    }
                                    upvotes = up;
                                    downvotes = dp;
                                    return Row(
                                      children: [
                                        IconButton(
                                          constraints: BoxConstraints(),
                                          iconSize: 22,
                                          onPressed: () {
                                            ComplaintData.upvoteComplaint(comp);
                                          },
                                          icon: Icon(
                                            Icons.thumb_up_sharp,
                                            size: 22,
                                          ),
                                        ),
                                        Text(
                                          upvotes.toString(),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        IconButton(
                                          constraints: BoxConstraints(),
                                          iconSize: 22,
                                          onPressed: () {
                                            ComplaintData.downVoteComplaint(
                                                comp);
                                          },
                                          icon: Icon(
                                            Icons.thumb_down_sharp,
                                            size: 22,
                                          ),
                                        ),
                                        Text(
                                          downvotes.toString(),
                                        )
                                      ],
                                    );
                                  }
                                  return Row(
                                    children: [
                                      IconButton(
                                        constraints: BoxConstraints(),
                                        iconSize: 22,
                                        onPressed: () {
                                          ComplaintData.upvoteComplaint(comp);
                                        },
                                        icon: Icon(
                                          Icons.thumb_up_sharp,
                                          size: 22,
                                        ),
                                      ),
                                      Text(
                                        upvotes.toString(),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      IconButton(
                                        constraints: BoxConstraints(),
                                        iconSize: 22,
                                        onPressed: () {
                                          ComplaintData.downVoteComplaint(comp);
                                        },
                                        icon: Icon(
                                          Icons.thumb_down_sharp,
                                          size: 22,
                                        ),
                                      ),
                                      Text(
                                        downvotes.toString(),
                                      )
                                    ],
                                  );
                                }),
                            SizedBox(
                              height: 6,
                            ),
                            if (comp.comments != null)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<List<CommentModel>>(
                                        stream:
                                            CommentData.getCommentsStream(comp),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: comp.comments!
                                                          .commentList.length <
                                                      2
                                                  ? comp.comments!.commentList
                                                      .length
                                                  : 2,
                                              itemBuilder: (context, index) {
                                                return Text(comp
                                                    .comments!
                                                    .commentList[index]
                                                    .comment);
                                              },
                                            );
                                          }
                                          return Container();
                                        }),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      "View all comments",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            else
                              Container(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              decoration: kTileUserNameDecoration.copyWith(
                                border: Border(
                                  top: BorderSide(width: 0.1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "Add a comment...",
                                        border: InputBorder.none,
                                      ),
                                      controller: commentController,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.send,
                                    ),
                                    onPressed: () {
                                      CommentData.addComment(
                                        comp.id,
                                        CommentModel(
                                            comment: commentController.text,
                                            dateTime: DateTime.now(),
                                            user: user),
                                      );
                                    },
                                    padding: const EdgeInsets.all(15),
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
