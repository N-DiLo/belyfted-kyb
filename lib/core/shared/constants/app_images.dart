class AppImages {
  static const _path = 'assets/images';

  static const add = '$_path/add.svg';
  static const backButton = '$_path/back-button.svg';
  static const delete = '$_path/delete.svg';
  static const documentUpload = '$_path/document-upload.svg';
  static const edit = '$_path/edit.svg';
  static const profileUser = '$_path/profile-user.svg';
  static const vFailed = '$_path/verification-failed.svg';
  static const vSuccess = '$_path/verification-success.svg';
  static const vPending = '$_path/verification-pending.svg';
  static const verify = '$_path/verify.svg';
  static const arrowDown = '$_path/arrow-down.svg';
}

extension ImageExt on String {
  String get img {
    if (toLowerCase().endsWith('.svg') ||
        toLowerCase().endsWith('.png') ||
        toLowerCase().endsWith('.jpg') ||
        toLowerCase().endsWith('.jpeg')) {
      return this;
    }

    return this;
  }

  String get svg => endsWith('.svg') ? this : '$this.svg';
  String get png => endsWith('.png') ? this : '$this.png';
  String get jpg => endsWith('.jpg') ? this : '$this.jpg';
}
