import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

//ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  // ♦ Property:
  final String id;

  // ♦ Constructor:
  CommentScreen({
    super.key,
    required this.id,
  });

  // ♦ Controllers
  final TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  // ♦ The "build()" Method:
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ♦ Updating Post ID:
    commentController.updatePostId(id);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          // ♦ "Circle Avatar":
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              // ♦ "User Name":
                              Text(
                                "${comment.username}  ",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              // ♦ "Comment":
                              Text(
                                comment.comment,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          subtitle: Row(
                            children: [
                              // ♦ "Date":
                              Text(
                                tago.format(
                                  comment.datePublished.toDate(),
                                ),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),

                              // ♦ Spacing:
                              const SizedBox(
                                width: 10,
                              ),

                              // ♦ The "Number of Likes" for the "Comment":
                              Text(
                                '${comment.likes.length} likes',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),

                          // ♦ "Like":
                          trailing: InkWell(
                            onTap: () =>
                                commentController.likeComment(comment.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: comment.likes
                                      .contains(authController.user.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      });
                }),
              ),
              const Divider(),
              ListTile(
                // ♦ "Text Form Field":
                title: TextFormField(
                  controller: _commentController,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Comment',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                // ♦ "Button":
                trailing: TextButton(
                  onPressed: () =>
                      commentController.postComment(_commentController.text),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
