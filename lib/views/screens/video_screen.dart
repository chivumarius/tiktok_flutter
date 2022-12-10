import 'package:flutter/material.dart';
import 'package:tiktok_flutter/views/widgets/circle_animation.dart';
import 'package:tiktok_flutter/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({Key? key}) : super(key: key);

  // ♦ The "buildProfile()" Method:
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(children: [
        Positioned(
          left: 5,
          child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
    );
  }

  // ♦ The "buildMusicAlbum()" Method:
  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(11),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.grey,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    );
  }

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0, viewportFraction: 1),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // ♦ The "Video URL":
              const VideoPlayerItem(
                videoUrl: 'Video URL',
              ),

              // ♦ The "Video Options Column"
              //    → Placed on the "Right Side" of the "Screen":
              Column(
                children: [
                  // ♦ Spacing:
                  const SizedBox(
                    height: 100,
                  ),

                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ♦ The "Bottom Left Area":
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // ♦ Username:
                                const Text(
                                  'User Name',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // ♦ Caption
                                const Text(
                                  'Caption',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),

                                Row(
                                  children: const [
                                    // ♦ "Music Note" - Icon:
                                    Icon(
                                      Icons.music_note,
                                      size: 15,
                                      color: Colors.white,
                                    ),

                                    // ♦ The "Song Name":
                                    Text(
                                      'Song Name',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),

                        // ♦ The "Right Area" from the "Middle Down":
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: size.height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // ♦ Getting the "Profile Photo":
                              buildProfile(
                                'String URL',
                              ),

                              // ♦ "Likes"
                              Column(
                                children: [
                                  // ♦ The "Like" - Icon:
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 7),

                                  // ♦ The "Number Likes":
                                  const Text(
                                    '2.200',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),

                              // ♦ "Comments":
                              Column(
                                children: [
                                  // ♦ The "Comment" - Icon:
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.comment,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 7),

                                  // ♦ The "Number Comments":
                                  const Text(
                                    '25',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),

                              // ♦ "Share":
                              Column(
                                children: [
                                  // ♦ The "Share" - Icon:
                                  InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.reply,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // ♦ Spacing:
                                  const SizedBox(height: 7),

                                  // ♦ The "Number Share":
                                  const Text(
                                    '2',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              CircleAnimation(
                                child: buildMusicAlbum('Profile Photo'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
