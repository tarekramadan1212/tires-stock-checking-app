class BranchModel{

  BranchModel({
    required this.name,
    required this.id,
  });

  final String name;
  final int id;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        name: json["name"],
        id: json["id"],
  );
}