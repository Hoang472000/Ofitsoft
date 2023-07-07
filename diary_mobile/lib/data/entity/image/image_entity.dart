import 'dart:io';

///Bkav Nhungltk: anh mat hang
class ImageEntity {
  String? imageGuid;
  String? imageUrl;
  bool? isMain;
  String? fileName;
  String? fileExtension;
  String? fileContent;

  File? fileImage;

  ImageEntity(
      {this.imageGuid,
        this.imageUrl,
        this.isMain,
        this.fileName,
        this.fileContent,
        this.fileImage,
        this.fileExtension});

}
