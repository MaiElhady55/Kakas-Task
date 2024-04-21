class SignUpModel {
  String? token;

  SignUpModel({this.token});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
