class WordEntryModel {
  final String? id;
  final String? lemma;
  final List<Senses>? senses;
  const WordEntryModel({this.id, this.lemma, this.senses});
  WordEntryModel copyWith({String? id, String? lemma, List<Senses>? senses}) {
    return WordEntryModel(
      id: id ?? this.id,
      lemma: lemma ?? this.lemma,
      senses: senses ?? this.senses,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'lemma': lemma,
      'senses': senses
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static WordEntryModel fromJson(Map<String, Object?> json) {
    return WordEntryModel(
      id: json['id'] == null ? null : json['id'] as String,
      lemma: json['lemma'] == null ? null : json['lemma'] as String,
      senses: json['senses'] == null
          ? null
          : (json['senses'] as List)
                .map<Senses>(
                  (data) => Senses.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  @override
  String toString() {
    return '''WordEntryModel(
                id:$id,
lemma:$lemma,
senses:${senses.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is WordEntryModel &&
        other.runtimeType == runtimeType &&
        other.id == id &&
        other.lemma == lemma &&
        other.senses == senses;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, lemma, senses);
  }
}

class Senses {
  final String? pos;
  final String? definition;
  final String? tone;
  final String? pronunciation;
  final List<Variants>? variants;
  const Senses({
    this.pos,
    this.definition,
    this.tone,
    this.pronunciation,
    this.variants,
  });
  Senses copyWith({
    String? pos,
    String? definition,
    String? tone,
    String? pronunciation,
    List<Variants>? variants,
  }) {
    return Senses(
      pos: pos ?? this.pos,
      definition: definition ?? this.definition,
      tone: tone ?? this.tone,
      pronunciation: pronunciation ?? this.pronunciation,
      variants: variants ?? this.variants,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'pos': pos,
      'definition': definition,
      'tone': tone,
      'pronunciation': pronunciation,
      'variants': variants
          ?.map<Map<String, dynamic>>((data) => data.toJson())
          .toList(),
    };
  }

  static Senses fromJson(Map<String, Object?> json) {
    return Senses(
      pos: json['pos'] == null ? null : json['pos'] as String,
      definition: json['definition'] == null
          ? null
          : json['definition'] as String,
      tone: json['tone'] == null ? null : json['tone'] as String,
      pronunciation: json['pronunciation'] == null
          ? null
          : json['pronunciation'] as String,
      variants: json['variants'] == null
          ? null
          : (json['variants'] as List)
                .map<Variants>(
                  (data) => Variants.fromJson(data as Map<String, Object?>),
                )
                .toList(),
    );
  }

  @override
  String toString() {
    return '''Senses(
                pos:$pos,
definition:$definition,
tone:$tone,
pronunciation:$pronunciation,
variants:${variants.toString()}
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Senses &&
        other.runtimeType == runtimeType &&
        other.pos == pos &&
        other.definition == definition &&
        other.tone == tone &&
        other.pronunciation == pronunciation &&
        other.variants == variants;
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      pos,
      definition,
      tone,
      pronunciation,
      variants,
    );
  }
}

class Variants {
  final String? form;
  final String? region;
  final String? tribe;
  final String? tone;
  final String? pronunciation;
  const Variants({
    this.form,
    this.region,
    this.tribe,
    this.tone,
    this.pronunciation,
  });
  Variants copyWith({
    String? form,
    String? region,
    String? tribe,
    String? tone,
    String? pronunciation,
  }) {
    return Variants(
      form: form ?? this.form,
      region: region ?? this.region,
      tribe: tribe ?? this.tribe,
      tone: tone ?? this.tone,
      pronunciation: pronunciation ?? this.pronunciation,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'form': form,
      'region': region,
      'tribe': tribe,
      'tone': tone,
      'pronunciation': pronunciation,
    };
  }

  static Variants fromJson(Map<String, Object?> json) {
    return Variants(
      form: json['form'] == null ? null : json['form'] as String,
      region: json['region'] == null ? null : json['region'] as String,
      tribe: json['tribe'] == null ? null : json['tribe'] as String,
      tone: json['tone'] == null ? null : json['tone'] as String,
      pronunciation: json['pronunciation'] == null
          ? null
          : json['pronunciation'] as String,
    );
  }

  @override
  String toString() {
    return '''Variants(
                form:$form,
region:$region,
tribe:$tribe,
tone:$tone,
pronunciation:$pronunciation
    ) ''';
  }

  @override
  bool operator ==(Object other) {
    return other is Variants &&
        other.runtimeType == runtimeType &&
        other.form == form &&
        other.region == region &&
        other.tribe == tribe &&
        other.tone == tone &&
        other.pronunciation == pronunciation;
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, form, region, tribe, tone, pronunciation);
  }
}
