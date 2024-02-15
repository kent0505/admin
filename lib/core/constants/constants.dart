abstract final class Const {
  static String appTitle = domainName.toUpperCase();
  static String username = '';

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
  // toast
  static String toastLoaded = 'Loaded';
  static String toastError = 'Error';
  static String toastNull = 'Null';
  static String toastLoginError = 'Username or password invalid';
  static String toastUserAdded = 'User added';
  static String toastPasswordError = 'Passwords did not match';
  static String toastUserDataError = 'Data must be different';
  static String toastUserUpdated = 'User updated';
  static String toastLogsDeleted = 'Logs deleted';
  static String toastCategoryAdded = 'Category added';
  static String toastCategoryUpdated = 'Category updated';
  static String toastCategoryDeleted = 'Category deleted';
  static String toastBlogAdded = 'Blog added';
  static String toastBlogUpdated = 'Blog updated';
  static String toastBlogDeleted = 'Blog deleted';
  static String toastContentAdded = 'Content added';
  static String toastContentUpdated = 'Content updated';
  static String toastContentDeleted = 'Content deleted';
  static String toastImageAdded = 'Image added';
  static String toastImageUpdated = 'Image updated';

  // appbar title
  static String editImagePageTitle = 'Edit';

  // backend
  static String token = '';
  static String domainName = ''; // example.com
  static String url = 'https://$domainName';
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
