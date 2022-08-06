// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:crowdpoint/HelperMethods/comment_data.dart';
import 'package:crowdpoint/HelperMethods/common_utils.dart';
import 'package:crowdpoint/HelperMethods/complaint_data.dart';
import 'package:crowdpoint/constants.dart';
import 'package:crowdpoint/enums.dart';
import 'package:crowdpoint/models/comments_model.dart';
import 'package:crowdpoint/models/complaint_model.dart';
import 'package:crowdpoint/models/reaction_info_model.dart';
import 'package:crowdpoint/models/user_model.dart';
import 'package:crowdpoint/screens/get_details_screen.dart';
import 'package:crowdpoint/screens/login_screen.dart';
import 'package:crowdpoint/screens/profile_screen.dart';
import 'package:crowdpoint/services/authentication.dart';
import 'package:crowdpoint/services/location_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../dataProvider/appdata.dart';

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
      if (kDebugMode) {
        print("You selected  image : " + imageFile.path);
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var data = Provider.of<AppData>(context, listen: false);
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
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(user: widget.user),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Authentication.signOut(context: context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
        title: const Text(
          "CrowdPoint",
          style: TextStyle(
            fontFamily: "Quicksand",
          ),
        ),
      ),
      backgroundColor: kBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GetDetails(),
            ),
          );
          // var id = DateTime.now();
          // List<String> urls = await getUrl(id.toString());
          // ComplaintModel complaintModel = ComplaintModel(
          //     completed: false,
          //     dateTime: id,
          //     user: UserModel(
          //         aadharNo: "54555",
          //         email: widget.user.email!,
          //         name: widget.user.displayName!,
          //         dpurl: widget.user.photoURL!),
          //     description: "hi there this is a sample description",
          //     latlng: LatLng(data.position!.latitude, data.position!.longitude),
          //     id: id.toString(),
          //     photoUrls: urls);
          // ComplaintData.uploadComplaint(complaintModel);
          // if (kDebugMode) {
          //   print("Uploaded");
          // }
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: StreamBuilder<List<ComplaintModel>>(
          stream: _stream,
          builder: (context, AsyncSnapshot<List<ComplaintModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.data);
            if (snapshot.hasData) {
              // print('hiiii');
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var comp = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 8,
                      ),
                      child: Badge(
                        position: BadgePosition.topEnd(end: -5, top: -2),
                        showBadge: comp.completed,
                        shape: BadgeShape.square,
                        borderRadius: BorderRadius.circular(5),
                        badgeColor: Colors.green.shade600,
                        badgeContent: Text(
                          "Completed",
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      foregroundImage:
                                          NetworkImage(comp.user.dpurl),
                                      backgroundColor: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Text(
                                      comp.user.name,
                                      style: TextStyle(
                                        fontSize: size.width * 0.05,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.more_horiz),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                decoration: kTileUserNameDecoration,
                                height: size.height * 0.4,
                                child: Image.network(
                                  comp.photoUrls[0],
                                  height: size.height * 0.4,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: ReadMoreText(
                                  comp.description,
                                  trimMode: TrimMode.Length,
                                  trimLength: 40,
                                  colorClickableText: Colors.grey,
                                  trimCollapsedText: 'more',
                                  trimExpandedText: ' less',
                                  style: const TextStyle(
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                        } else if (data.react ==
                                            React.DOWNVOTE) {
                                          dp++;
                                        }
                                      }
                                      upvotes = up;
                                      downvotes = dp;
                                      return Row(
                                        children: [
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            iconSize: 22,
                                            onPressed: () {
                                              ComplaintData.upvoteComplaint(
                                                  comp);
                                            },
                                            icon: const Icon(
                                              Icons.thumb_up_sharp,
                                              size: 22,
                                            ),
                                          ),
                                          Text(
                                            upvotes.toString(),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            iconSize: 22,
                                            onPressed: () {
                                              ComplaintData.downVoteComplaint(
                                                  comp);
                                            },
                                            icon: const Icon(
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
                                          constraints: const BoxConstraints(),
                                          iconSize: 22,
                                          onPressed: () {
                                            ComplaintData.upvoteComplaint(comp);
                                          },
                                          icon: const Icon(
                                            Icons.thumb_up_sharp,
                                            size: 22,
                                          ),
                                        ),
                                        Text(
                                          upvotes.toString(),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        IconButton(
                                          constraints: const BoxConstraints(),
                                          iconSize: 22,
                                          onPressed: () {
                                            ComplaintData.downVoteComplaint(
                                                comp);
                                          },
                                          icon: const Icon(
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
                              const SizedBox(
                                height: 2,
                              ),
                              if (comp.comments != null)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(
                                                4.0,
                                              ),
                                            ),
                                          ),
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) {
                                            final TextEditingController
                                                modalCommentController =
                                                TextEditingController();
                                            return Padding(
                                              padding: MediaQuery.of(context)
                                                  .viewInsets,
                                              child: SizedBox(
                                                height: size.height * 0.7,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 16.0,
                                                    vertical: 8,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      StreamBuilder<
                                                          List<CommentModel>>(
                                                        stream: CommentData
                                                            .getCommentsStream(
                                                                comp),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return ListView
                                                                .separated(
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  snapshot.data!
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .user
                                                                          .name,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            size.width *
                                                                                0.043,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .comment,
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8),
                                                                  ],
                                                                );
                                                              },
                                                              separatorBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return Divider();
                                                              },
                                                            );
                                                          }
                                                          return Container();
                                                        },
                                                      ),
                                                      const Spacer(),
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Expanded(
                                                            child: TextField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  const InputDecoration(
                                                                hintText:
                                                                    "Add a comment...",
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                              ),
                                                              controller:
                                                                  modalCommentController,
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.send,
                                                            ),
                                                            onPressed: () {
                                                              CommentData
                                                                  .addComment(
                                                                comp.id,
                                                                CommentModel(
                                                                    comment:
                                                                        modalCommentController
                                                                            .text,
                                                                    dateTime:
                                                                        DateTime
                                                                            .now(),
                                                                    user: user),
                                                              );
                                                            },
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            color: Colors.blue,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: const Text(
                                      "View all comments",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                Container(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: kTileUserNameDecoration.copyWith(
                                  border: const Border(
                                    top: BorderSide(width: 0.1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: "Add a comment...",
                                          border: InputBorder.none,
                                        ),
                                        controller: commentController,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
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
