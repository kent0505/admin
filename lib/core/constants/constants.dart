import 'domain_name.dart';

class Const {
  static String appTitle = domainName
      .toUpperCase()
      .replaceAll('HTTP://', '')
      .replaceAll('HTTPS://', '');
  // button
  static String buttonAddText = 'POST';
  static String buttonUpdateText = 'PUT';
  static String buttonPickImageText = 'Pick image';
  // auth
  static String usernameHintText = 'Username';
  static String passwordHintText = 'Password';
  static String confirmHintText = 'Confirm password';
  static String loginText = 'Login';
  static String registerText = 'Register';
  // alert dialog
  static String alertButtonCancel = 'Cancel';
  static String alertButtonYes = 'Yes';
  static String alertDeleteCategory = 'Delete category?';
  static String alertDeleteBlog = 'Delete blog?';
  static String alertDeleteContent = 'Delete content?';
  static String alertOpenUrl = 'Open URL\n$url ?';
  static String alertLogout = 'Logout?';
  // tooltip
  static String tooltipOpenUrl = 'Open URL';
  static String tooltipLogs = 'Logs';
  static String tooltipAdd = 'Add';
  static String tooltipDelete = 'Delete';
  static String tooltipLogout = 'Logout';
  static String tooltipRemoveImage = 'Remove image';
  // appbar title
  static String editImagePageTitle = 'Edit';
  // backend
  static String url = domainName;
  static String loginURL = '$url/api/v1/user/login';
  static String registerURL = '$url/api/v1/user/register';
  static String updateURL = '$url/api/v1/user/';
  static String categoryURL = '$url/api/v1/category/';
  static String blogURL = '$url/api/v1/blog/';
  static String contentURL = '$url/api/v1/content/';
  static String imageURL = '$url/api/v1/upload/';
  static String imgURL = '$url/images/';
  static String logsURL = '$url/api/v1/logs/last';
  static String deleteLogsURL = '$url/api/v1/logs/delete';
}
