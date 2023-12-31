import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

class ImageEntity {
  int? imageGuid;
  String? imageUrl;
  bool? isMain;
  String? fileName;
  String? fileExtension;
  String? fileContent;
  File? fileImage;
  int? diaryFarmerId;
  String? type;
  String? contentView;
  String? filePath;

  ImageEntity(
      {this.imageGuid,
        this.imageUrl,
        this.isMain,
        this.fileName,
        this.fileContent,
        this.fileImage,
        this.fileExtension, this.diaryFarmerId, this.type, this.filePath, this.contentView});

/*  static Future<File?> base64ToFile(String? base64String, String fileName) async {
    if (base64String == null) return null;

    try {
      // Convert the base64 string to Uint8List binary data
      Uint8List uint8List = base64Decode(base64String);

      // Get the document directory using path_provider package
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String filePath = '${appDocDir.path}/$fileName';

      // Write the binary data to the file
      File file = File(filePath);
      await file.writeAsBytes(uint8List);

      return file;
    } catch (e) {
      print('Error converting Base64 to File: $e');
      return null;
    }
  }*/

  // Factory constructor for JSON conversion
  factory ImageEntity.fromJson(Map<String, dynamic> json) {
    File? fileImage;

    // Call the base64ToFile method and handle the Future using then
/*    base64ToFile(fileContent, fileName).then((file) {
      fileImage = file;
    }).catchError((error) {
      print('Error loading file image: $error');
    });*/

    return ImageEntity(
      imageGuid: json['id'] ?? -1,
      imageUrl: json['imageUrl'] ?? '',
      isMain: json['isMain'] ?? false,
      fileName: json['file_name'] ?? '',
      fileExtension: json['fileExtension'] ?? '',
      fileContent: json['media_content'] ?? '',
      diaryFarmerId: json['diary_farmer_id'] ?? -1,
      type: json['type'] ?? '',
      filePath: json['filePath'],
      contentView: json['media_content'],
      fileImage: fileImage,
    );
  }

  // Phương thức chuyển đổi từ đối tượng ImageEntity thành JSON
  Map<String, dynamic> toJson() {
    return {
      'id': imageGuid,
      'type': type,
      'media_content': fileContent,
      'diary_farmer_id': diaryFarmerId,
      'imageUrl': imageUrl,
      'isMain': isMain,
      'fileName': fileName,
      'fileExtension': fileExtension,
      'filePath': filePath,
      'contentView': contentView,
    };
  }

}

class FeedbackMedia {
  String? mediaContent;

  FeedbackMedia(
      {this.mediaContent});


  // Factory constructor for JSON conversion
  factory FeedbackMedia.fromJson(Map<String, dynamic> json) {
    File? fileImage;

    return FeedbackMedia(
      mediaContent: json['media_content'] ?? '',
    );
  }

  // Phương thức chuyển đổi từ đối tượng ImageEntity thành JSON
  Map<String, dynamic> toJson() {
    return {
      'media_content': mediaContent,
    };
  }

}
