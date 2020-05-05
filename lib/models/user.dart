import '../string_util.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _firstName;
  String _lastName;

  LoginType _type;
  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
    print("User is created");
  }

  factory User({String name, String phone, String email}) {
    if (phone == null) phone = '';
    if (email == null) email = '';
    if (name == null) name = '';

    if (name.isEmpty) throw ("User name is empty");
    if (phone.isEmpty && email.isEmpty)
      throw Exception("phone or email is empty");

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: (phone.isNotEmpty) ? checkPhone(phone) : phone,
        email: (email.isNotEmpty) ? checkEmail(email) : email);
  }

  static String _getFirstName(String userName) => userName.split(" ")[0];
  static String _getLastName(String userName) => userName.split(" ")[1];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (phone == null || phone.isEmpty)
      throw Exception("Enter don`t empty phone number");
    else if (!RegExp(pattern).hasMatch(phone))
      throw Exception(
          "Enter a valid phone number staring with a + and containing 11 digits");

    return phone;
  }

  static String checkEmail(String email) {
    if (email == null || email.isEmpty)
      throw Exception("Enter don`t empty email");
    else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) throw Exception("Enter a valid email");

    return email;
  }

  String get login => _type == LoginType.phone ? phone : email;
  String get name => "${_firstName.capitalize()} ${_lastName.capitalize()}";

  @override
  int get hashCode => User().hashCode;

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }

    return false;
  }

  void addFriend(Iterable<User> friend) {
    friends.addAll(friend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => """
  name: $name
  email: $email
  firstName: $_firstName
  lastName: $_lastName
  friends: ${friends.toList()}
  """;

  @override
  String toString() => """
  name: $name
  email: $email
  friends : ${friends.toList()}
  """;
}
