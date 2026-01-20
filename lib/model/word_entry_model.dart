import 'package:uuid/uuid.dart';

class WordEntryModel {
  final String? id;
  final String? baseForm;
  final List<Meanings>? meanings;
  const WordEntryModel({this.id, this.baseForm, this.meanings});

  WordEntryModel copyWith({
    String? id,
    String? baseForm,
    List<Meanings>? meanings,
  }) {
    return WordEntryModel(
      id: id ?? this.id,
      baseForm: baseForm ?? this.baseForm,
      meanings: meanings ?? this.meanings,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'base_form': baseForm,
      'meanings': meanings
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static WordEntryModel fromJson(Map<String, Object?> json) {
    return WordEntryModel(
      id: json['id'] == null ? null : json['id'] as String,
      baseForm: json['base_form'] == null ? null : json['base_form'] as String,
      meanings: json['meanings'] == null
          ? null
          : (json['meanings'] as List)
                .map<Meanings>(
                  (data) => Meanings.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  factory WordEntryModel.empty() =>
      WordEntryModel(id: '', baseForm: '', meanings: []);
}

class Meanings {
  final String? meaningId;
  final String? partOfSpeech;
  final String? definition;
  final String? example;
  final String? exampleTranslation;
  final List<Variants>? variants;
  Meanings({
    this.meaningId,
    this.partOfSpeech,
    this.definition,
    this.example,
    this.exampleTranslation,
    this.variants,
  });

  Meanings copyWith({
    String? meaningId,
    String? partOfSpeech,
    String? definition,
    String? example,
    String? exampleTranslation,
    List<Variants>? variants,
  }) {
    return Meanings(
      meaningId: meaningId ?? this.meaningId,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      exampleTranslation: exampleTranslation ?? this.exampleTranslation,
      variants: variants ?? this.variants,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'meaning_id': meaningId,
      'part_of_speech': partOfSpeech,
      'definition': definition,
      'example': example,
      'example_translation': exampleTranslation,
      'variants': variants
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static Meanings fromJson(Map<String, Object?> json) {
    return Meanings(
      meaningId: json['meaning_id'] == null
          ? null
          : json['meaning_id'] as String,
      partOfSpeech: json['part_of_speech'] == null
          ? null
          : json['part_of_speech'] as String,
      definition: json['definition'] == null
          ? null
          : json['definition'] as String,
      example: json['example'] == null ? null : json['example'] as String,
      exampleTranslation: json['example_translation'] == null
          ? null
          : json['example_translation'] as String,
      variants: json['variants'] == null
          ? null
          : (json['variants'] as List)
                .map<Variants>(
                  (data) => Variants.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  factory Meanings.empty() => Meanings(
    meaningId: '',
    partOfSpeech: '',
    definition: '',
    example: '',
    exampleTranslation: '',
    variants: [],
  );
}

class Variants {
  final String? form;
  final String? region;
  final String? tone;
  final String? pronunciation;
  const Variants({this.form, this.region, this.tone, this.pronunciation});
  Variants copyWith({
    String? form,
    String? region,
    String? tone,
    String? pronunciation,
  }) {
    return Variants(
      form: form ?? this.form,
      region: region ?? this.region,
      tone: tone ?? this.tone,
      pronunciation: pronunciation ?? this.pronunciation,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'form': form,
      'region': region,
      'tone': tone,
      'pronunciation': pronunciation,
    };
  }

  static Variants fromJson(Map<String, Object?> json) {
    return Variants(
      form: json['form'] == null ? null : json['form'] as String,
      region: json['region'] == null ? null : json['region'] as String,
      tone: json['tone'] == null ? null : json['tone'] as String,
      pronunciation: json['pronunciation'] == null
          ? null
          : json['pronunciation'] as String,
    );
  }

  factory Variants.empty() =>
      Variants(form: '', region: '', tone: '', pronunciation: '');
}
