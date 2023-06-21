class ImageModel {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  ImageModel(
      {this.id,
        this.author,
        this.width,
        this.height,
        this.url,
        this.downloadUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id : json['id'],
      author : json['author'],
      width : json['width'],
      height : json['height'],
      url : json['url'],
      downloadUrl : json['download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }

  // final int userId;
  // final int id;
  // final String title;
  //
  // const ImageModel({
  //   required this.userId,
  //   required this.id,
  //   required this.title,
  // });
  //
  // factory ImageModel.fromJson(Map<String, dynamic> json) {
  //   return ImageModel(
  //     userId: json['userId'],
  //     id: json['id'],
  //     title: json['title'],
  //   );
  // }
}