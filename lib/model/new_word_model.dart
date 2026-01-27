import 'package:uuid/uuid.dart';

class NewWordModel {
  final String? id;
  final String? baseForm;
  final String? pronunciation;
  final String? tone;
  final List<String>? variants;
  final List<Meanings>? meanings;
  const NewWordModel({
    this.id,
    this.baseForm,
    this.pronunciation,
    this.tone,
    this.variants,
    this.meanings,
  });
  NewWordModel copyWith({
    String? id,
    String? baseForm,
    String? pronunciation,
    String? tone,
    List<String>? variants,
    List<Meanings>? meanings,
  }) {
    return NewWordModel(
      id: id ?? this.id,
      baseForm: baseForm ?? this.baseForm,
      pronunciation: pronunciation ?? this.pronunciation,
      tone: tone ?? this.tone,
      variants: variants ?? this.variants,
      meanings: meanings ?? this.meanings,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'baseForm': baseForm,
      'pronunciation': pronunciation,
      'tone': tone,
      'variants': variants?.map<String>((data)=>data),
      'meanings': meanings
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static NewWordModel fromJson(Map<String, Object?> json) {
    return NewWordModel(
      id: json['id'] == null ? null : json['id'] as String,
      baseForm: json['baseForm'] == null ? null : json['baseForm'] as String,
      pronunciation: json['pronunciation'] == null
          ? null
          : json['pronunciation'] as String,
      tone: json['tone'] == null ? null : json['tone'] as String,
      variants: json['variants'] == null
          ? null
          : List<String>.from(json['variants'] as List),
      // json['variants'] as List<String>,
      meanings: json['meanings'] == null
          ? null
          : (json['meanings'] as List)
                .map<Meanings>(
                  (data) => Meanings.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  factory NewWordModel.empty() => NewWordModel(
    id: '',
    baseForm: '',
    pronunciation: '',
    tone: '',
    variants: [],
    meanings: [Meanings.empty().copyWith(meaningId: Uuid().v4())],
  );

  @override
  bool operator ==(Object other) {
    return other is NewWordModel &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.baseForm == baseForm &&
        other.pronunciation == pronunciation &&
        other.tone == tone &&
        other.variants == variants &&
        other.meanings == meanings;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      id,
      baseForm,
      pronunciation,
      tone,
      variants,
      meanings,
    );
  }
}

class Meanings {
  final String? meaningId;
  final String? partOfSpeech;
  final String? definition;
  final String? exampleNative;
  final String? exampleEnglish;
  const Meanings({
    this.meaningId,
    this.partOfSpeech,
    this.definition,
    this.exampleNative,
    this.exampleEnglish,
  });
  Meanings copyWith({
    String? meaningId,
    String? partOfSpeech,
    String? definition,
    String? exampleNative,
    String? exampleEnglish,
  }) {
    return Meanings(
      meaningId: meaningId ?? this.meaningId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definition: definition ?? this.definition,
      exampleNative: exampleNative ?? this.exampleNative,
      exampleEnglish: exampleEnglish ?? this.exampleEnglish,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'meaningId': meaningId,
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'exampleNative': exampleNative,
      'exampleEnglish': exampleEnglish,
    };
  }

  static Meanings fromJson(Map<String, Object?> json) {
    return Meanings(
      meaningId: json['meaningId'] == null ? null : json['meaningId'] as String,
      partOfSpeech: json['partOfSpeech'] == null
          ? null
          : json['partOfSpeech'] as String,
      definition: json['definition'] == null
          ? null
          : json['definition'] as String,
      exampleNative: json['exampleNative'] == null
          ? null
          : json['exampleNative'] as String,
      exampleEnglish: json['exampleEnglish'] == null
          ? null
          : json['exampleEnglish'] as String,
    );
  }

  factory Meanings.empty() => Meanings(
    meaningId: '',
    partOfSpeech: '',
    definition: '',
    exampleNative: '',
    exampleEnglish: '',
  );

  @override
  bool operator ==(Object other) {
    return other is Meanings &&
        other.runtimeType == runtimeType &&
        other.meaningId == meaningId &&
        other.partOfSpeech == partOfSpeech &&
        other.definition == definition &&
        other.exampleNative == exampleNative &&
        other.exampleEnglish == exampleEnglish;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      meaningId,
      partOfSpeech,
      definition,
      exampleNative,
      exampleEnglish,
    );
  }
}
