import './models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    print(user.toString());

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  User registerUserByPhone(String name, String phone) {
    User user = User(name: name, phone: phone);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  User registerUserByEmail(String name, String email) {
    User user = User(name: name, email: email);
    if (!users.containsKey(user.login)) {
      users[user.login] = user;
      return user;
    } else {
      throw Exception("A user with this name already exists");
    }
  }

  void setFriends(String login, List<User> friends) {
    users[login].friends.addAll(friends);
  }

  User findUserInFriends(String login, User user) {
    if (users[login].friends.isEmpty) {
      throw Exception("${user.login} is not a friend of the login");
    }

    return users[login].friends.where((friend) {
      return friend == user;
    }).first;
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  List<User> importUsers(List<String> strings) {
    List<User> users = List();
    if (strings.isNotEmpty) {
      strings.forEach((string) => users.add(splitString(string)));
    }
    return users;
  }

  User splitString(String string) {
    List<String> spitString = string.split(";\n");
    String name = spitString[0].trim();
    String email = spitString[1].trim();
    String phone = spitString[2].trim();
    return User(name: name, email: email, phone: phone);
  }
}
