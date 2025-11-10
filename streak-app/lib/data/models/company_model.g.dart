// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CompanyModelImpl _$$CompanyModelImplFromJson(Map<String, dynamic> json) =>
    _$CompanyModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      website: json['website'] as String,
      industry: json['industry'] as String,
      size: json['size'] as String,
      location: json['location'] as String,
      founded: json['founded'] as String,
      logo: json['logo'] as String?,
      coverImage: json['coverImage'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
      jobsCount: (json['jobsCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      benefits: (json['benefits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technologies: (json['technologies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      recentJobs: (json['recentJobs'] as List<dynamic>?)
              ?.map((e) => CompanyJob.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => CompanyReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      gallery: (json['gallery'] as List<dynamic>?)
              ?.map((e) => CompanyGallery.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CompanyModelImplToJson(_$CompanyModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tagline': instance.tagline,
      'description': instance.description,
      'website': instance.website,
      'industry': instance.industry,
      'size': instance.size,
      'location': instance.location,
      'founded': instance.founded,
      'logo': instance.logo,
      'coverImage': instance.coverImage,
      'isVerified': instance.isVerified,
      'followersCount': instance.followersCount,
      'jobsCount': instance.jobsCount,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'benefits': instance.benefits,
      'technologies': instance.technologies,
      'locations': instance.locations,
      'recentJobs': instance.recentJobs,
      'reviews': instance.reviews,
      'gallery': instance.gallery,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$CompanyJobImpl _$$CompanyJobImplFromJson(Map<String, dynamic> json) =>
    _$CompanyJobImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      salary: json['salary'] as String,
      posted: json['posted'] as String,
      isUrgent: json['isUrgent'] as bool? ?? false,
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CompanyJobImplToJson(_$CompanyJobImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'location': instance.location,
      'salary': instance.salary,
      'posted': instance.posted,
      'isUrgent': instance.isUrgent,
      'skills': instance.skills,
    };

_$CompanyReviewImpl _$$CompanyReviewImplFromJson(Map<String, dynamic> json) =>
    _$CompanyReviewImpl(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorRole: json['authorRole'] as String,
      authorAvatar: json['authorAvatar'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      pros:
          (json['pros'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      cons:
          (json['cons'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$$CompanyReviewImplToJson(_$CompanyReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorName': instance.authorName,
      'authorRole': instance.authorRole,
      'authorAvatar': instance.authorAvatar,
      'rating': instance.rating,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date.toIso8601String(),
      'pros': instance.pros,
      'cons': instance.cons,
      'isVerified': instance.isVerified,
    };

_$CompanyGalleryImpl _$$CompanyGalleryImplFromJson(Map<String, dynamic> json) =>
    _$CompanyGalleryImpl(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String,
      type: json['type'] as String,
      uploadedAt: json['uploadedAt'] == null
          ? null
          : DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$$CompanyGalleryImplToJson(
        _$CompanyGalleryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'caption': instance.caption,
      'type': instance.type,
      'uploadedAt': instance.uploadedAt?.toIso8601String(),
    };
