import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/models/user.dart';

class SearchController extends GetxController {
  // ♦ Private Property:
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  // ♦ Getter → for Accessing "Private Property":
  List<User> get searchedUsers => _searchedUsers.value;

  // ♦ The "searchUser()" Function:
  searchUser(String typedUser) async {
    // ♦ Searching "Users":
    _searchedUsers.bindStream(
      firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          // ♦ Creating "User List":
          List<User> retVal = [];

          // ♦ Add User to List:
          for (var elem in query.docs) {
            retVal.add(User.fromSnap(elem));
          }
          return retVal;
        },
      ),
    );
  }
}
