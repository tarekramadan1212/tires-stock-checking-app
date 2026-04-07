class UserDataModel {
  final String? userId;
  final String? branchName;
  final String? branchId;
  final String? email;
  final bool? isVerified;

  const UserDataModel({
    this.email,
    this.isVerified,
    this.branchId,
    this.branchName,
    this.userId,
  });
}
