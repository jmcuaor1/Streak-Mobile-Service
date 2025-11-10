import 'package:freezed_annotation/freezed_annotation.dart';

part 'cv_model.freezed.dart';
part 'cv_model.g.dart';

@freezed
class CVModel with _$CVModel {
  const factory CVModel({
    required String id,
    required String fileName,
    required String originalName,
    required String fileType,
    required String fileUrl,
    required int fileSize,
    required bool isPublic,
    required bool isDefault,
    required DateTime uploadedAt,
    DateTime? lastModified,
    String? description,
    @Default([]) List<String> tags,
    @Default(0) int downloadCount,
    @Default(0) int viewCount,
  }) = _CVModel;

  factory CVModel.fromJson(Map<String, dynamic> json) => _$CVModelFromJson(json);
}

enum CVFileType {
  pdf('pdf', 'PDF', 'application/pdf'),
  doc('doc', 'DOC', 'application/msword'),
  docx('docx', 'DOCX', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document');

  const CVFileType(this.extension, this.displayName, this.mimeType);
  
  final String extension;
  final String displayName;
  final String mimeType;

  static CVFileType? fromExtension(String extension) {
    for (final type in CVFileType.values) {
      if (type.extension == extension.toLowerCase()) {
        return type;
      }
    }
    return null;
  }

  static CVFileType? fromMimeType(String mimeType) {
    for (final type in CVFileType.values) {
      if (type.mimeType == mimeType) {
        return type;
      }
    }
    return null;
  }
}

class CVUploadStatus {
  final bool isUploading;
  final double progress;
  final String? error;
  final CVModel? uploadedCV;

  const CVUploadStatus({
    this.isUploading = false,
    this.progress = 0.0,
    this.error,
    this.uploadedCV,
  });

  CVUploadStatus copyWith({
    bool? isUploading,
    double? progress,
    String? error,
    CVModel? uploadedCV,
  }) {
    return CVUploadStatus(
      isUploading: isUploading ?? this.isUploading,
      progress: progress ?? this.progress,
      error: error ?? this.error,
      uploadedCV: uploadedCV ?? this.uploadedCV,
    );
  }
}
