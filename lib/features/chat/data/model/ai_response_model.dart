class AiResponseModel {
  final List<Candidates>? candidates;
  final UsageMetadata? usageMetadata;
  final String? modelVersion;
  final String? responseId;

  AiResponseModel({
    this.candidates,
    this.usageMetadata,
    this.modelVersion,
    this.responseId,
  });

  factory AiResponseModel.fromJson(Map<String, dynamic> json) {
    return AiResponseModel(
      candidates: json['candidates'] != null
          ? (json['candidates'] as List)
              .map((v) => Candidates.fromJson(v))
              .toList()
          : null,
      usageMetadata: json['usageMetadata'] != null
          ? UsageMetadata.fromJson(json['usageMetadata'])
          : null,
      modelVersion: json['modelVersion'],
      responseId: json['responseId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates?.map((v) => v.toJson()).toList(),
      'usageMetadata': usageMetadata?.toJson(),
      'modelVersion': modelVersion,
      'responseId': responseId,
    };
  }
}

class Candidates {
  final Content? content;
  final String? finishReason;
  final double? avgLogprobs;

  Candidates({this.content, this.finishReason, this.avgLogprobs});

  factory Candidates.fromJson(Map<String, dynamic> json) {
    return Candidates(
      content: json['content'] != null ? Content.fromJson(json['content']) : null,
      finishReason: json['finishReason'],
      avgLogprobs: (json['avgLogprobs'] != null)
          ? (json['avgLogprobs'] as num).toDouble()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content?.toJson(),
      'finishReason': finishReason,
      'avgLogprobs': avgLogprobs,
    };
  }
}

class Content {
  final List<Parts>? parts;
  final String? role;

  Content({this.parts, this.role});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: json['parts'] != null
          ? (json['parts'] as List).map((v) => Parts.fromJson(v)).toList()
          : null,
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'parts': parts?.map((v) => v.toJson()).toList(),
      'role': role,
    };
  }
}

class Parts {
  final String? text;

  Parts({this.text});

  factory Parts.fromJson(Map<String, dynamic> json) {
    return Parts(text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {'text': text};
  }
}

class UsageMetadata {
  final int? promptTokenCount;
  final int? candidatesTokenCount;
  final int? totalTokenCount;
  final List<PromptTokensDetails>? promptTokensDetails;
  final List<CandidatesTokensDetails>? candidatesTokensDetails;

  UsageMetadata({
    this.promptTokenCount,
    this.candidatesTokenCount,
    this.totalTokenCount,
    this.promptTokensDetails,
    this.candidatesTokensDetails,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    return UsageMetadata(
      promptTokenCount: json['promptTokenCount'],
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
      promptTokensDetails: json['promptTokensDetails'] != null
          ? (json['promptTokensDetails'] as List)
              .map((v) => PromptTokensDetails.fromJson(v))
              .toList()
          : null,
      candidatesTokensDetails: json['candidatesTokensDetails'] != null
          ? (json['candidatesTokensDetails'] as List)
              .map((v) => CandidatesTokensDetails.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promptTokenCount': promptTokenCount,
      'candidatesTokenCount': candidatesTokenCount,
      'totalTokenCount': totalTokenCount,
      'promptTokensDetails': promptTokensDetails?.map((v) => v.toJson()).toList(),
      'candidatesTokensDetails':
          candidatesTokensDetails?.map((v) => v.toJson()).toList(),
    };
  }
}

class PromptTokensDetails {
  final String? modality;
  final int? tokenCount;

  PromptTokensDetails({this.modality, this.tokenCount});

  factory PromptTokensDetails.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetails(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modality': modality,
      'tokenCount': tokenCount,
    };
  }
}

class CandidatesTokensDetails {
  final String? modality;
  final int? tokenCount;

  CandidatesTokensDetails({this.modality, this.tokenCount});

  factory CandidatesTokensDetails.fromJson(Map<String, dynamic> json) {
    return CandidatesTokensDetails(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modality': modality,
      'tokenCount': tokenCount,
    };
  }
}