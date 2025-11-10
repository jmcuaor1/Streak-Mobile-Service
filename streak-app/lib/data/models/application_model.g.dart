// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationModelImpl _$$ApplicationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ApplicationModelImpl(
      id: json['_id'] as String,
      jobId: json['jobId'] as String,
      freelancerId: json['freelancerId'] as String,
      freelancerName: json['freelancerName'] as String,
      jobTitle: json['jobTitle'] as String,
      proposal: json['proposal'] as String,
      bidAmount: (json['bidAmount'] as num?)?.toDouble(),
      status: json['status'] as String,
      appliedAt: DateTime.parse(json['appliedAt'] as String),
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
      clientNotes: json['clientNotes'] as String?,
    );

Map<String, dynamic> _$$ApplicationModelImplToJson(
        _$ApplicationModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'jobId': instance.jobId,
      'freelancerId': instance.freelancerId,
      'freelancerName': instance.freelancerName,
      'jobTitle': instance.jobTitle,
      'proposal': instance.proposal,
      'bidAmount': instance.bidAmount,
      'status': instance.status,
      'appliedAt': instance.appliedAt.toIso8601String(),
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
      'clientNotes': instance.clientNotes,
    };
