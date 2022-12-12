import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  // ♦ Property:
  final String uid;

  // ♦ Constructor:
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // ♦ Controller:
  final ProfileController profileController = Get.put(ProfileController());

  // ♦ The "initState()" Method:
  @override
  void initState() {
    super.initState();
    // ♦ Update "User ID":
    profileController.updateUserId(widget.uid);
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          // ♦ Checking the Condition:
          if (controller.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black12,
              leading: const Icon(
                Icons.person_add_alt_1_outlined,
              ),
              actions: const [
                Icon(Icons.more_horiz),
              ],
              title: Text(
                controller.user['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          // ♦ Profile "Image"
                          //    → by Using "Cached Network Image" Package:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ♦ The "Circle":
                              ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: controller.user['profilePhoto'],
                                  height: 100,
                                  width: 100,

                                  // ♦ Loading "Indicator":
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          // ♦
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ♦ The "Following":
                              Column(
                                children: [
                                  // ♦ The "Number of Following":
                                  Text(
                                    controller.user['following'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 5),

                                  // ♦ The "Following" Text:
                                  const Text(
                                    'Following',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              // ♦ Black Spacing:
                              Container(
                                color: Colors.black54,
                                width: 1,
                                height: 15,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),

                              // ♦ The "Followers":
                              Column(
                                children: [
                                  // ♦ The "Number of Followers":
                                  Text(
                                    controller.user['followers'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 5),

                                  // ♦ The "Followers" Text:
                                  const Text(
                                    'Followers',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              // ♦ Black Spacing:
                              Container(
                                color: Colors.black54,
                                width: 1,
                                height: 15,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                              ),

                              // ♦ "likes":
                              Column(
                                children: [
                                  // ♦ The "Number of likes":
                                  Text(
                                    controller.user['likes'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 5),

                                  // ♦ The "Likes" Text:
                                  const Text(
                                    'Likes',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // ♦ Spacing:
                          const SizedBox(
                            height: 15,
                          ),

                          // ♦ User "Sign Out" or "Follow" or "Unfollow":
                          Container(
                            width: 140,
                            height: 47,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                            child: Center(
                              // ♦ Clickable:
                              child: InkWell(
                                onTap: () {
                                  if (widget.uid == authController.user.uid) {
                                    authController.signOut();
                                  } else {
                                    controller.followUser();
                                  }
                                },
                                child: Text(
                                  widget.uid == authController.user.uid
                                      ? 'Sign Out'
                                      : controller.user['isFollowing']
                                          ? 'Unfollow'
                                          : 'Follow',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // ♦ Spacing:
                          const SizedBox(
                            height: 25,
                          ),

                          // ♦ The "GridView"
                          //    → to Select, Sort, and Edit these Items
                          // ("Video List"):
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.user['thumbnails'].length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              String thumbnail =
                                  controller.user['thumbnails'][index];
                              return CachedNetworkImage(
                                imageUrl: thumbnail,
                                fit: BoxFit.cover,
                              );
                            },
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
  }
}
