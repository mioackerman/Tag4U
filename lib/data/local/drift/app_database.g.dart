// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PersonsTableTable extends PersonsTable
    with TableInfo<$PersonsTableTable, PersonsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _mbtiMeta = const VerificationMeta('mbti');
  @override
  late final GeneratedColumn<String> mbti = GeneratedColumn<String>(
      'mbti', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hasVehicleMeta =
      const VerificationMeta('hasVehicle');
  @override
  late final GeneratedColumn<bool> hasVehicle = GeneratedColumn<bool>(
      'has_vehicle', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_vehicle" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _vehicleSeatsMeta =
      const VerificationMeta('vehicleSeats');
  @override
  late final GeneratedColumn<int> vehicleSeats = GeneratedColumn<int>(
      'vehicle_seats', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _freeformTagsJsonMeta =
      const VerificationMeta('freeformTagsJson');
  @override
  late final GeneratedColumn<String> freeformTagsJson = GeneratedColumn<String>(
      'freeform_tags_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _isPrivateMeta =
      const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
      'is_private', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_private" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        gender,
        mbti,
        hasVehicle,
        vehicleSeats,
        freeformTagsJson,
        isPrivate,
        countryCode,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<PersonsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('mbti')) {
      context.handle(
          _mbtiMeta, mbti.isAcceptableOrUnknown(data['mbti']!, _mbtiMeta));
    }
    if (data.containsKey('has_vehicle')) {
      context.handle(
          _hasVehicleMeta,
          hasVehicle.isAcceptableOrUnknown(
              data['has_vehicle']!, _hasVehicleMeta));
    }
    if (data.containsKey('vehicle_seats')) {
      context.handle(
          _vehicleSeatsMeta,
          vehicleSeats.isAcceptableOrUnknown(
              data['vehicle_seats']!, _vehicleSeatsMeta));
    }
    if (data.containsKey('freeform_tags_json')) {
      context.handle(
          _freeformTagsJsonMeta,
          freeformTagsJson.isAcceptableOrUnknown(
              data['freeform_tags_json']!, _freeformTagsJsonMeta));
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      mbti: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mbti']),
      hasVehicle: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_vehicle'])!,
      vehicleSeats: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vehicle_seats']),
      freeformTagsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}freeform_tags_json'])!,
      isPrivate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_private'])!,
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PersonsTableTable createAlias(String alias) {
    return $PersonsTableTable(attachedDatabase, alias);
  }
}

class PersonsTableData extends DataClass
    implements Insertable<PersonsTableData> {
  final String id;
  final String? userId;
  final String name;
  final String? gender;
  final String? mbti;
  final bool hasVehicle;
  final int? vehicleSeats;

  /// JSON-encoded List<String>.
  final String freeformTagsJson;
  final bool isPrivate;
  final String? countryCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PersonsTableData(
      {required this.id,
      this.userId,
      required this.name,
      this.gender,
      this.mbti,
      required this.hasVehicle,
      this.vehicleSeats,
      required this.freeformTagsJson,
      required this.isPrivate,
      this.countryCode,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || mbti != null) {
      map['mbti'] = Variable<String>(mbti);
    }
    map['has_vehicle'] = Variable<bool>(hasVehicle);
    if (!nullToAbsent || vehicleSeats != null) {
      map['vehicle_seats'] = Variable<int>(vehicleSeats);
    }
    map['freeform_tags_json'] = Variable<String>(freeformTagsJson);
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || countryCode != null) {
      map['country_code'] = Variable<String>(countryCode);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersonsTableCompanion toCompanion(bool nullToAbsent) {
    return PersonsTableCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      name: Value(name),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      mbti: mbti == null && nullToAbsent ? const Value.absent() : Value(mbti),
      hasVehicle: Value(hasVehicle),
      vehicleSeats: vehicleSeats == null && nullToAbsent
          ? const Value.absent()
          : Value(vehicleSeats),
      freeformTagsJson: Value(freeformTagsJson),
      isPrivate: Value(isPrivate),
      countryCode: countryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(countryCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersonsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String?>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String?>(json['gender']),
      mbti: serializer.fromJson<String?>(json['mbti']),
      hasVehicle: serializer.fromJson<bool>(json['hasVehicle']),
      vehicleSeats: serializer.fromJson<int?>(json['vehicleSeats']),
      freeformTagsJson: serializer.fromJson<String>(json['freeformTagsJson']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      countryCode: serializer.fromJson<String?>(json['countryCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String?>(userId),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String?>(gender),
      'mbti': serializer.toJson<String?>(mbti),
      'hasVehicle': serializer.toJson<bool>(hasVehicle),
      'vehicleSeats': serializer.toJson<int?>(vehicleSeats),
      'freeformTagsJson': serializer.toJson<String>(freeformTagsJson),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'countryCode': serializer.toJson<String?>(countryCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PersonsTableData copyWith(
          {String? id,
          Value<String?> userId = const Value.absent(),
          String? name,
          Value<String?> gender = const Value.absent(),
          Value<String?> mbti = const Value.absent(),
          bool? hasVehicle,
          Value<int?> vehicleSeats = const Value.absent(),
          String? freeformTagsJson,
          bool? isPrivate,
          Value<String?> countryCode = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PersonsTableData(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        name: name ?? this.name,
        gender: gender.present ? gender.value : this.gender,
        mbti: mbti.present ? mbti.value : this.mbti,
        hasVehicle: hasVehicle ?? this.hasVehicle,
        vehicleSeats:
            vehicleSeats.present ? vehicleSeats.value : this.vehicleSeats,
        freeformTagsJson: freeformTagsJson ?? this.freeformTagsJson,
        isPrivate: isPrivate ?? this.isPrivate,
        countryCode: countryCode.present ? countryCode.value : this.countryCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PersonsTableData copyWithCompanion(PersonsTableCompanion data) {
    return PersonsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      mbti: data.mbti.present ? data.mbti.value : this.mbti,
      hasVehicle:
          data.hasVehicle.present ? data.hasVehicle.value : this.hasVehicle,
      vehicleSeats: data.vehicleSeats.present
          ? data.vehicleSeats.value
          : this.vehicleSeats,
      freeformTagsJson: data.freeformTagsJson.present
          ? data.freeformTagsJson.value
          : this.freeformTagsJson,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('mbti: $mbti, ')
          ..write('hasVehicle: $hasVehicle, ')
          ..write('vehicleSeats: $vehicleSeats, ')
          ..write('freeformTagsJson: $freeformTagsJson, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('countryCode: $countryCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      gender,
      mbti,
      hasVehicle,
      vehicleSeats,
      freeformTagsJson,
      isPrivate,
      countryCode,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.mbti == this.mbti &&
          other.hasVehicle == this.hasVehicle &&
          other.vehicleSeats == this.vehicleSeats &&
          other.freeformTagsJson == this.freeformTagsJson &&
          other.isPrivate == this.isPrivate &&
          other.countryCode == this.countryCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonsTableCompanion extends UpdateCompanion<PersonsTableData> {
  final Value<String> id;
  final Value<String?> userId;
  final Value<String> name;
  final Value<String?> gender;
  final Value<String?> mbti;
  final Value<bool> hasVehicle;
  final Value<int?> vehicleSeats;
  final Value<String> freeformTagsJson;
  final Value<bool> isPrivate;
  final Value<String?> countryCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PersonsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.mbti = const Value.absent(),
    this.hasVehicle = const Value.absent(),
    this.vehicleSeats = const Value.absent(),
    this.freeformTagsJson = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PersonsTableCompanion.insert({
    required String id,
    this.userId = const Value.absent(),
    required String name,
    this.gender = const Value.absent(),
    this.mbti = const Value.absent(),
    this.hasVehicle = const Value.absent(),
    this.vehicleSeats = const Value.absent(),
    this.freeformTagsJson = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.countryCode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PersonsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? mbti,
    Expression<bool>? hasVehicle,
    Expression<int>? vehicleSeats,
    Expression<String>? freeformTagsJson,
    Expression<bool>? isPrivate,
    Expression<String>? countryCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (mbti != null) 'mbti': mbti,
      if (hasVehicle != null) 'has_vehicle': hasVehicle,
      if (vehicleSeats != null) 'vehicle_seats': vehicleSeats,
      if (freeformTagsJson != null) 'freeform_tags_json': freeformTagsJson,
      if (isPrivate != null) 'is_private': isPrivate,
      if (countryCode != null) 'country_code': countryCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PersonsTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? userId,
      Value<String>? name,
      Value<String?>? gender,
      Value<String?>? mbti,
      Value<bool>? hasVehicle,
      Value<int?>? vehicleSeats,
      Value<String>? freeformTagsJson,
      Value<bool>? isPrivate,
      Value<String?>? countryCode,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PersonsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      mbti: mbti ?? this.mbti,
      hasVehicle: hasVehicle ?? this.hasVehicle,
      vehicleSeats: vehicleSeats ?? this.vehicleSeats,
      freeformTagsJson: freeformTagsJson ?? this.freeformTagsJson,
      isPrivate: isPrivate ?? this.isPrivate,
      countryCode: countryCode ?? this.countryCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (mbti.present) {
      map['mbti'] = Variable<String>(mbti.value);
    }
    if (hasVehicle.present) {
      map['has_vehicle'] = Variable<bool>(hasVehicle.value);
    }
    if (vehicleSeats.present) {
      map['vehicle_seats'] = Variable<int>(vehicleSeats.value);
    }
    if (freeformTagsJson.present) {
      map['freeform_tags_json'] = Variable<String>(freeformTagsJson.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('mbti: $mbti, ')
          ..write('hasVehicle: $hasVehicle, ')
          ..write('vehicleSeats: $vehicleSeats, ')
          ..write('freeformTagsJson: $freeformTagsJson, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('countryCode: $countryCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlacesTableTable extends PlacesTable
    with TableInfo<$PlacesTableTable, PlacesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('other'));
  static const VerificationMeta _externalIdMeta =
      const VerificationMeta('externalId');
  @override
  late final GeneratedColumn<String> externalId = GeneratedColumn<String>(
      'external_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _priceLevelMeta =
      const VerificationMeta('priceLevel');
  @override
  late final GeneratedColumn<int> priceLevel = GeneratedColumn<int>(
      'price_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _publicRatingMeta =
      const VerificationMeta('publicRating');
  @override
  late final GeneratedColumn<double> publicRating = GeneratedColumn<double>(
      'public_rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _personalNoteMeta =
      const VerificationMeta('personalNote');
  @override
  late final GeneratedColumn<String> personalNote = GeneratedColumn<String>(
      'personal_note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _personalScoreMeta =
      const VerificationMeta('personalScore');
  @override
  late final GeneratedColumn<double> personalScore = GeneratedColumn<double>(
      'personal_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lastVisitedAtMeta =
      const VerificationMeta('lastVisitedAt');
  @override
  late final GeneratedColumn<DateTime> lastVisitedAt =
      GeneratedColumn<DateTime>('last_visited_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _layerMeta = const VerificationMeta('layer');
  @override
  late final GeneratedColumn<String> layer = GeneratedColumn<String>(
      'layer', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('public'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        latitude,
        longitude,
        address,
        city,
        countryCode,
        category,
        externalId,
        priceLevel,
        publicRating,
        personalNote,
        personalScore,
        lastVisitedAt,
        layer,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(Insertable<PlacesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('external_id')) {
      context.handle(
          _externalIdMeta,
          externalId.isAcceptableOrUnknown(
              data['external_id']!, _externalIdMeta));
    }
    if (data.containsKey('price_level')) {
      context.handle(
          _priceLevelMeta,
          priceLevel.isAcceptableOrUnknown(
              data['price_level']!, _priceLevelMeta));
    }
    if (data.containsKey('public_rating')) {
      context.handle(
          _publicRatingMeta,
          publicRating.isAcceptableOrUnknown(
              data['public_rating']!, _publicRatingMeta));
    }
    if (data.containsKey('personal_note')) {
      context.handle(
          _personalNoteMeta,
          personalNote.isAcceptableOrUnknown(
              data['personal_note']!, _personalNoteMeta));
    }
    if (data.containsKey('personal_score')) {
      context.handle(
          _personalScoreMeta,
          personalScore.isAcceptableOrUnknown(
              data['personal_score']!, _personalScoreMeta));
    }
    if (data.containsKey('last_visited_at')) {
      context.handle(
          _lastVisitedAtMeta,
          lastVisitedAt.isAcceptableOrUnknown(
              data['last_visited_at']!, _lastVisitedAtMeta));
    }
    if (data.containsKey('layer')) {
      context.handle(
          _layerMeta, layer.isAcceptableOrUnknown(data['layer']!, _layerMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlacesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlacesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      externalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}external_id']),
      priceLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price_level']),
      publicRating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}public_rating']),
      personalNote: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}personal_note']),
      personalScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}personal_score']),
      lastVisitedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_visited_at']),
      layer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}layer'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PlacesTableTable createAlias(String alias) {
    return $PlacesTableTable(attachedDatabase, alias);
  }
}

class PlacesTableData extends DataClass implements Insertable<PlacesTableData> {
  final String id;
  final String name;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? city;
  final String? countryCode;

  /// Stored as string name of [PlaceCategory] enum.
  final String category;
  final String? externalId;
  final int? priceLevel;
  final double? publicRating;
  final String? personalNote;
  final double? personalScore;
  final DateTime? lastVisitedAt;

  /// 'public' or 'personal'
  final String layer;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlacesTableData(
      {required this.id,
      required this.name,
      this.latitude,
      this.longitude,
      this.address,
      this.city,
      this.countryCode,
      required this.category,
      this.externalId,
      this.priceLevel,
      this.publicRating,
      this.personalNote,
      this.personalScore,
      this.lastVisitedAt,
      required this.layer,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || countryCode != null) {
      map['country_code'] = Variable<String>(countryCode);
    }
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || externalId != null) {
      map['external_id'] = Variable<String>(externalId);
    }
    if (!nullToAbsent || priceLevel != null) {
      map['price_level'] = Variable<int>(priceLevel);
    }
    if (!nullToAbsent || publicRating != null) {
      map['public_rating'] = Variable<double>(publicRating);
    }
    if (!nullToAbsent || personalNote != null) {
      map['personal_note'] = Variable<String>(personalNote);
    }
    if (!nullToAbsent || personalScore != null) {
      map['personal_score'] = Variable<double>(personalScore);
    }
    if (!nullToAbsent || lastVisitedAt != null) {
      map['last_visited_at'] = Variable<DateTime>(lastVisitedAt);
    }
    map['layer'] = Variable<String>(layer);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlacesTableCompanion toCompanion(bool nullToAbsent) {
    return PlacesTableCompanion(
      id: Value(id),
      name: Value(name),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      countryCode: countryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(countryCode),
      category: Value(category),
      externalId: externalId == null && nullToAbsent
          ? const Value.absent()
          : Value(externalId),
      priceLevel: priceLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(priceLevel),
      publicRating: publicRating == null && nullToAbsent
          ? const Value.absent()
          : Value(publicRating),
      personalNote: personalNote == null && nullToAbsent
          ? const Value.absent()
          : Value(personalNote),
      personalScore: personalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(personalScore),
      lastVisitedAt: lastVisitedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVisitedAt),
      layer: Value(layer),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlacesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlacesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      address: serializer.fromJson<String?>(json['address']),
      city: serializer.fromJson<String?>(json['city']),
      countryCode: serializer.fromJson<String?>(json['countryCode']),
      category: serializer.fromJson<String>(json['category']),
      externalId: serializer.fromJson<String?>(json['externalId']),
      priceLevel: serializer.fromJson<int?>(json['priceLevel']),
      publicRating: serializer.fromJson<double?>(json['publicRating']),
      personalNote: serializer.fromJson<String?>(json['personalNote']),
      personalScore: serializer.fromJson<double?>(json['personalScore']),
      lastVisitedAt: serializer.fromJson<DateTime?>(json['lastVisitedAt']),
      layer: serializer.fromJson<String>(json['layer']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'address': serializer.toJson<String?>(address),
      'city': serializer.toJson<String?>(city),
      'countryCode': serializer.toJson<String?>(countryCode),
      'category': serializer.toJson<String>(category),
      'externalId': serializer.toJson<String?>(externalId),
      'priceLevel': serializer.toJson<int?>(priceLevel),
      'publicRating': serializer.toJson<double?>(publicRating),
      'personalNote': serializer.toJson<String?>(personalNote),
      'personalScore': serializer.toJson<double?>(personalScore),
      'lastVisitedAt': serializer.toJson<DateTime?>(lastVisitedAt),
      'layer': serializer.toJson<String>(layer),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlacesTableData copyWith(
          {String? id,
          String? name,
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> countryCode = const Value.absent(),
          String? category,
          Value<String?> externalId = const Value.absent(),
          Value<int?> priceLevel = const Value.absent(),
          Value<double?> publicRating = const Value.absent(),
          Value<String?> personalNote = const Value.absent(),
          Value<double?> personalScore = const Value.absent(),
          Value<DateTime?> lastVisitedAt = const Value.absent(),
          String? layer,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PlacesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        address: address.present ? address.value : this.address,
        city: city.present ? city.value : this.city,
        countryCode: countryCode.present ? countryCode.value : this.countryCode,
        category: category ?? this.category,
        externalId: externalId.present ? externalId.value : this.externalId,
        priceLevel: priceLevel.present ? priceLevel.value : this.priceLevel,
        publicRating:
            publicRating.present ? publicRating.value : this.publicRating,
        personalNote:
            personalNote.present ? personalNote.value : this.personalNote,
        personalScore:
            personalScore.present ? personalScore.value : this.personalScore,
        lastVisitedAt:
            lastVisitedAt.present ? lastVisitedAt.value : this.lastVisitedAt,
        layer: layer ?? this.layer,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PlacesTableData copyWithCompanion(PlacesTableCompanion data) {
    return PlacesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      category: data.category.present ? data.category.value : this.category,
      externalId:
          data.externalId.present ? data.externalId.value : this.externalId,
      priceLevel:
          data.priceLevel.present ? data.priceLevel.value : this.priceLevel,
      publicRating: data.publicRating.present
          ? data.publicRating.value
          : this.publicRating,
      personalNote: data.personalNote.present
          ? data.personalNote.value
          : this.personalNote,
      personalScore: data.personalScore.present
          ? data.personalScore.value
          : this.personalScore,
      lastVisitedAt: data.lastVisitedAt.present
          ? data.lastVisitedAt.value
          : this.lastVisitedAt,
      layer: data.layer.present ? data.layer.value : this.layer,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('countryCode: $countryCode, ')
          ..write('category: $category, ')
          ..write('externalId: $externalId, ')
          ..write('priceLevel: $priceLevel, ')
          ..write('publicRating: $publicRating, ')
          ..write('personalNote: $personalNote, ')
          ..write('personalScore: $personalScore, ')
          ..write('lastVisitedAt: $lastVisitedAt, ')
          ..write('layer: $layer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      latitude,
      longitude,
      address,
      city,
      countryCode,
      category,
      externalId,
      priceLevel,
      publicRating,
      personalNote,
      personalScore,
      lastVisitedAt,
      layer,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlacesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.address == this.address &&
          other.city == this.city &&
          other.countryCode == this.countryCode &&
          other.category == this.category &&
          other.externalId == this.externalId &&
          other.priceLevel == this.priceLevel &&
          other.publicRating == this.publicRating &&
          other.personalNote == this.personalNote &&
          other.personalScore == this.personalScore &&
          other.lastVisitedAt == this.lastVisitedAt &&
          other.layer == this.layer &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlacesTableCompanion extends UpdateCompanion<PlacesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> address;
  final Value<String?> city;
  final Value<String?> countryCode;
  final Value<String> category;
  final Value<String?> externalId;
  final Value<int?> priceLevel;
  final Value<double?> publicRating;
  final Value<String?> personalNote;
  final Value<double?> personalScore;
  final Value<DateTime?> lastVisitedAt;
  final Value<String> layer;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PlacesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.category = const Value.absent(),
    this.externalId = const Value.absent(),
    this.priceLevel = const Value.absent(),
    this.publicRating = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.personalScore = const Value.absent(),
    this.lastVisitedAt = const Value.absent(),
    this.layer = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlacesTableCompanion.insert({
    required String id,
    required String name,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.category = const Value.absent(),
    this.externalId = const Value.absent(),
    this.priceLevel = const Value.absent(),
    this.publicRating = const Value.absent(),
    this.personalNote = const Value.absent(),
    this.personalScore = const Value.absent(),
    this.lastVisitedAt = const Value.absent(),
    this.layer = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PlacesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? countryCode,
    Expression<String>? category,
    Expression<String>? externalId,
    Expression<int>? priceLevel,
    Expression<double>? publicRating,
    Expression<String>? personalNote,
    Expression<double>? personalScore,
    Expression<DateTime>? lastVisitedAt,
    Expression<String>? layer,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (countryCode != null) 'country_code': countryCode,
      if (category != null) 'category': category,
      if (externalId != null) 'external_id': externalId,
      if (priceLevel != null) 'price_level': priceLevel,
      if (publicRating != null) 'public_rating': publicRating,
      if (personalNote != null) 'personal_note': personalNote,
      if (personalScore != null) 'personal_score': personalScore,
      if (lastVisitedAt != null) 'last_visited_at': lastVisitedAt,
      if (layer != null) 'layer': layer,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlacesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? address,
      Value<String?>? city,
      Value<String?>? countryCode,
      Value<String>? category,
      Value<String?>? externalId,
      Value<int?>? priceLevel,
      Value<double?>? publicRating,
      Value<String?>? personalNote,
      Value<double?>? personalScore,
      Value<DateTime?>? lastVisitedAt,
      Value<String>? layer,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PlacesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      city: city ?? this.city,
      countryCode: countryCode ?? this.countryCode,
      category: category ?? this.category,
      externalId: externalId ?? this.externalId,
      priceLevel: priceLevel ?? this.priceLevel,
      publicRating: publicRating ?? this.publicRating,
      personalNote: personalNote ?? this.personalNote,
      personalScore: personalScore ?? this.personalScore,
      lastVisitedAt: lastVisitedAt ?? this.lastVisitedAt,
      layer: layer ?? this.layer,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (externalId.present) {
      map['external_id'] = Variable<String>(externalId.value);
    }
    if (priceLevel.present) {
      map['price_level'] = Variable<int>(priceLevel.value);
    }
    if (publicRating.present) {
      map['public_rating'] = Variable<double>(publicRating.value);
    }
    if (personalNote.present) {
      map['personal_note'] = Variable<String>(personalNote.value);
    }
    if (personalScore.present) {
      map['personal_score'] = Variable<double>(personalScore.value);
    }
    if (lastVisitedAt.present) {
      map['last_visited_at'] = Variable<DateTime>(lastVisitedAt.value);
    }
    if (layer.present) {
      map['layer'] = Variable<String>(layer.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('countryCode: $countryCode, ')
          ..write('category: $category, ')
          ..write('externalId: $externalId, ')
          ..write('priceLevel: $priceLevel, ')
          ..write('publicRating: $publicRating, ')
          ..write('personalNote: $personalNote, ')
          ..write('personalScore: $personalScore, ')
          ..write('lastVisitedAt: $lastVisitedAt, ')
          ..write('layer: $layer, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PreferenceTagsTableTable extends PreferenceTagsTable
    with TableInfo<$PreferenceTagsTableTable, PreferenceTagsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PreferenceTagsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personNodeIdMeta =
      const VerificationMeta('personNodeId');
  @override
  late final GeneratedColumn<String> personNodeId = GeneratedColumn<String>(
      'person_node_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES persons (id) ON DELETE CASCADE'));
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sentimentMeta =
      const VerificationMeta('sentiment');
  @override
  late final GeneratedColumn<String> sentiment = GeneratedColumn<String>(
      'sentiment', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('neutral'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.5));
  static const VerificationMeta _contextMeta =
      const VerificationMeta('context');
  @override
  late final GeneratedColumn<String> context = GeneratedColumn<String>(
      'context', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('user_explicit'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        personNodeId,
        label,
        sentiment,
        weight,
        context,
        source,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'preference_tags';
  @override
  VerificationContext validateIntegrity(
      Insertable<PreferenceTagsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('person_node_id')) {
      context.handle(
          _personNodeIdMeta,
          personNodeId.isAcceptableOrUnknown(
              data['person_node_id']!, _personNodeIdMeta));
    } else if (isInserting) {
      context.missing(_personNodeIdMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('sentiment')) {
      context.handle(_sentimentMeta,
          sentiment.isAcceptableOrUnknown(data['sentiment']!, _sentimentMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('context')) {
      context.handle(_contextMeta,
          this.context.isAcceptableOrUnknown(data['context']!, _contextMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PreferenceTagsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PreferenceTagsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      personNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_node_id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      sentiment: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sentiment'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      context: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $PreferenceTagsTableTable createAlias(String alias) {
    return $PreferenceTagsTableTable(attachedDatabase, alias);
  }
}

class PreferenceTagsTableData extends DataClass
    implements Insertable<PreferenceTagsTableData> {
  final String id;
  final String personNodeId;
  final String label;

  /// 'positive' | 'negative' | 'neutral'
  final String sentiment;
  final double weight;
  final String? context;

  /// 'user_explicit' | 'inferred' | 'feedback_loop'
  final String source;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PreferenceTagsTableData(
      {required this.id,
      required this.personNodeId,
      required this.label,
      required this.sentiment,
      required this.weight,
      this.context,
      required this.source,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['person_node_id'] = Variable<String>(personNodeId);
    map['label'] = Variable<String>(label);
    map['sentiment'] = Variable<String>(sentiment);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || context != null) {
      map['context'] = Variable<String>(context);
    }
    map['source'] = Variable<String>(source);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PreferenceTagsTableCompanion toCompanion(bool nullToAbsent) {
    return PreferenceTagsTableCompanion(
      id: Value(id),
      personNodeId: Value(personNodeId),
      label: Value(label),
      sentiment: Value(sentiment),
      weight: Value(weight),
      context: context == null && nullToAbsent
          ? const Value.absent()
          : Value(context),
      source: Value(source),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PreferenceTagsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PreferenceTagsTableData(
      id: serializer.fromJson<String>(json['id']),
      personNodeId: serializer.fromJson<String>(json['personNodeId']),
      label: serializer.fromJson<String>(json['label']),
      sentiment: serializer.fromJson<String>(json['sentiment']),
      weight: serializer.fromJson<double>(json['weight']),
      context: serializer.fromJson<String?>(json['context']),
      source: serializer.fromJson<String>(json['source']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'personNodeId': serializer.toJson<String>(personNodeId),
      'label': serializer.toJson<String>(label),
      'sentiment': serializer.toJson<String>(sentiment),
      'weight': serializer.toJson<double>(weight),
      'context': serializer.toJson<String?>(context),
      'source': serializer.toJson<String>(source),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PreferenceTagsTableData copyWith(
          {String? id,
          String? personNodeId,
          String? label,
          String? sentiment,
          double? weight,
          Value<String?> context = const Value.absent(),
          String? source,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      PreferenceTagsTableData(
        id: id ?? this.id,
        personNodeId: personNodeId ?? this.personNodeId,
        label: label ?? this.label,
        sentiment: sentiment ?? this.sentiment,
        weight: weight ?? this.weight,
        context: context.present ? context.value : this.context,
        source: source ?? this.source,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  PreferenceTagsTableData copyWithCompanion(PreferenceTagsTableCompanion data) {
    return PreferenceTagsTableData(
      id: data.id.present ? data.id.value : this.id,
      personNodeId: data.personNodeId.present
          ? data.personNodeId.value
          : this.personNodeId,
      label: data.label.present ? data.label.value : this.label,
      sentiment: data.sentiment.present ? data.sentiment.value : this.sentiment,
      weight: data.weight.present ? data.weight.value : this.weight,
      context: data.context.present ? data.context.value : this.context,
      source: data.source.present ? data.source.value : this.source,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceTagsTableData(')
          ..write('id: $id, ')
          ..write('personNodeId: $personNodeId, ')
          ..write('label: $label, ')
          ..write('sentiment: $sentiment, ')
          ..write('weight: $weight, ')
          ..write('context: $context, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, personNodeId, label, sentiment, weight,
      context, source, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PreferenceTagsTableData &&
          other.id == this.id &&
          other.personNodeId == this.personNodeId &&
          other.label == this.label &&
          other.sentiment == this.sentiment &&
          other.weight == this.weight &&
          other.context == this.context &&
          other.source == this.source &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PreferenceTagsTableCompanion
    extends UpdateCompanion<PreferenceTagsTableData> {
  final Value<String> id;
  final Value<String> personNodeId;
  final Value<String> label;
  final Value<String> sentiment;
  final Value<double> weight;
  final Value<String?> context;
  final Value<String> source;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PreferenceTagsTableCompanion({
    this.id = const Value.absent(),
    this.personNodeId = const Value.absent(),
    this.label = const Value.absent(),
    this.sentiment = const Value.absent(),
    this.weight = const Value.absent(),
    this.context = const Value.absent(),
    this.source = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PreferenceTagsTableCompanion.insert({
    required String id,
    required String personNodeId,
    required String label,
    this.sentiment = const Value.absent(),
    this.weight = const Value.absent(),
    this.context = const Value.absent(),
    this.source = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        personNodeId = Value(personNodeId),
        label = Value(label),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<PreferenceTagsTableData> custom({
    Expression<String>? id,
    Expression<String>? personNodeId,
    Expression<String>? label,
    Expression<String>? sentiment,
    Expression<double>? weight,
    Expression<String>? context,
    Expression<String>? source,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (personNodeId != null) 'person_node_id': personNodeId,
      if (label != null) 'label': label,
      if (sentiment != null) 'sentiment': sentiment,
      if (weight != null) 'weight': weight,
      if (context != null) 'context': context,
      if (source != null) 'source': source,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PreferenceTagsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? personNodeId,
      Value<String>? label,
      Value<String>? sentiment,
      Value<double>? weight,
      Value<String?>? context,
      Value<String>? source,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return PreferenceTagsTableCompanion(
      id: id ?? this.id,
      personNodeId: personNodeId ?? this.personNodeId,
      label: label ?? this.label,
      sentiment: sentiment ?? this.sentiment,
      weight: weight ?? this.weight,
      context: context ?? this.context,
      source: source ?? this.source,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (personNodeId.present) {
      map['person_node_id'] = Variable<String>(personNodeId.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (sentiment.present) {
      map['sentiment'] = Variable<String>(sentiment.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (context.present) {
      map['context'] = Variable<String>(context.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PreferenceTagsTableCompanion(')
          ..write('id: $id, ')
          ..write('personNodeId: $personNodeId, ')
          ..write('label: $label, ')
          ..write('sentiment: $sentiment, ')
          ..write('weight: $weight, ')
          ..write('context: $context, ')
          ..write('source: $source, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SemanticDescriptorsTableTable extends SemanticDescriptorsTable
    with
        TableInfo<$SemanticDescriptorsTableTable,
            SemanticDescriptorsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SemanticDescriptorsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _placeNodeIdMeta =
      const VerificationMeta('placeNodeId');
  @override
  late final GeneratedColumn<String> placeNodeId = GeneratedColumn<String>(
      'place_node_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES places (id) ON DELETE CASCADE'));
  static const VerificationMeta _descriptorMeta =
      const VerificationMeta('descriptor');
  @override
  late final GeneratedColumn<String> descriptor = GeneratedColumn<String>(
      'descriptor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ai_generated'));
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _embeddingJsonMeta =
      const VerificationMeta('embeddingJson');
  @override
  late final GeneratedColumn<String> embeddingJson = GeneratedColumn<String>(
      'embedding_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, placeNodeId, descriptor, source, weight, embeddingJson, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'semantic_descriptors';
  @override
  VerificationContext validateIntegrity(
      Insertable<SemanticDescriptorsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('place_node_id')) {
      context.handle(
          _placeNodeIdMeta,
          placeNodeId.isAcceptableOrUnknown(
              data['place_node_id']!, _placeNodeIdMeta));
    } else if (isInserting) {
      context.missing(_placeNodeIdMeta);
    }
    if (data.containsKey('descriptor')) {
      context.handle(
          _descriptorMeta,
          descriptor.isAcceptableOrUnknown(
              data['descriptor']!, _descriptorMeta));
    } else if (isInserting) {
      context.missing(_descriptorMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('embedding_json')) {
      context.handle(
          _embeddingJsonMeta,
          embeddingJson.isAcceptableOrUnknown(
              data['embedding_json']!, _embeddingJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SemanticDescriptorsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SemanticDescriptorsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      placeNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}place_node_id'])!,
      descriptor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descriptor'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      embeddingJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}embedding_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SemanticDescriptorsTableTable createAlias(String alias) {
    return $SemanticDescriptorsTableTable(attachedDatabase, alias);
  }
}

class SemanticDescriptorsTableData extends DataClass
    implements Insertable<SemanticDescriptorsTableData> {
  final String id;
  final String placeNodeId;
  final String descriptor;

  /// 'ai_generated' | 'user_defined' | 'feedback_derived'
  final String source;
  final double weight;

  /// JSON-encoded float list (embedding vector).
  final String? embeddingJson;
  final DateTime createdAt;
  const SemanticDescriptorsTableData(
      {required this.id,
      required this.placeNodeId,
      required this.descriptor,
      required this.source,
      required this.weight,
      this.embeddingJson,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['place_node_id'] = Variable<String>(placeNodeId);
    map['descriptor'] = Variable<String>(descriptor);
    map['source'] = Variable<String>(source);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || embeddingJson != null) {
      map['embedding_json'] = Variable<String>(embeddingJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SemanticDescriptorsTableCompanion toCompanion(bool nullToAbsent) {
    return SemanticDescriptorsTableCompanion(
      id: Value(id),
      placeNodeId: Value(placeNodeId),
      descriptor: Value(descriptor),
      source: Value(source),
      weight: Value(weight),
      embeddingJson: embeddingJson == null && nullToAbsent
          ? const Value.absent()
          : Value(embeddingJson),
      createdAt: Value(createdAt),
    );
  }

  factory SemanticDescriptorsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SemanticDescriptorsTableData(
      id: serializer.fromJson<String>(json['id']),
      placeNodeId: serializer.fromJson<String>(json['placeNodeId']),
      descriptor: serializer.fromJson<String>(json['descriptor']),
      source: serializer.fromJson<String>(json['source']),
      weight: serializer.fromJson<double>(json['weight']),
      embeddingJson: serializer.fromJson<String?>(json['embeddingJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'placeNodeId': serializer.toJson<String>(placeNodeId),
      'descriptor': serializer.toJson<String>(descriptor),
      'source': serializer.toJson<String>(source),
      'weight': serializer.toJson<double>(weight),
      'embeddingJson': serializer.toJson<String?>(embeddingJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SemanticDescriptorsTableData copyWith(
          {String? id,
          String? placeNodeId,
          String? descriptor,
          String? source,
          double? weight,
          Value<String?> embeddingJson = const Value.absent(),
          DateTime? createdAt}) =>
      SemanticDescriptorsTableData(
        id: id ?? this.id,
        placeNodeId: placeNodeId ?? this.placeNodeId,
        descriptor: descriptor ?? this.descriptor,
        source: source ?? this.source,
        weight: weight ?? this.weight,
        embeddingJson:
            embeddingJson.present ? embeddingJson.value : this.embeddingJson,
        createdAt: createdAt ?? this.createdAt,
      );
  SemanticDescriptorsTableData copyWithCompanion(
      SemanticDescriptorsTableCompanion data) {
    return SemanticDescriptorsTableData(
      id: data.id.present ? data.id.value : this.id,
      placeNodeId:
          data.placeNodeId.present ? data.placeNodeId.value : this.placeNodeId,
      descriptor:
          data.descriptor.present ? data.descriptor.value : this.descriptor,
      source: data.source.present ? data.source.value : this.source,
      weight: data.weight.present ? data.weight.value : this.weight,
      embeddingJson: data.embeddingJson.present
          ? data.embeddingJson.value
          : this.embeddingJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SemanticDescriptorsTableData(')
          ..write('id: $id, ')
          ..write('placeNodeId: $placeNodeId, ')
          ..write('descriptor: $descriptor, ')
          ..write('source: $source, ')
          ..write('weight: $weight, ')
          ..write('embeddingJson: $embeddingJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, placeNodeId, descriptor, source, weight, embeddingJson, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SemanticDescriptorsTableData &&
          other.id == this.id &&
          other.placeNodeId == this.placeNodeId &&
          other.descriptor == this.descriptor &&
          other.source == this.source &&
          other.weight == this.weight &&
          other.embeddingJson == this.embeddingJson &&
          other.createdAt == this.createdAt);
}

class SemanticDescriptorsTableCompanion
    extends UpdateCompanion<SemanticDescriptorsTableData> {
  final Value<String> id;
  final Value<String> placeNodeId;
  final Value<String> descriptor;
  final Value<String> source;
  final Value<double> weight;
  final Value<String?> embeddingJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SemanticDescriptorsTableCompanion({
    this.id = const Value.absent(),
    this.placeNodeId = const Value.absent(),
    this.descriptor = const Value.absent(),
    this.source = const Value.absent(),
    this.weight = const Value.absent(),
    this.embeddingJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SemanticDescriptorsTableCompanion.insert({
    required String id,
    required String placeNodeId,
    required String descriptor,
    this.source = const Value.absent(),
    this.weight = const Value.absent(),
    this.embeddingJson = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        placeNodeId = Value(placeNodeId),
        descriptor = Value(descriptor),
        createdAt = Value(createdAt);
  static Insertable<SemanticDescriptorsTableData> custom({
    Expression<String>? id,
    Expression<String>? placeNodeId,
    Expression<String>? descriptor,
    Expression<String>? source,
    Expression<double>? weight,
    Expression<String>? embeddingJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeNodeId != null) 'place_node_id': placeNodeId,
      if (descriptor != null) 'descriptor': descriptor,
      if (source != null) 'source': source,
      if (weight != null) 'weight': weight,
      if (embeddingJson != null) 'embedding_json': embeddingJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SemanticDescriptorsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? placeNodeId,
      Value<String>? descriptor,
      Value<String>? source,
      Value<double>? weight,
      Value<String?>? embeddingJson,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SemanticDescriptorsTableCompanion(
      id: id ?? this.id,
      placeNodeId: placeNodeId ?? this.placeNodeId,
      descriptor: descriptor ?? this.descriptor,
      source: source ?? this.source,
      weight: weight ?? this.weight,
      embeddingJson: embeddingJson ?? this.embeddingJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (placeNodeId.present) {
      map['place_node_id'] = Variable<String>(placeNodeId.value);
    }
    if (descriptor.present) {
      map['descriptor'] = Variable<String>(descriptor.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (embeddingJson.present) {
      map['embedding_json'] = Variable<String>(embeddingJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SemanticDescriptorsTableCompanion(')
          ..write('id: $id, ')
          ..write('placeNodeId: $placeNodeId, ')
          ..write('descriptor: $descriptor, ')
          ..write('source: $source, ')
          ..write('weight: $weight, ')
          ..write('embeddingJson: $embeddingJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationshipEdgesTableTable extends RelationshipEdgesTable
    with TableInfo<$RelationshipEdgesTableTable, RelationshipEdgesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipEdgesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromNodeIdMeta =
      const VerificationMeta('fromNodeId');
  @override
  late final GeneratedColumn<String> fromNodeId = GeneratedColumn<String>(
      'from_node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fromNodeTypeMeta =
      const VerificationMeta('fromNodeType');
  @override
  late final GeneratedColumn<String> fromNodeType = GeneratedColumn<String>(
      'from_node_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toNodeIdMeta =
      const VerificationMeta('toNodeId');
  @override
  late final GeneratedColumn<String> toNodeId = GeneratedColumn<String>(
      'to_node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _toNodeTypeMeta =
      const VerificationMeta('toNodeType');
  @override
  late final GeneratedColumn<String> toNodeType = GeneratedColumn<String>(
      'to_node_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.5));
  static const VerificationMeta _metadataJsonMeta =
      const VerificationMeta('metadataJson');
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
      'metadata_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        fromNodeId,
        fromNodeType,
        toNodeId,
        toNodeType,
        label,
        weight,
        metadataJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationship_edges';
  @override
  VerificationContext validateIntegrity(
      Insertable<RelationshipEdgesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('from_node_id')) {
      context.handle(
          _fromNodeIdMeta,
          fromNodeId.isAcceptableOrUnknown(
              data['from_node_id']!, _fromNodeIdMeta));
    } else if (isInserting) {
      context.missing(_fromNodeIdMeta);
    }
    if (data.containsKey('from_node_type')) {
      context.handle(
          _fromNodeTypeMeta,
          fromNodeType.isAcceptableOrUnknown(
              data['from_node_type']!, _fromNodeTypeMeta));
    } else if (isInserting) {
      context.missing(_fromNodeTypeMeta);
    }
    if (data.containsKey('to_node_id')) {
      context.handle(_toNodeIdMeta,
          toNodeId.isAcceptableOrUnknown(data['to_node_id']!, _toNodeIdMeta));
    } else if (isInserting) {
      context.missing(_toNodeIdMeta);
    }
    if (data.containsKey('to_node_type')) {
      context.handle(
          _toNodeTypeMeta,
          toNodeType.isAcceptableOrUnknown(
              data['to_node_type']!, _toNodeTypeMeta));
    } else if (isInserting) {
      context.missing(_toNodeTypeMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
          _metadataJsonMeta,
          metadataJson.isAcceptableOrUnknown(
              data['metadata_json']!, _metadataJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RelationshipEdgesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationshipEdgesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      fromNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_node_id'])!,
      fromNodeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}from_node_type'])!,
      toNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_node_id'])!,
      toNodeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}to_node_type'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      metadataJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RelationshipEdgesTableTable createAlias(String alias) {
    return $RelationshipEdgesTableTable(attachedDatabase, alias);
  }
}

class RelationshipEdgesTableData extends DataClass
    implements Insertable<RelationshipEdgesTableData> {
  final String id;
  final String fromNodeId;

  /// String name of [NodeType] enum.
  final String fromNodeType;
  final String toNodeId;
  final String toNodeType;
  final String label;
  final double weight;
  final String? metadataJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RelationshipEdgesTableData(
      {required this.id,
      required this.fromNodeId,
      required this.fromNodeType,
      required this.toNodeId,
      required this.toNodeType,
      required this.label,
      required this.weight,
      this.metadataJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['from_node_id'] = Variable<String>(fromNodeId);
    map['from_node_type'] = Variable<String>(fromNodeType);
    map['to_node_id'] = Variable<String>(toNodeId);
    map['to_node_type'] = Variable<String>(toNodeType);
    map['label'] = Variable<String>(label);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || metadataJson != null) {
      map['metadata_json'] = Variable<String>(metadataJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RelationshipEdgesTableCompanion toCompanion(bool nullToAbsent) {
    return RelationshipEdgesTableCompanion(
      id: Value(id),
      fromNodeId: Value(fromNodeId),
      fromNodeType: Value(fromNodeType),
      toNodeId: Value(toNodeId),
      toNodeType: Value(toNodeType),
      label: Value(label),
      weight: Value(weight),
      metadataJson: metadataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metadataJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RelationshipEdgesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationshipEdgesTableData(
      id: serializer.fromJson<String>(json['id']),
      fromNodeId: serializer.fromJson<String>(json['fromNodeId']),
      fromNodeType: serializer.fromJson<String>(json['fromNodeType']),
      toNodeId: serializer.fromJson<String>(json['toNodeId']),
      toNodeType: serializer.fromJson<String>(json['toNodeType']),
      label: serializer.fromJson<String>(json['label']),
      weight: serializer.fromJson<double>(json['weight']),
      metadataJson: serializer.fromJson<String?>(json['metadataJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fromNodeId': serializer.toJson<String>(fromNodeId),
      'fromNodeType': serializer.toJson<String>(fromNodeType),
      'toNodeId': serializer.toJson<String>(toNodeId),
      'toNodeType': serializer.toJson<String>(toNodeType),
      'label': serializer.toJson<String>(label),
      'weight': serializer.toJson<double>(weight),
      'metadataJson': serializer.toJson<String?>(metadataJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RelationshipEdgesTableData copyWith(
          {String? id,
          String? fromNodeId,
          String? fromNodeType,
          String? toNodeId,
          String? toNodeType,
          String? label,
          double? weight,
          Value<String?> metadataJson = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RelationshipEdgesTableData(
        id: id ?? this.id,
        fromNodeId: fromNodeId ?? this.fromNodeId,
        fromNodeType: fromNodeType ?? this.fromNodeType,
        toNodeId: toNodeId ?? this.toNodeId,
        toNodeType: toNodeType ?? this.toNodeType,
        label: label ?? this.label,
        weight: weight ?? this.weight,
        metadataJson:
            metadataJson.present ? metadataJson.value : this.metadataJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  RelationshipEdgesTableData copyWithCompanion(
      RelationshipEdgesTableCompanion data) {
    return RelationshipEdgesTableData(
      id: data.id.present ? data.id.value : this.id,
      fromNodeId:
          data.fromNodeId.present ? data.fromNodeId.value : this.fromNodeId,
      fromNodeType: data.fromNodeType.present
          ? data.fromNodeType.value
          : this.fromNodeType,
      toNodeId: data.toNodeId.present ? data.toNodeId.value : this.toNodeId,
      toNodeType:
          data.toNodeType.present ? data.toNodeType.value : this.toNodeType,
      label: data.label.present ? data.label.value : this.label,
      weight: data.weight.present ? data.weight.value : this.weight,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipEdgesTableData(')
          ..write('id: $id, ')
          ..write('fromNodeId: $fromNodeId, ')
          ..write('fromNodeType: $fromNodeType, ')
          ..write('toNodeId: $toNodeId, ')
          ..write('toNodeType: $toNodeType, ')
          ..write('label: $label, ')
          ..write('weight: $weight, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fromNodeId, fromNodeType, toNodeId,
      toNodeType, label, weight, metadataJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationshipEdgesTableData &&
          other.id == this.id &&
          other.fromNodeId == this.fromNodeId &&
          other.fromNodeType == this.fromNodeType &&
          other.toNodeId == this.toNodeId &&
          other.toNodeType == this.toNodeType &&
          other.label == this.label &&
          other.weight == this.weight &&
          other.metadataJson == this.metadataJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RelationshipEdgesTableCompanion
    extends UpdateCompanion<RelationshipEdgesTableData> {
  final Value<String> id;
  final Value<String> fromNodeId;
  final Value<String> fromNodeType;
  final Value<String> toNodeId;
  final Value<String> toNodeType;
  final Value<String> label;
  final Value<double> weight;
  final Value<String?> metadataJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RelationshipEdgesTableCompanion({
    this.id = const Value.absent(),
    this.fromNodeId = const Value.absent(),
    this.fromNodeType = const Value.absent(),
    this.toNodeId = const Value.absent(),
    this.toNodeType = const Value.absent(),
    this.label = const Value.absent(),
    this.weight = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipEdgesTableCompanion.insert({
    required String id,
    required String fromNodeId,
    required String fromNodeType,
    required String toNodeId,
    required String toNodeType,
    required String label,
    this.weight = const Value.absent(),
    this.metadataJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        fromNodeId = Value(fromNodeId),
        fromNodeType = Value(fromNodeType),
        toNodeId = Value(toNodeId),
        toNodeType = Value(toNodeType),
        label = Value(label),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RelationshipEdgesTableData> custom({
    Expression<String>? id,
    Expression<String>? fromNodeId,
    Expression<String>? fromNodeType,
    Expression<String>? toNodeId,
    Expression<String>? toNodeType,
    Expression<String>? label,
    Expression<double>? weight,
    Expression<String>? metadataJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fromNodeId != null) 'from_node_id': fromNodeId,
      if (fromNodeType != null) 'from_node_type': fromNodeType,
      if (toNodeId != null) 'to_node_id': toNodeId,
      if (toNodeType != null) 'to_node_type': toNodeType,
      if (label != null) 'label': label,
      if (weight != null) 'weight': weight,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipEdgesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? fromNodeId,
      Value<String>? fromNodeType,
      Value<String>? toNodeId,
      Value<String>? toNodeType,
      Value<String>? label,
      Value<double>? weight,
      Value<String?>? metadataJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return RelationshipEdgesTableCompanion(
      id: id ?? this.id,
      fromNodeId: fromNodeId ?? this.fromNodeId,
      fromNodeType: fromNodeType ?? this.fromNodeType,
      toNodeId: toNodeId ?? this.toNodeId,
      toNodeType: toNodeType ?? this.toNodeType,
      label: label ?? this.label,
      weight: weight ?? this.weight,
      metadataJson: metadataJson ?? this.metadataJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fromNodeId.present) {
      map['from_node_id'] = Variable<String>(fromNodeId.value);
    }
    if (fromNodeType.present) {
      map['from_node_type'] = Variable<String>(fromNodeType.value);
    }
    if (toNodeId.present) {
      map['to_node_id'] = Variable<String>(toNodeId.value);
    }
    if (toNodeType.present) {
      map['to_node_type'] = Variable<String>(toNodeType.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipEdgesTableCompanion(')
          ..write('id: $id, ')
          ..write('fromNodeId: $fromNodeId, ')
          ..write('fromNodeType: $fromNodeType, ')
          ..write('toNodeId: $toNodeId, ')
          ..write('toNodeType: $toNodeType, ')
          ..write('label: $label, ')
          ..write('weight: $weight, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupMemoriesTableTable extends GroupMemoriesTable
    with TableInfo<$GroupMemoriesTableTable, GroupMemoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupMemoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pastPlanIdsJsonMeta =
      const VerificationMeta('pastPlanIdsJson');
  @override
  late final GeneratedColumn<String> pastPlanIdsJson = GeneratedColumn<String>(
      'past_plan_ids_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _visitedPlaceIdsJsonMeta =
      const VerificationMeta('visitedPlaceIdsJson');
  @override
  late final GeneratedColumn<String> visitedPlaceIdsJson =
      GeneratedColumn<String>('visited_place_ids_json', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _sharedPreferencesJsonMeta =
      const VerificationMeta('sharedPreferencesJson');
  @override
  late final GeneratedColumn<String> sharedPreferencesJson =
      GeneratedColumn<String>('shared_preferences_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        pastPlanIdsJson,
        visitedPlaceIdsJson,
        sharedPreferencesJson,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_memories';
  @override
  VerificationContext validateIntegrity(
      Insertable<GroupMemoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('past_plan_ids_json')) {
      context.handle(
          _pastPlanIdsJsonMeta,
          pastPlanIdsJson.isAcceptableOrUnknown(
              data['past_plan_ids_json']!, _pastPlanIdsJsonMeta));
    }
    if (data.containsKey('visited_place_ids_json')) {
      context.handle(
          _visitedPlaceIdsJsonMeta,
          visitedPlaceIdsJson.isAcceptableOrUnknown(
              data['visited_place_ids_json']!, _visitedPlaceIdsJsonMeta));
    }
    if (data.containsKey('shared_preferences_json')) {
      context.handle(
          _sharedPreferencesJsonMeta,
          sharedPreferencesJson.isAcceptableOrUnknown(
              data['shared_preferences_json']!, _sharedPreferencesJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupMemoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupMemoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      pastPlanIdsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}past_plan_ids_json'])!,
      visitedPlaceIdsJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}visited_place_ids_json'])!,
      sharedPreferencesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}shared_preferences_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $GroupMemoriesTableTable createAlias(String alias) {
    return $GroupMemoriesTableTable(attachedDatabase, alias);
  }
}

class GroupMemoriesTableData extends DataClass
    implements Insertable<GroupMemoriesTableData> {
  final String id;
  final String name;

  /// JSON-encoded List<String> of plan IDs.
  final String pastPlanIdsJson;

  /// JSON-encoded List<String> of visited place IDs.
  final String visitedPlaceIdsJson;

  /// JSON-encoded shared preference map.
  final String? sharedPreferencesJson;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GroupMemoriesTableData(
      {required this.id,
      required this.name,
      required this.pastPlanIdsJson,
      required this.visitedPlaceIdsJson,
      this.sharedPreferencesJson,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['past_plan_ids_json'] = Variable<String>(pastPlanIdsJson);
    map['visited_place_ids_json'] = Variable<String>(visitedPlaceIdsJson);
    if (!nullToAbsent || sharedPreferencesJson != null) {
      map['shared_preferences_json'] = Variable<String>(sharedPreferencesJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GroupMemoriesTableCompanion toCompanion(bool nullToAbsent) {
    return GroupMemoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      pastPlanIdsJson: Value(pastPlanIdsJson),
      visitedPlaceIdsJson: Value(visitedPlaceIdsJson),
      sharedPreferencesJson: sharedPreferencesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sharedPreferencesJson),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GroupMemoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupMemoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pastPlanIdsJson: serializer.fromJson<String>(json['pastPlanIdsJson']),
      visitedPlaceIdsJson:
          serializer.fromJson<String>(json['visitedPlaceIdsJson']),
      sharedPreferencesJson:
          serializer.fromJson<String?>(json['sharedPreferencesJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'pastPlanIdsJson': serializer.toJson<String>(pastPlanIdsJson),
      'visitedPlaceIdsJson': serializer.toJson<String>(visitedPlaceIdsJson),
      'sharedPreferencesJson':
          serializer.toJson<String?>(sharedPreferencesJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GroupMemoriesTableData copyWith(
          {String? id,
          String? name,
          String? pastPlanIdsJson,
          String? visitedPlaceIdsJson,
          Value<String?> sharedPreferencesJson = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      GroupMemoriesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        pastPlanIdsJson: pastPlanIdsJson ?? this.pastPlanIdsJson,
        visitedPlaceIdsJson: visitedPlaceIdsJson ?? this.visitedPlaceIdsJson,
        sharedPreferencesJson: sharedPreferencesJson.present
            ? sharedPreferencesJson.value
            : this.sharedPreferencesJson,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  GroupMemoriesTableData copyWithCompanion(GroupMemoriesTableCompanion data) {
    return GroupMemoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      pastPlanIdsJson: data.pastPlanIdsJson.present
          ? data.pastPlanIdsJson.value
          : this.pastPlanIdsJson,
      visitedPlaceIdsJson: data.visitedPlaceIdsJson.present
          ? data.visitedPlaceIdsJson.value
          : this.visitedPlaceIdsJson,
      sharedPreferencesJson: data.sharedPreferencesJson.present
          ? data.sharedPreferencesJson.value
          : this.sharedPreferencesJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupMemoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pastPlanIdsJson: $pastPlanIdsJson, ')
          ..write('visitedPlaceIdsJson: $visitedPlaceIdsJson, ')
          ..write('sharedPreferencesJson: $sharedPreferencesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, pastPlanIdsJson,
      visitedPlaceIdsJson, sharedPreferencesJson, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupMemoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.pastPlanIdsJson == this.pastPlanIdsJson &&
          other.visitedPlaceIdsJson == this.visitedPlaceIdsJson &&
          other.sharedPreferencesJson == this.sharedPreferencesJson &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GroupMemoriesTableCompanion
    extends UpdateCompanion<GroupMemoriesTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> pastPlanIdsJson;
  final Value<String> visitedPlaceIdsJson;
  final Value<String?> sharedPreferencesJson;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GroupMemoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pastPlanIdsJson = const Value.absent(),
    this.visitedPlaceIdsJson = const Value.absent(),
    this.sharedPreferencesJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupMemoriesTableCompanion.insert({
    required String id,
    required String name,
    this.pastPlanIdsJson = const Value.absent(),
    this.visitedPlaceIdsJson = const Value.absent(),
    this.sharedPreferencesJson = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<GroupMemoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? pastPlanIdsJson,
    Expression<String>? visitedPlaceIdsJson,
    Expression<String>? sharedPreferencesJson,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pastPlanIdsJson != null) 'past_plan_ids_json': pastPlanIdsJson,
      if (visitedPlaceIdsJson != null)
        'visited_place_ids_json': visitedPlaceIdsJson,
      if (sharedPreferencesJson != null)
        'shared_preferences_json': sharedPreferencesJson,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupMemoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? pastPlanIdsJson,
      Value<String>? visitedPlaceIdsJson,
      Value<String?>? sharedPreferencesJson,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return GroupMemoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pastPlanIdsJson: pastPlanIdsJson ?? this.pastPlanIdsJson,
      visitedPlaceIdsJson: visitedPlaceIdsJson ?? this.visitedPlaceIdsJson,
      sharedPreferencesJson:
          sharedPreferencesJson ?? this.sharedPreferencesJson,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pastPlanIdsJson.present) {
      map['past_plan_ids_json'] = Variable<String>(pastPlanIdsJson.value);
    }
    if (visitedPlaceIdsJson.present) {
      map['visited_place_ids_json'] =
          Variable<String>(visitedPlaceIdsJson.value);
    }
    if (sharedPreferencesJson.present) {
      map['shared_preferences_json'] =
          Variable<String>(sharedPreferencesJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupMemoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pastPlanIdsJson: $pastPlanIdsJson, ')
          ..write('visitedPlaceIdsJson: $visitedPlaceIdsJson, ')
          ..write('sharedPreferencesJson: $sharedPreferencesJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupMembersTableTable extends GroupMembersTable
    with TableInfo<$GroupMembersTableTable, GroupMembersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupMembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _personNodeIdMeta =
      const VerificationMeta('personNodeId');
  @override
  late final GeneratedColumn<String> personNodeId = GeneratedColumn<String>(
      'person_node_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [groupId, personNodeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_members';
  @override
  VerificationContext validateIntegrity(
      Insertable<GroupMembersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('person_node_id')) {
      context.handle(
          _personNodeIdMeta,
          personNodeId.isAcceptableOrUnknown(
              data['person_node_id']!, _personNodeIdMeta));
    } else if (isInserting) {
      context.missing(_personNodeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupId, personNodeId};
  @override
  GroupMembersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupMembersTableData(
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      personNodeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person_node_id'])!,
    );
  }

  @override
  $GroupMembersTableTable createAlias(String alias) {
    return $GroupMembersTableTable(attachedDatabase, alias);
  }
}

class GroupMembersTableData extends DataClass
    implements Insertable<GroupMembersTableData> {
  final String groupId;
  final String personNodeId;
  const GroupMembersTableData(
      {required this.groupId, required this.personNodeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_id'] = Variable<String>(groupId);
    map['person_node_id'] = Variable<String>(personNodeId);
    return map;
  }

  GroupMembersTableCompanion toCompanion(bool nullToAbsent) {
    return GroupMembersTableCompanion(
      groupId: Value(groupId),
      personNodeId: Value(personNodeId),
    );
  }

  factory GroupMembersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupMembersTableData(
      groupId: serializer.fromJson<String>(json['groupId']),
      personNodeId: serializer.fromJson<String>(json['personNodeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupId': serializer.toJson<String>(groupId),
      'personNodeId': serializer.toJson<String>(personNodeId),
    };
  }

  GroupMembersTableData copyWith({String? groupId, String? personNodeId}) =>
      GroupMembersTableData(
        groupId: groupId ?? this.groupId,
        personNodeId: personNodeId ?? this.personNodeId,
      );
  GroupMembersTableData copyWithCompanion(GroupMembersTableCompanion data) {
    return GroupMembersTableData(
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      personNodeId: data.personNodeId.present
          ? data.personNodeId.value
          : this.personNodeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupMembersTableData(')
          ..write('groupId: $groupId, ')
          ..write('personNodeId: $personNodeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupId, personNodeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupMembersTableData &&
          other.groupId == this.groupId &&
          other.personNodeId == this.personNodeId);
}

class GroupMembersTableCompanion
    extends UpdateCompanion<GroupMembersTableData> {
  final Value<String> groupId;
  final Value<String> personNodeId;
  final Value<int> rowid;
  const GroupMembersTableCompanion({
    this.groupId = const Value.absent(),
    this.personNodeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupMembersTableCompanion.insert({
    required String groupId,
    required String personNodeId,
    this.rowid = const Value.absent(),
  })  : groupId = Value(groupId),
        personNodeId = Value(personNodeId);
  static Insertable<GroupMembersTableData> custom({
    Expression<String>? groupId,
    Expression<String>? personNodeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupId != null) 'group_id': groupId,
      if (personNodeId != null) 'person_node_id': personNodeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupMembersTableCompanion copyWith(
      {Value<String>? groupId,
      Value<String>? personNodeId,
      Value<int>? rowid}) {
    return GroupMembersTableCompanion(
      groupId: groupId ?? this.groupId,
      personNodeId: personNodeId ?? this.personNodeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (personNodeId.present) {
      map['person_node_id'] = Variable<String>(personNodeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupMembersTableCompanion(')
          ..write('groupId: $groupId, ')
          ..write('personNodeId: $personNodeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AgentTasksTableTable extends AgentTasksTable
    with TableInfo<$AgentTasksTableTable, AgentTasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AgentTasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _agentTypeMeta =
      const VerificationMeta('agentType');
  @override
  late final GeneratedColumn<String> agentType = GeneratedColumn<String>(
      'agent_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _contextJsonMeta =
      const VerificationMeta('contextJson');
  @override
  late final GeneratedColumn<String> contextJson = GeneratedColumn<String>(
      'context_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _resultJsonMeta =
      const VerificationMeta('resultJson');
  @override
  late final GeneratedColumn<String> resultJson = GeneratedColumn<String>(
      'result_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _errorMessageMeta =
      const VerificationMeta('errorMessage');
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
      'error_message', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        agentType,
        status,
        contextJson,
        resultJson,
        errorMessage,
        createdAt,
        startedAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'agent_tasks';
  @override
  VerificationContext validateIntegrity(
      Insertable<AgentTasksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('agent_type')) {
      context.handle(_agentTypeMeta,
          agentType.isAcceptableOrUnknown(data['agent_type']!, _agentTypeMeta));
    } else if (isInserting) {
      context.missing(_agentTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('context_json')) {
      context.handle(
          _contextJsonMeta,
          contextJson.isAcceptableOrUnknown(
              data['context_json']!, _contextJsonMeta));
    } else if (isInserting) {
      context.missing(_contextJsonMeta);
    }
    if (data.containsKey('result_json')) {
      context.handle(
          _resultJsonMeta,
          resultJson.isAcceptableOrUnknown(
              data['result_json']!, _resultJsonMeta));
    }
    if (data.containsKey('error_message')) {
      context.handle(
          _errorMessageMeta,
          errorMessage.isAcceptableOrUnknown(
              data['error_message']!, _errorMessageMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AgentTasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AgentTasksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      agentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agent_type'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      contextJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}context_json'])!,
      resultJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}result_json']),
      errorMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}error_message']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at']),
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $AgentTasksTableTable createAlias(String alias) {
    return $AgentTasksTableTable(attachedDatabase, alias);
  }
}

class AgentTasksTableData extends DataClass
    implements Insertable<AgentTasksTableData> {
  final String id;
  final String agentType;

  /// String name of [AgentTaskStatus] enum.
  final String status;
  final String contextJson;
  final String? resultJson;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  const AgentTasksTableData(
      {required this.id,
      required this.agentType,
      required this.status,
      required this.contextJson,
      this.resultJson,
      this.errorMessage,
      required this.createdAt,
      this.startedAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['agent_type'] = Variable<String>(agentType);
    map['status'] = Variable<String>(status);
    map['context_json'] = Variable<String>(contextJson);
    if (!nullToAbsent || resultJson != null) {
      map['result_json'] = Variable<String>(resultJson);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  AgentTasksTableCompanion toCompanion(bool nullToAbsent) {
    return AgentTasksTableCompanion(
      id: Value(id),
      agentType: Value(agentType),
      status: Value(status),
      contextJson: Value(contextJson),
      resultJson: resultJson == null && nullToAbsent
          ? const Value.absent()
          : Value(resultJson),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory AgentTasksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AgentTasksTableData(
      id: serializer.fromJson<String>(json['id']),
      agentType: serializer.fromJson<String>(json['agentType']),
      status: serializer.fromJson<String>(json['status']),
      contextJson: serializer.fromJson<String>(json['contextJson']),
      resultJson: serializer.fromJson<String?>(json['resultJson']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'agentType': serializer.toJson<String>(agentType),
      'status': serializer.toJson<String>(status),
      'contextJson': serializer.toJson<String>(contextJson),
      'resultJson': serializer.toJson<String?>(resultJson),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  AgentTasksTableData copyWith(
          {String? id,
          String? agentType,
          String? status,
          String? contextJson,
          Value<String?> resultJson = const Value.absent(),
          Value<String?> errorMessage = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> startedAt = const Value.absent(),
          Value<DateTime?> completedAt = const Value.absent()}) =>
      AgentTasksTableData(
        id: id ?? this.id,
        agentType: agentType ?? this.agentType,
        status: status ?? this.status,
        contextJson: contextJson ?? this.contextJson,
        resultJson: resultJson.present ? resultJson.value : this.resultJson,
        errorMessage:
            errorMessage.present ? errorMessage.value : this.errorMessage,
        createdAt: createdAt ?? this.createdAt,
        startedAt: startedAt.present ? startedAt.value : this.startedAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  AgentTasksTableData copyWithCompanion(AgentTasksTableCompanion data) {
    return AgentTasksTableData(
      id: data.id.present ? data.id.value : this.id,
      agentType: data.agentType.present ? data.agentType.value : this.agentType,
      status: data.status.present ? data.status.value : this.status,
      contextJson:
          data.contextJson.present ? data.contextJson.value : this.contextJson,
      resultJson:
          data.resultJson.present ? data.resultJson.value : this.resultJson,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AgentTasksTableData(')
          ..write('id: $id, ')
          ..write('agentType: $agentType, ')
          ..write('status: $status, ')
          ..write('contextJson: $contextJson, ')
          ..write('resultJson: $resultJson, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, agentType, status, contextJson,
      resultJson, errorMessage, createdAt, startedAt, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AgentTasksTableData &&
          other.id == this.id &&
          other.agentType == this.agentType &&
          other.status == this.status &&
          other.contextJson == this.contextJson &&
          other.resultJson == this.resultJson &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt);
}

class AgentTasksTableCompanion extends UpdateCompanion<AgentTasksTableData> {
  final Value<String> id;
  final Value<String> agentType;
  final Value<String> status;
  final Value<String> contextJson;
  final Value<String?> resultJson;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const AgentTasksTableCompanion({
    this.id = const Value.absent(),
    this.agentType = const Value.absent(),
    this.status = const Value.absent(),
    this.contextJson = const Value.absent(),
    this.resultJson = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AgentTasksTableCompanion.insert({
    required String id,
    required String agentType,
    this.status = const Value.absent(),
    required String contextJson,
    this.resultJson = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        agentType = Value(agentType),
        contextJson = Value(contextJson),
        createdAt = Value(createdAt);
  static Insertable<AgentTasksTableData> custom({
    Expression<String>? id,
    Expression<String>? agentType,
    Expression<String>? status,
    Expression<String>? contextJson,
    Expression<String>? resultJson,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (agentType != null) 'agent_type': agentType,
      if (status != null) 'status': status,
      if (contextJson != null) 'context_json': contextJson,
      if (resultJson != null) 'result_json': resultJson,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AgentTasksTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? agentType,
      Value<String>? status,
      Value<String>? contextJson,
      Value<String?>? resultJson,
      Value<String?>? errorMessage,
      Value<DateTime>? createdAt,
      Value<DateTime?>? startedAt,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return AgentTasksTableCompanion(
      id: id ?? this.id,
      agentType: agentType ?? this.agentType,
      status: status ?? this.status,
      contextJson: contextJson ?? this.contextJson,
      resultJson: resultJson ?? this.resultJson,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (agentType.present) {
      map['agent_type'] = Variable<String>(agentType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (contextJson.present) {
      map['context_json'] = Variable<String>(contextJson.value);
    }
    if (resultJson.present) {
      map['result_json'] = Variable<String>(resultJson.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AgentTasksTableCompanion(')
          ..write('id: $id, ')
          ..write('agentType: $agentType, ')
          ..write('status: $status, ')
          ..write('contextJson: $contextJson, ')
          ..write('resultJson: $resultJson, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecommendationPlansTableTable extends RecommendationPlansTable
    with
        TableInfo<$RecommendationPlansTableTable,
            RecommendationPlansTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecommendationPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _agentTaskIdMeta =
      const VerificationMeta('agentTaskId');
  @override
  late final GeneratedColumn<String> agentTaskId = GeneratedColumn<String>(
      'agent_task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES agent_tasks (id) ON DELETE CASCADE'));
  static const VerificationMeta _groupMemoryIdMeta =
      const VerificationMeta('groupMemoryId');
  @override
  late final GeneratedColumn<String> groupMemoryId = GeneratedColumn<String>(
      'group_memory_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itemsJsonMeta =
      const VerificationMeta('itemsJson');
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
      'items_json', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _itineraryNarrativeMeta =
      const VerificationMeta('itineraryNarrative');
  @override
  late final GeneratedColumn<String> itineraryNarrative =
      GeneratedColumn<String>('itinerary_narrative', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _overallScoreMeta =
      const VerificationMeta('overallScore');
  @override
  late final GeneratedColumn<double> overallScore = GeneratedColumn<double>(
      'overall_score', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        agentTaskId,
        groupMemoryId,
        title,
        itemsJson,
        itineraryNarrative,
        overallScore,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recommendation_plans';
  @override
  VerificationContext validateIntegrity(
      Insertable<RecommendationPlansTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('agent_task_id')) {
      context.handle(
          _agentTaskIdMeta,
          agentTaskId.isAcceptableOrUnknown(
              data['agent_task_id']!, _agentTaskIdMeta));
    } else if (isInserting) {
      context.missing(_agentTaskIdMeta);
    }
    if (data.containsKey('group_memory_id')) {
      context.handle(
          _groupMemoryIdMeta,
          groupMemoryId.isAcceptableOrUnknown(
              data['group_memory_id']!, _groupMemoryIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('items_json')) {
      context.handle(_itemsJsonMeta,
          itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta));
    }
    if (data.containsKey('itinerary_narrative')) {
      context.handle(
          _itineraryNarrativeMeta,
          itineraryNarrative.isAcceptableOrUnknown(
              data['itinerary_narrative']!, _itineraryNarrativeMeta));
    }
    if (data.containsKey('overall_score')) {
      context.handle(
          _overallScoreMeta,
          overallScore.isAcceptableOrUnknown(
              data['overall_score']!, _overallScoreMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecommendationPlansTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecommendationPlansTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      agentTaskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}agent_task_id'])!,
      groupMemoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_memory_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      itemsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}items_json'])!,
      itineraryNarrative: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}itinerary_narrative']),
      overallScore: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}overall_score']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $RecommendationPlansTableTable createAlias(String alias) {
    return $RecommendationPlansTableTable(attachedDatabase, alias);
  }
}

class RecommendationPlansTableData extends DataClass
    implements Insertable<RecommendationPlansTableData> {
  final String id;
  final String agentTaskId;
  final String? groupMemoryId;
  final String title;

  /// JSON-encoded List<RecommendationItem>.
  final String itemsJson;
  final String? itineraryNarrative;
  final double? overallScore;
  final DateTime createdAt;
  const RecommendationPlansTableData(
      {required this.id,
      required this.agentTaskId,
      this.groupMemoryId,
      required this.title,
      required this.itemsJson,
      this.itineraryNarrative,
      this.overallScore,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['agent_task_id'] = Variable<String>(agentTaskId);
    if (!nullToAbsent || groupMemoryId != null) {
      map['group_memory_id'] = Variable<String>(groupMemoryId);
    }
    map['title'] = Variable<String>(title);
    map['items_json'] = Variable<String>(itemsJson);
    if (!nullToAbsent || itineraryNarrative != null) {
      map['itinerary_narrative'] = Variable<String>(itineraryNarrative);
    }
    if (!nullToAbsent || overallScore != null) {
      map['overall_score'] = Variable<double>(overallScore);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecommendationPlansTableCompanion toCompanion(bool nullToAbsent) {
    return RecommendationPlansTableCompanion(
      id: Value(id),
      agentTaskId: Value(agentTaskId),
      groupMemoryId: groupMemoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupMemoryId),
      title: Value(title),
      itemsJson: Value(itemsJson),
      itineraryNarrative: itineraryNarrative == null && nullToAbsent
          ? const Value.absent()
          : Value(itineraryNarrative),
      overallScore: overallScore == null && nullToAbsent
          ? const Value.absent()
          : Value(overallScore),
      createdAt: Value(createdAt),
    );
  }

  factory RecommendationPlansTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecommendationPlansTableData(
      id: serializer.fromJson<String>(json['id']),
      agentTaskId: serializer.fromJson<String>(json['agentTaskId']),
      groupMemoryId: serializer.fromJson<String?>(json['groupMemoryId']),
      title: serializer.fromJson<String>(json['title']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      itineraryNarrative:
          serializer.fromJson<String?>(json['itineraryNarrative']),
      overallScore: serializer.fromJson<double?>(json['overallScore']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'agentTaskId': serializer.toJson<String>(agentTaskId),
      'groupMemoryId': serializer.toJson<String?>(groupMemoryId),
      'title': serializer.toJson<String>(title),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'itineraryNarrative': serializer.toJson<String?>(itineraryNarrative),
      'overallScore': serializer.toJson<double?>(overallScore),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecommendationPlansTableData copyWith(
          {String? id,
          String? agentTaskId,
          Value<String?> groupMemoryId = const Value.absent(),
          String? title,
          String? itemsJson,
          Value<String?> itineraryNarrative = const Value.absent(),
          Value<double?> overallScore = const Value.absent(),
          DateTime? createdAt}) =>
      RecommendationPlansTableData(
        id: id ?? this.id,
        agentTaskId: agentTaskId ?? this.agentTaskId,
        groupMemoryId:
            groupMemoryId.present ? groupMemoryId.value : this.groupMemoryId,
        title: title ?? this.title,
        itemsJson: itemsJson ?? this.itemsJson,
        itineraryNarrative: itineraryNarrative.present
            ? itineraryNarrative.value
            : this.itineraryNarrative,
        overallScore:
            overallScore.present ? overallScore.value : this.overallScore,
        createdAt: createdAt ?? this.createdAt,
      );
  RecommendationPlansTableData copyWithCompanion(
      RecommendationPlansTableCompanion data) {
    return RecommendationPlansTableData(
      id: data.id.present ? data.id.value : this.id,
      agentTaskId:
          data.agentTaskId.present ? data.agentTaskId.value : this.agentTaskId,
      groupMemoryId: data.groupMemoryId.present
          ? data.groupMemoryId.value
          : this.groupMemoryId,
      title: data.title.present ? data.title.value : this.title,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      itineraryNarrative: data.itineraryNarrative.present
          ? data.itineraryNarrative.value
          : this.itineraryNarrative,
      overallScore: data.overallScore.present
          ? data.overallScore.value
          : this.overallScore,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecommendationPlansTableData(')
          ..write('id: $id, ')
          ..write('agentTaskId: $agentTaskId, ')
          ..write('groupMemoryId: $groupMemoryId, ')
          ..write('title: $title, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('itineraryNarrative: $itineraryNarrative, ')
          ..write('overallScore: $overallScore, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, agentTaskId, groupMemoryId, title,
      itemsJson, itineraryNarrative, overallScore, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecommendationPlansTableData &&
          other.id == this.id &&
          other.agentTaskId == this.agentTaskId &&
          other.groupMemoryId == this.groupMemoryId &&
          other.title == this.title &&
          other.itemsJson == this.itemsJson &&
          other.itineraryNarrative == this.itineraryNarrative &&
          other.overallScore == this.overallScore &&
          other.createdAt == this.createdAt);
}

class RecommendationPlansTableCompanion
    extends UpdateCompanion<RecommendationPlansTableData> {
  final Value<String> id;
  final Value<String> agentTaskId;
  final Value<String?> groupMemoryId;
  final Value<String> title;
  final Value<String> itemsJson;
  final Value<String?> itineraryNarrative;
  final Value<double?> overallScore;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecommendationPlansTableCompanion({
    this.id = const Value.absent(),
    this.agentTaskId = const Value.absent(),
    this.groupMemoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.itineraryNarrative = const Value.absent(),
    this.overallScore = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecommendationPlansTableCompanion.insert({
    required String id,
    required String agentTaskId,
    this.groupMemoryId = const Value.absent(),
    required String title,
    this.itemsJson = const Value.absent(),
    this.itineraryNarrative = const Value.absent(),
    this.overallScore = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        agentTaskId = Value(agentTaskId),
        title = Value(title),
        createdAt = Value(createdAt);
  static Insertable<RecommendationPlansTableData> custom({
    Expression<String>? id,
    Expression<String>? agentTaskId,
    Expression<String>? groupMemoryId,
    Expression<String>? title,
    Expression<String>? itemsJson,
    Expression<String>? itineraryNarrative,
    Expression<double>? overallScore,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (agentTaskId != null) 'agent_task_id': agentTaskId,
      if (groupMemoryId != null) 'group_memory_id': groupMemoryId,
      if (title != null) 'title': title,
      if (itemsJson != null) 'items_json': itemsJson,
      if (itineraryNarrative != null) 'itinerary_narrative': itineraryNarrative,
      if (overallScore != null) 'overall_score': overallScore,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecommendationPlansTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? agentTaskId,
      Value<String?>? groupMemoryId,
      Value<String>? title,
      Value<String>? itemsJson,
      Value<String?>? itineraryNarrative,
      Value<double?>? overallScore,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return RecommendationPlansTableCompanion(
      id: id ?? this.id,
      agentTaskId: agentTaskId ?? this.agentTaskId,
      groupMemoryId: groupMemoryId ?? this.groupMemoryId,
      title: title ?? this.title,
      itemsJson: itemsJson ?? this.itemsJson,
      itineraryNarrative: itineraryNarrative ?? this.itineraryNarrative,
      overallScore: overallScore ?? this.overallScore,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (agentTaskId.present) {
      map['agent_task_id'] = Variable<String>(agentTaskId.value);
    }
    if (groupMemoryId.present) {
      map['group_memory_id'] = Variable<String>(groupMemoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (itineraryNarrative.present) {
      map['itinerary_narrative'] = Variable<String>(itineraryNarrative.value);
    }
    if (overallScore.present) {
      map['overall_score'] = Variable<double>(overallScore.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecommendationPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('agentTaskId: $agentTaskId, ')
          ..write('groupMemoryId: $groupMemoryId, ')
          ..write('title: $title, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('itineraryNarrative: $itineraryNarrative, ')
          ..write('overallScore: $overallScore, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonsTableTable personsTable = $PersonsTableTable(this);
  late final $PlacesTableTable placesTable = $PlacesTableTable(this);
  late final $PreferenceTagsTableTable preferenceTagsTable =
      $PreferenceTagsTableTable(this);
  late final $SemanticDescriptorsTableTable semanticDescriptorsTable =
      $SemanticDescriptorsTableTable(this);
  late final $RelationshipEdgesTableTable relationshipEdgesTable =
      $RelationshipEdgesTableTable(this);
  late final $GroupMemoriesTableTable groupMemoriesTable =
      $GroupMemoriesTableTable(this);
  late final $GroupMembersTableTable groupMembersTable =
      $GroupMembersTableTable(this);
  late final $AgentTasksTableTable agentTasksTable =
      $AgentTasksTableTable(this);
  late final $RecommendationPlansTableTable recommendationPlansTable =
      $RecommendationPlansTableTable(this);
  late final PersonDao personDao = PersonDao(this as AppDatabase);
  late final PlaceDao placeDao = PlaceDao(this as AppDatabase);
  late final GraphDao graphDao = GraphDao(this as AppDatabase);
  late final RecommendationDao recommendationDao =
      RecommendationDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        personsTable,
        placesTable,
        preferenceTagsTable,
        semanticDescriptorsTable,
        relationshipEdgesTable,
        groupMemoriesTable,
        groupMembersTable,
        agentTasksTable,
        recommendationPlansTable
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('persons',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('preference_tags', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('places',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('semantic_descriptors', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('agent_tasks',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('recommendation_plans', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$PersonsTableTableCreateCompanionBuilder = PersonsTableCompanion
    Function({
  required String id,
  Value<String?> userId,
  required String name,
  Value<String?> gender,
  Value<String?> mbti,
  Value<bool> hasVehicle,
  Value<int?> vehicleSeats,
  Value<String> freeformTagsJson,
  Value<bool> isPrivate,
  Value<String?> countryCode,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PersonsTableTableUpdateCompanionBuilder = PersonsTableCompanion
    Function({
  Value<String> id,
  Value<String?> userId,
  Value<String> name,
  Value<String?> gender,
  Value<String?> mbti,
  Value<bool> hasVehicle,
  Value<int?> vehicleSeats,
  Value<String> freeformTagsJson,
  Value<bool> isPrivate,
  Value<String?> countryCode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PersonsTableTableReferences extends BaseReferences<_$AppDatabase,
    $PersonsTableTable, PersonsTableData> {
  $$PersonsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PreferenceTagsTableTable,
      List<PreferenceTagsTableData>> _preferenceTagsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.preferenceTagsTable,
          aliasName: $_aliasNameGenerator(
              db.personsTable.id, db.preferenceTagsTable.personNodeId));

  $$PreferenceTagsTableTableProcessedTableManager get preferenceTagsTableRefs {
    final manager = $$PreferenceTagsTableTableTableManager(
            $_db, $_db.preferenceTagsTable)
        .filter(
            (f) => f.personNodeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_preferenceTagsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PersonsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mbti => $composableBuilder(
      column: $table.mbti, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasVehicle => $composableBuilder(
      column: $table.hasVehicle, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vehicleSeats => $composableBuilder(
      column: $table.vehicleSeats, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get freeformTagsJson => $composableBuilder(
      column: $table.freeformTagsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> preferenceTagsTableRefs(
      Expression<bool> Function($$PreferenceTagsTableTableFilterComposer f) f) {
    final $$PreferenceTagsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.preferenceTagsTable,
        getReferencedColumn: (t) => t.personNodeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PreferenceTagsTableTableFilterComposer(
              $db: $db,
              $table: $db.preferenceTagsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PersonsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mbti => $composableBuilder(
      column: $table.mbti, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasVehicle => $composableBuilder(
      column: $table.hasVehicle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vehicleSeats => $composableBuilder(
      column: $table.vehicleSeats,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get freeformTagsJson => $composableBuilder(
      column: $table.freeformTagsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PersonsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTableTable> {
  $$PersonsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get mbti =>
      $composableBuilder(column: $table.mbti, builder: (column) => column);

  GeneratedColumn<bool> get hasVehicle => $composableBuilder(
      column: $table.hasVehicle, builder: (column) => column);

  GeneratedColumn<int> get vehicleSeats => $composableBuilder(
      column: $table.vehicleSeats, builder: (column) => column);

  GeneratedColumn<String> get freeformTagsJson => $composableBuilder(
      column: $table.freeformTagsJson, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> preferenceTagsTableRefs<T extends Object>(
      Expression<T> Function($$PreferenceTagsTableTableAnnotationComposer a)
          f) {
    final $$PreferenceTagsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.preferenceTagsTable,
            getReferencedColumn: (t) => t.personNodeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PreferenceTagsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.preferenceTagsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PersonsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PersonsTableTable,
    PersonsTableData,
    $$PersonsTableTableFilterComposer,
    $$PersonsTableTableOrderingComposer,
    $$PersonsTableTableAnnotationComposer,
    $$PersonsTableTableCreateCompanionBuilder,
    $$PersonsTableTableUpdateCompanionBuilder,
    (PersonsTableData, $$PersonsTableTableReferences),
    PersonsTableData,
    PrefetchHooks Function({bool preferenceTagsTableRefs})> {
  $$PersonsTableTableTableManager(_$AppDatabase db, $PersonsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> mbti = const Value.absent(),
            Value<bool> hasVehicle = const Value.absent(),
            Value<int?> vehicleSeats = const Value.absent(),
            Value<String> freeformTagsJson = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String?> countryCode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsTableCompanion(
            id: id,
            userId: userId,
            name: name,
            gender: gender,
            mbti: mbti,
            hasVehicle: hasVehicle,
            vehicleSeats: vehicleSeats,
            freeformTagsJson: freeformTagsJson,
            isPrivate: isPrivate,
            countryCode: countryCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> userId = const Value.absent(),
            required String name,
            Value<String?> gender = const Value.absent(),
            Value<String?> mbti = const Value.absent(),
            Value<bool> hasVehicle = const Value.absent(),
            Value<int?> vehicleSeats = const Value.absent(),
            Value<String> freeformTagsJson = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String?> countryCode = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PersonsTableCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            gender: gender,
            mbti: mbti,
            hasVehicle: hasVehicle,
            vehicleSeats: vehicleSeats,
            freeformTagsJson: freeformTagsJson,
            isPrivate: isPrivate,
            countryCode: countryCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PersonsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({preferenceTagsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (preferenceTagsTableRefs) db.preferenceTagsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (preferenceTagsTableRefs)
                    await $_getPrefetchedData<PersonsTableData,
                            $PersonsTableTable, PreferenceTagsTableData>(
                        currentTable: table,
                        referencedTable: $$PersonsTableTableReferences
                            ._preferenceTagsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PersonsTableTableReferences(db, table, p0)
                                .preferenceTagsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.personNodeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PersonsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PersonsTableTable,
    PersonsTableData,
    $$PersonsTableTableFilterComposer,
    $$PersonsTableTableOrderingComposer,
    $$PersonsTableTableAnnotationComposer,
    $$PersonsTableTableCreateCompanionBuilder,
    $$PersonsTableTableUpdateCompanionBuilder,
    (PersonsTableData, $$PersonsTableTableReferences),
    PersonsTableData,
    PrefetchHooks Function({bool preferenceTagsTableRefs})>;
typedef $$PlacesTableTableCreateCompanionBuilder = PlacesTableCompanion
    Function({
  required String id,
  required String name,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> address,
  Value<String?> city,
  Value<String?> countryCode,
  Value<String> category,
  Value<String?> externalId,
  Value<int?> priceLevel,
  Value<double?> publicRating,
  Value<String?> personalNote,
  Value<double?> personalScore,
  Value<DateTime?> lastVisitedAt,
  Value<String> layer,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PlacesTableTableUpdateCompanionBuilder = PlacesTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> address,
  Value<String?> city,
  Value<String?> countryCode,
  Value<String> category,
  Value<String?> externalId,
  Value<int?> priceLevel,
  Value<double?> publicRating,
  Value<String?> personalNote,
  Value<double?> personalScore,
  Value<DateTime?> lastVisitedAt,
  Value<String> layer,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PlacesTableTableReferences
    extends BaseReferences<_$AppDatabase, $PlacesTableTable, PlacesTableData> {
  $$PlacesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SemanticDescriptorsTableTable,
      List<SemanticDescriptorsTableData>> _semanticDescriptorsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.semanticDescriptorsTable,
          aliasName: $_aliasNameGenerator(
              db.placesTable.id, db.semanticDescriptorsTable.placeNodeId));

  $$SemanticDescriptorsTableTableProcessedTableManager
      get semanticDescriptorsTableRefs {
    final manager = $$SemanticDescriptorsTableTableTableManager(
            $_db, $_db.semanticDescriptorsTable)
        .filter((f) => f.placeNodeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_semanticDescriptorsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlacesTableTableFilterComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get publicRating => $composableBuilder(
      column: $table.publicRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personalNote => $composableBuilder(
      column: $table.personalNote, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get personalScore => $composableBuilder(
      column: $table.personalScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastVisitedAt => $composableBuilder(
      column: $table.lastVisitedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get layer => $composableBuilder(
      column: $table.layer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> semanticDescriptorsTableRefs(
      Expression<bool> Function($$SemanticDescriptorsTableTableFilterComposer f)
          f) {
    final $$SemanticDescriptorsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.semanticDescriptorsTable,
            getReferencedColumn: (t) => t.placeNodeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SemanticDescriptorsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.semanticDescriptorsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlacesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get publicRating => $composableBuilder(
      column: $table.publicRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personalNote => $composableBuilder(
      column: $table.personalNote,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get personalScore => $composableBuilder(
      column: $table.personalScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastVisitedAt => $composableBuilder(
      column: $table.lastVisitedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get layer => $composableBuilder(
      column: $table.layer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$PlacesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlacesTableTable> {
  $$PlacesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get externalId => $composableBuilder(
      column: $table.externalId, builder: (column) => column);

  GeneratedColumn<int> get priceLevel => $composableBuilder(
      column: $table.priceLevel, builder: (column) => column);

  GeneratedColumn<double> get publicRating => $composableBuilder(
      column: $table.publicRating, builder: (column) => column);

  GeneratedColumn<String> get personalNote => $composableBuilder(
      column: $table.personalNote, builder: (column) => column);

  GeneratedColumn<double> get personalScore => $composableBuilder(
      column: $table.personalScore, builder: (column) => column);

  GeneratedColumn<DateTime> get lastVisitedAt => $composableBuilder(
      column: $table.lastVisitedAt, builder: (column) => column);

  GeneratedColumn<String> get layer =>
      $composableBuilder(column: $table.layer, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> semanticDescriptorsTableRefs<T extends Object>(
      Expression<T> Function(
              $$SemanticDescriptorsTableTableAnnotationComposer a)
          f) {
    final $$SemanticDescriptorsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.semanticDescriptorsTable,
            getReferencedColumn: (t) => t.placeNodeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$SemanticDescriptorsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.semanticDescriptorsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlacesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlacesTableTable,
    PlacesTableData,
    $$PlacesTableTableFilterComposer,
    $$PlacesTableTableOrderingComposer,
    $$PlacesTableTableAnnotationComposer,
    $$PlacesTableTableCreateCompanionBuilder,
    $$PlacesTableTableUpdateCompanionBuilder,
    (PlacesTableData, $$PlacesTableTableReferences),
    PlacesTableData,
    PrefetchHooks Function({bool semanticDescriptorsTableRefs})> {
  $$PlacesTableTableTableManager(_$AppDatabase db, $PlacesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> countryCode = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> externalId = const Value.absent(),
            Value<int?> priceLevel = const Value.absent(),
            Value<double?> publicRating = const Value.absent(),
            Value<String?> personalNote = const Value.absent(),
            Value<double?> personalScore = const Value.absent(),
            Value<DateTime?> lastVisitedAt = const Value.absent(),
            Value<String> layer = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlacesTableCompanion(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            address: address,
            city: city,
            countryCode: countryCode,
            category: category,
            externalId: externalId,
            priceLevel: priceLevel,
            publicRating: publicRating,
            personalNote: personalNote,
            personalScore: personalScore,
            lastVisitedAt: lastVisitedAt,
            layer: layer,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> countryCode = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> externalId = const Value.absent(),
            Value<int?> priceLevel = const Value.absent(),
            Value<double?> publicRating = const Value.absent(),
            Value<String?> personalNote = const Value.absent(),
            Value<double?> personalScore = const Value.absent(),
            Value<DateTime?> lastVisitedAt = const Value.absent(),
            Value<String> layer = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlacesTableCompanion.insert(
            id: id,
            name: name,
            latitude: latitude,
            longitude: longitude,
            address: address,
            city: city,
            countryCode: countryCode,
            category: category,
            externalId: externalId,
            priceLevel: priceLevel,
            publicRating: publicRating,
            personalNote: personalNote,
            personalScore: personalScore,
            lastVisitedAt: lastVisitedAt,
            layer: layer,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlacesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({semanticDescriptorsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (semanticDescriptorsTableRefs) db.semanticDescriptorsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (semanticDescriptorsTableRefs)
                    await $_getPrefetchedData<PlacesTableData,
                            $PlacesTableTable, SemanticDescriptorsTableData>(
                        currentTable: table,
                        referencedTable: $$PlacesTableTableReferences
                            ._semanticDescriptorsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlacesTableTableReferences(db, table, p0)
                                .semanticDescriptorsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.placeNodeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlacesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PlacesTableTable,
    PlacesTableData,
    $$PlacesTableTableFilterComposer,
    $$PlacesTableTableOrderingComposer,
    $$PlacesTableTableAnnotationComposer,
    $$PlacesTableTableCreateCompanionBuilder,
    $$PlacesTableTableUpdateCompanionBuilder,
    (PlacesTableData, $$PlacesTableTableReferences),
    PlacesTableData,
    PrefetchHooks Function({bool semanticDescriptorsTableRefs})>;
typedef $$PreferenceTagsTableTableCreateCompanionBuilder
    = PreferenceTagsTableCompanion Function({
  required String id,
  required String personNodeId,
  required String label,
  Value<String> sentiment,
  Value<double> weight,
  Value<String?> context,
  Value<String> source,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$PreferenceTagsTableTableUpdateCompanionBuilder
    = PreferenceTagsTableCompanion Function({
  Value<String> id,
  Value<String> personNodeId,
  Value<String> label,
  Value<String> sentiment,
  Value<double> weight,
  Value<String?> context,
  Value<String> source,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$PreferenceTagsTableTableReferences extends BaseReferences<
    _$AppDatabase, $PreferenceTagsTableTable, PreferenceTagsTableData> {
  $$PreferenceTagsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PersonsTableTable _personNodeIdTable(_$AppDatabase db) =>
      db.personsTable.createAlias($_aliasNameGenerator(
          db.preferenceTagsTable.personNodeId, db.personsTable.id));

  $$PersonsTableTableProcessedTableManager get personNodeId {
    final $_column = $_itemColumn<String>('person_node_id')!;

    final manager = $$PersonsTableTableTableManager($_db, $_db.personsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_personNodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PreferenceTagsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PreferenceTagsTableTable> {
  $$PreferenceTagsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sentiment => $composableBuilder(
      column: $table.sentiment, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$PersonsTableTableFilterComposer get personNodeId {
    final $$PersonsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personNodeId,
        referencedTable: $db.personsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableTableFilterComposer(
              $db: $db,
              $table: $db.personsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferenceTagsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PreferenceTagsTableTable> {
  $$PreferenceTagsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sentiment => $composableBuilder(
      column: $table.sentiment, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get context => $composableBuilder(
      column: $table.context, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$PersonsTableTableOrderingComposer get personNodeId {
    final $$PersonsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personNodeId,
        referencedTable: $db.personsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableTableOrderingComposer(
              $db: $db,
              $table: $db.personsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferenceTagsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PreferenceTagsTableTable> {
  $$PreferenceTagsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get sentiment =>
      $composableBuilder(column: $table.sentiment, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get context =>
      $composableBuilder(column: $table.context, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PersonsTableTableAnnotationComposer get personNodeId {
    final $$PersonsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.personNodeId,
        referencedTable: $db.personsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PersonsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.personsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$PreferenceTagsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PreferenceTagsTableTable,
    PreferenceTagsTableData,
    $$PreferenceTagsTableTableFilterComposer,
    $$PreferenceTagsTableTableOrderingComposer,
    $$PreferenceTagsTableTableAnnotationComposer,
    $$PreferenceTagsTableTableCreateCompanionBuilder,
    $$PreferenceTagsTableTableUpdateCompanionBuilder,
    (PreferenceTagsTableData, $$PreferenceTagsTableTableReferences),
    PreferenceTagsTableData,
    PrefetchHooks Function({bool personNodeId})> {
  $$PreferenceTagsTableTableTableManager(
      _$AppDatabase db, $PreferenceTagsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PreferenceTagsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PreferenceTagsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PreferenceTagsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> personNodeId = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> sentiment = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String?> context = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PreferenceTagsTableCompanion(
            id: id,
            personNodeId: personNodeId,
            label: label,
            sentiment: sentiment,
            weight: weight,
            context: context,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String personNodeId,
            required String label,
            Value<String> sentiment = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String?> context = const Value.absent(),
            Value<String> source = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              PreferenceTagsTableCompanion.insert(
            id: id,
            personNodeId: personNodeId,
            label: label,
            sentiment: sentiment,
            weight: weight,
            context: context,
            source: source,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PreferenceTagsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({personNodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (personNodeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.personNodeId,
                    referencedTable: $$PreferenceTagsTableTableReferences
                        ._personNodeIdTable(db),
                    referencedColumn: $$PreferenceTagsTableTableReferences
                        ._personNodeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$PreferenceTagsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PreferenceTagsTableTable,
    PreferenceTagsTableData,
    $$PreferenceTagsTableTableFilterComposer,
    $$PreferenceTagsTableTableOrderingComposer,
    $$PreferenceTagsTableTableAnnotationComposer,
    $$PreferenceTagsTableTableCreateCompanionBuilder,
    $$PreferenceTagsTableTableUpdateCompanionBuilder,
    (PreferenceTagsTableData, $$PreferenceTagsTableTableReferences),
    PreferenceTagsTableData,
    PrefetchHooks Function({bool personNodeId})>;
typedef $$SemanticDescriptorsTableTableCreateCompanionBuilder
    = SemanticDescriptorsTableCompanion Function({
  required String id,
  required String placeNodeId,
  required String descriptor,
  Value<String> source,
  Value<double> weight,
  Value<String?> embeddingJson,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SemanticDescriptorsTableTableUpdateCompanionBuilder
    = SemanticDescriptorsTableCompanion Function({
  Value<String> id,
  Value<String> placeNodeId,
  Value<String> descriptor,
  Value<String> source,
  Value<double> weight,
  Value<String?> embeddingJson,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$SemanticDescriptorsTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $SemanticDescriptorsTableTable,
    SemanticDescriptorsTableData> {
  $$SemanticDescriptorsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTableTable _placeNodeIdTable(_$AppDatabase db) =>
      db.placesTable.createAlias($_aliasNameGenerator(
          db.semanticDescriptorsTable.placeNodeId, db.placesTable.id));

  $$PlacesTableTableProcessedTableManager get placeNodeId {
    final $_column = $_itemColumn<String>('place_node_id')!;

    final manager = $$PlacesTableTableTableManager($_db, $_db.placesTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeNodeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SemanticDescriptorsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SemanticDescriptorsTableTable> {
  $$SemanticDescriptorsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descriptor => $composableBuilder(
      column: $table.descriptor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get embeddingJson => $composableBuilder(
      column: $table.embeddingJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$PlacesTableTableFilterComposer get placeNodeId {
    final $$PlacesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeNodeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableFilterComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SemanticDescriptorsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SemanticDescriptorsTableTable> {
  $$SemanticDescriptorsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descriptor => $composableBuilder(
      column: $table.descriptor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get embeddingJson => $composableBuilder(
      column: $table.embeddingJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$PlacesTableTableOrderingComposer get placeNodeId {
    final $$PlacesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeNodeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableOrderingComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SemanticDescriptorsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SemanticDescriptorsTableTable> {
  $$SemanticDescriptorsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descriptor => $composableBuilder(
      column: $table.descriptor, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get embeddingJson => $composableBuilder(
      column: $table.embeddingJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlacesTableTableAnnotationComposer get placeNodeId {
    final $$PlacesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.placeNodeId,
        referencedTable: $db.placesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlacesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.placesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SemanticDescriptorsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SemanticDescriptorsTableTable,
    SemanticDescriptorsTableData,
    $$SemanticDescriptorsTableTableFilterComposer,
    $$SemanticDescriptorsTableTableOrderingComposer,
    $$SemanticDescriptorsTableTableAnnotationComposer,
    $$SemanticDescriptorsTableTableCreateCompanionBuilder,
    $$SemanticDescriptorsTableTableUpdateCompanionBuilder,
    (SemanticDescriptorsTableData, $$SemanticDescriptorsTableTableReferences),
    SemanticDescriptorsTableData,
    PrefetchHooks Function({bool placeNodeId})> {
  $$SemanticDescriptorsTableTableTableManager(
      _$AppDatabase db, $SemanticDescriptorsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SemanticDescriptorsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$SemanticDescriptorsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SemanticDescriptorsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> placeNodeId = const Value.absent(),
            Value<String> descriptor = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String?> embeddingJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SemanticDescriptorsTableCompanion(
            id: id,
            placeNodeId: placeNodeId,
            descriptor: descriptor,
            source: source,
            weight: weight,
            embeddingJson: embeddingJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String placeNodeId,
            required String descriptor,
            Value<String> source = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String?> embeddingJson = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SemanticDescriptorsTableCompanion.insert(
            id: id,
            placeNodeId: placeNodeId,
            descriptor: descriptor,
            source: source,
            weight: weight,
            embeddingJson: embeddingJson,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$SemanticDescriptorsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({placeNodeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (placeNodeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.placeNodeId,
                    referencedTable: $$SemanticDescriptorsTableTableReferences
                        ._placeNodeIdTable(db),
                    referencedColumn: $$SemanticDescriptorsTableTableReferences
                        ._placeNodeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$SemanticDescriptorsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $SemanticDescriptorsTableTable,
        SemanticDescriptorsTableData,
        $$SemanticDescriptorsTableTableFilterComposer,
        $$SemanticDescriptorsTableTableOrderingComposer,
        $$SemanticDescriptorsTableTableAnnotationComposer,
        $$SemanticDescriptorsTableTableCreateCompanionBuilder,
        $$SemanticDescriptorsTableTableUpdateCompanionBuilder,
        (
          SemanticDescriptorsTableData,
          $$SemanticDescriptorsTableTableReferences
        ),
        SemanticDescriptorsTableData,
        PrefetchHooks Function({bool placeNodeId})>;
typedef $$RelationshipEdgesTableTableCreateCompanionBuilder
    = RelationshipEdgesTableCompanion Function({
  required String id,
  required String fromNodeId,
  required String fromNodeType,
  required String toNodeId,
  required String toNodeType,
  required String label,
  Value<double> weight,
  Value<String?> metadataJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$RelationshipEdgesTableTableUpdateCompanionBuilder
    = RelationshipEdgesTableCompanion Function({
  Value<String> id,
  Value<String> fromNodeId,
  Value<String> fromNodeType,
  Value<String> toNodeId,
  Value<String> toNodeType,
  Value<String> label,
  Value<double> weight,
  Value<String?> metadataJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$RelationshipEdgesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RelationshipEdgesTableTable> {
  $$RelationshipEdgesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fromNodeType => $composableBuilder(
      column: $table.fromNodeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toNodeId => $composableBuilder(
      column: $table.toNodeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get toNodeType => $composableBuilder(
      column: $table.toNodeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$RelationshipEdgesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RelationshipEdgesTableTable> {
  $$RelationshipEdgesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fromNodeType => $composableBuilder(
      column: $table.fromNodeType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toNodeId => $composableBuilder(
      column: $table.toNodeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get toNodeType => $composableBuilder(
      column: $table.toNodeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weight => $composableBuilder(
      column: $table.weight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$RelationshipEdgesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RelationshipEdgesTableTable> {
  $$RelationshipEdgesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fromNodeId => $composableBuilder(
      column: $table.fromNodeId, builder: (column) => column);

  GeneratedColumn<String> get fromNodeType => $composableBuilder(
      column: $table.fromNodeType, builder: (column) => column);

  GeneratedColumn<String> get toNodeId =>
      $composableBuilder(column: $table.toNodeId, builder: (column) => column);

  GeneratedColumn<String> get toNodeType => $composableBuilder(
      column: $table.toNodeType, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get metadataJson => $composableBuilder(
      column: $table.metadataJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RelationshipEdgesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RelationshipEdgesTableTable,
    RelationshipEdgesTableData,
    $$RelationshipEdgesTableTableFilterComposer,
    $$RelationshipEdgesTableTableOrderingComposer,
    $$RelationshipEdgesTableTableAnnotationComposer,
    $$RelationshipEdgesTableTableCreateCompanionBuilder,
    $$RelationshipEdgesTableTableUpdateCompanionBuilder,
    (
      RelationshipEdgesTableData,
      BaseReferences<_$AppDatabase, $RelationshipEdgesTableTable,
          RelationshipEdgesTableData>
    ),
    RelationshipEdgesTableData,
    PrefetchHooks Function()> {
  $$RelationshipEdgesTableTableTableManager(
      _$AppDatabase db, $RelationshipEdgesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RelationshipEdgesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RelationshipEdgesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RelationshipEdgesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> fromNodeId = const Value.absent(),
            Value<String> fromNodeType = const Value.absent(),
            Value<String> toNodeId = const Value.absent(),
            Value<String> toNodeType = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipEdgesTableCompanion(
            id: id,
            fromNodeId: fromNodeId,
            fromNodeType: fromNodeType,
            toNodeId: toNodeId,
            toNodeType: toNodeType,
            label: label,
            weight: weight,
            metadataJson: metadataJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String fromNodeId,
            required String fromNodeType,
            required String toNodeId,
            required String toNodeType,
            required String label,
            Value<double> weight = const Value.absent(),
            Value<String?> metadataJson = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RelationshipEdgesTableCompanion.insert(
            id: id,
            fromNodeId: fromNodeId,
            fromNodeType: fromNodeType,
            toNodeId: toNodeId,
            toNodeType: toNodeType,
            label: label,
            weight: weight,
            metadataJson: metadataJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$RelationshipEdgesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RelationshipEdgesTableTable,
        RelationshipEdgesTableData,
        $$RelationshipEdgesTableTableFilterComposer,
        $$RelationshipEdgesTableTableOrderingComposer,
        $$RelationshipEdgesTableTableAnnotationComposer,
        $$RelationshipEdgesTableTableCreateCompanionBuilder,
        $$RelationshipEdgesTableTableUpdateCompanionBuilder,
        (
          RelationshipEdgesTableData,
          BaseReferences<_$AppDatabase, $RelationshipEdgesTableTable,
              RelationshipEdgesTableData>
        ),
        RelationshipEdgesTableData,
        PrefetchHooks Function()>;
typedef $$GroupMemoriesTableTableCreateCompanionBuilder
    = GroupMemoriesTableCompanion Function({
  required String id,
  required String name,
  Value<String> pastPlanIdsJson,
  Value<String> visitedPlaceIdsJson,
  Value<String?> sharedPreferencesJson,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$GroupMemoriesTableTableUpdateCompanionBuilder
    = GroupMemoriesTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> pastPlanIdsJson,
  Value<String> visitedPlaceIdsJson,
  Value<String?> sharedPreferencesJson,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$GroupMemoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupMemoriesTableTable> {
  $$GroupMemoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pastPlanIdsJson => $composableBuilder(
      column: $table.pastPlanIdsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get visitedPlaceIdsJson => $composableBuilder(
      column: $table.visitedPlaceIdsJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sharedPreferencesJson => $composableBuilder(
      column: $table.sharedPreferencesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$GroupMemoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupMemoriesTableTable> {
  $$GroupMemoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pastPlanIdsJson => $composableBuilder(
      column: $table.pastPlanIdsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get visitedPlaceIdsJson => $composableBuilder(
      column: $table.visitedPlaceIdsJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sharedPreferencesJson => $composableBuilder(
      column: $table.sharedPreferencesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$GroupMemoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupMemoriesTableTable> {
  $$GroupMemoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get pastPlanIdsJson => $composableBuilder(
      column: $table.pastPlanIdsJson, builder: (column) => column);

  GeneratedColumn<String> get visitedPlaceIdsJson => $composableBuilder(
      column: $table.visitedPlaceIdsJson, builder: (column) => column);

  GeneratedColumn<String> get sharedPreferencesJson => $composableBuilder(
      column: $table.sharedPreferencesJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GroupMemoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GroupMemoriesTableTable,
    GroupMemoriesTableData,
    $$GroupMemoriesTableTableFilterComposer,
    $$GroupMemoriesTableTableOrderingComposer,
    $$GroupMemoriesTableTableAnnotationComposer,
    $$GroupMemoriesTableTableCreateCompanionBuilder,
    $$GroupMemoriesTableTableUpdateCompanionBuilder,
    (
      GroupMemoriesTableData,
      BaseReferences<_$AppDatabase, $GroupMemoriesTableTable,
          GroupMemoriesTableData>
    ),
    GroupMemoriesTableData,
    PrefetchHooks Function()> {
  $$GroupMemoriesTableTableTableManager(
      _$AppDatabase db, $GroupMemoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupMemoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupMemoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupMemoriesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> pastPlanIdsJson = const Value.absent(),
            Value<String> visitedPlaceIdsJson = const Value.absent(),
            Value<String?> sharedPreferencesJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMemoriesTableCompanion(
            id: id,
            name: name,
            pastPlanIdsJson: pastPlanIdsJson,
            visitedPlaceIdsJson: visitedPlaceIdsJson,
            sharedPreferencesJson: sharedPreferencesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String> pastPlanIdsJson = const Value.absent(),
            Value<String> visitedPlaceIdsJson = const Value.absent(),
            Value<String?> sharedPreferencesJson = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMemoriesTableCompanion.insert(
            id: id,
            name: name,
            pastPlanIdsJson: pastPlanIdsJson,
            visitedPlaceIdsJson: visitedPlaceIdsJson,
            sharedPreferencesJson: sharedPreferencesJson,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GroupMemoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GroupMemoriesTableTable,
    GroupMemoriesTableData,
    $$GroupMemoriesTableTableFilterComposer,
    $$GroupMemoriesTableTableOrderingComposer,
    $$GroupMemoriesTableTableAnnotationComposer,
    $$GroupMemoriesTableTableCreateCompanionBuilder,
    $$GroupMemoriesTableTableUpdateCompanionBuilder,
    (
      GroupMemoriesTableData,
      BaseReferences<_$AppDatabase, $GroupMemoriesTableTable,
          GroupMemoriesTableData>
    ),
    GroupMemoriesTableData,
    PrefetchHooks Function()>;
typedef $$GroupMembersTableTableCreateCompanionBuilder
    = GroupMembersTableCompanion Function({
  required String groupId,
  required String personNodeId,
  Value<int> rowid,
});
typedef $$GroupMembersTableTableUpdateCompanionBuilder
    = GroupMembersTableCompanion Function({
  Value<String> groupId,
  Value<String> personNodeId,
  Value<int> rowid,
});

class $$GroupMembersTableTableFilterComposer
    extends Composer<_$AppDatabase, $GroupMembersTableTable> {
  $$GroupMembersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get personNodeId => $composableBuilder(
      column: $table.personNodeId, builder: (column) => ColumnFilters(column));
}

class $$GroupMembersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupMembersTableTable> {
  $$GroupMembersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get groupId => $composableBuilder(
      column: $table.groupId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get personNodeId => $composableBuilder(
      column: $table.personNodeId,
      builder: (column) => ColumnOrderings(column));
}

class $$GroupMembersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupMembersTableTable> {
  $$GroupMembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get personNodeId => $composableBuilder(
      column: $table.personNodeId, builder: (column) => column);
}

class $$GroupMembersTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GroupMembersTableTable,
    GroupMembersTableData,
    $$GroupMembersTableTableFilterComposer,
    $$GroupMembersTableTableOrderingComposer,
    $$GroupMembersTableTableAnnotationComposer,
    $$GroupMembersTableTableCreateCompanionBuilder,
    $$GroupMembersTableTableUpdateCompanionBuilder,
    (
      GroupMembersTableData,
      BaseReferences<_$AppDatabase, $GroupMembersTableTable,
          GroupMembersTableData>
    ),
    GroupMembersTableData,
    PrefetchHooks Function()> {
  $$GroupMembersTableTableTableManager(
      _$AppDatabase db, $GroupMembersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupMembersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupMembersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupMembersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> groupId = const Value.absent(),
            Value<String> personNodeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMembersTableCompanion(
            groupId: groupId,
            personNodeId: personNodeId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String groupId,
            required String personNodeId,
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMembersTableCompanion.insert(
            groupId: groupId,
            personNodeId: personNodeId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GroupMembersTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GroupMembersTableTable,
    GroupMembersTableData,
    $$GroupMembersTableTableFilterComposer,
    $$GroupMembersTableTableOrderingComposer,
    $$GroupMembersTableTableAnnotationComposer,
    $$GroupMembersTableTableCreateCompanionBuilder,
    $$GroupMembersTableTableUpdateCompanionBuilder,
    (
      GroupMembersTableData,
      BaseReferences<_$AppDatabase, $GroupMembersTableTable,
          GroupMembersTableData>
    ),
    GroupMembersTableData,
    PrefetchHooks Function()>;
typedef $$AgentTasksTableTableCreateCompanionBuilder = AgentTasksTableCompanion
    Function({
  required String id,
  required String agentType,
  Value<String> status,
  required String contextJson,
  Value<String?> resultJson,
  Value<String?> errorMessage,
  required DateTime createdAt,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$AgentTasksTableTableUpdateCompanionBuilder = AgentTasksTableCompanion
    Function({
  Value<String> id,
  Value<String> agentType,
  Value<String> status,
  Value<String> contextJson,
  Value<String?> resultJson,
  Value<String?> errorMessage,
  Value<DateTime> createdAt,
  Value<DateTime?> startedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$AgentTasksTableTableReferences extends BaseReferences<
    _$AppDatabase, $AgentTasksTableTable, AgentTasksTableData> {
  $$AgentTasksTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecommendationPlansTableTable,
      List<RecommendationPlansTableData>> _recommendationPlansTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.recommendationPlansTable,
          aliasName: $_aliasNameGenerator(
              db.agentTasksTable.id, db.recommendationPlansTable.agentTaskId));

  $$RecommendationPlansTableTableProcessedTableManager
      get recommendationPlansTableRefs {
    final manager = $$RecommendationPlansTableTableTableManager(
            $_db, $_db.recommendationPlansTable)
        .filter((f) => f.agentTaskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_recommendationPlansTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$AgentTasksTableTableFilterComposer
    extends Composer<_$AppDatabase, $AgentTasksTableTable> {
  $$AgentTasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get agentType => $composableBuilder(
      column: $table.agentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resultJson => $composableBuilder(
      column: $table.resultJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> recommendationPlansTableRefs(
      Expression<bool> Function($$RecommendationPlansTableTableFilterComposer f)
          f) {
    final $$RecommendationPlansTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.recommendationPlansTable,
            getReferencedColumn: (t) => t.agentTaskId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecommendationPlansTableTableFilterComposer(
                  $db: $db,
                  $table: $db.recommendationPlansTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AgentTasksTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AgentTasksTableTable> {
  $$AgentTasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get agentType => $composableBuilder(
      column: $table.agentType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resultJson => $composableBuilder(
      column: $table.resultJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));
}

class $$AgentTasksTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AgentTasksTableTable> {
  $$AgentTasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get agentType =>
      $composableBuilder(column: $table.agentType, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get contextJson => $composableBuilder(
      column: $table.contextJson, builder: (column) => column);

  GeneratedColumn<String> get resultJson => $composableBuilder(
      column: $table.resultJson, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
      column: $table.errorMessage, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  Expression<T> recommendationPlansTableRefs<T extends Object>(
      Expression<T> Function(
              $$RecommendationPlansTableTableAnnotationComposer a)
          f) {
    final $$RecommendationPlansTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.recommendationPlansTable,
            getReferencedColumn: (t) => t.agentTaskId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$RecommendationPlansTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.recommendationPlansTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$AgentTasksTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AgentTasksTableTable,
    AgentTasksTableData,
    $$AgentTasksTableTableFilterComposer,
    $$AgentTasksTableTableOrderingComposer,
    $$AgentTasksTableTableAnnotationComposer,
    $$AgentTasksTableTableCreateCompanionBuilder,
    $$AgentTasksTableTableUpdateCompanionBuilder,
    (AgentTasksTableData, $$AgentTasksTableTableReferences),
    AgentTasksTableData,
    PrefetchHooks Function({bool recommendationPlansTableRefs})> {
  $$AgentTasksTableTableTableManager(
      _$AppDatabase db, $AgentTasksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AgentTasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AgentTasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AgentTasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> agentType = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> contextJson = const Value.absent(),
            Value<String?> resultJson = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AgentTasksTableCompanion(
            id: id,
            agentType: agentType,
            status: status,
            contextJson: contextJson,
            resultJson: resultJson,
            errorMessage: errorMessage,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String agentType,
            Value<String> status = const Value.absent(),
            required String contextJson,
            Value<String?> resultJson = const Value.absent(),
            Value<String?> errorMessage = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> startedAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AgentTasksTableCompanion.insert(
            id: id,
            agentType: agentType,
            status: status,
            contextJson: contextJson,
            resultJson: resultJson,
            errorMessage: errorMessage,
            createdAt: createdAt,
            startedAt: startedAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$AgentTasksTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({recommendationPlansTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recommendationPlansTableRefs) db.recommendationPlansTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recommendationPlansTableRefs)
                    await $_getPrefetchedData<
                            AgentTasksTableData,
                            $AgentTasksTableTable,
                            RecommendationPlansTableData>(
                        currentTable: table,
                        referencedTable: $$AgentTasksTableTableReferences
                            ._recommendationPlansTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$AgentTasksTableTableReferences(db, table, p0)
                                .recommendationPlansTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.agentTaskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$AgentTasksTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AgentTasksTableTable,
    AgentTasksTableData,
    $$AgentTasksTableTableFilterComposer,
    $$AgentTasksTableTableOrderingComposer,
    $$AgentTasksTableTableAnnotationComposer,
    $$AgentTasksTableTableCreateCompanionBuilder,
    $$AgentTasksTableTableUpdateCompanionBuilder,
    (AgentTasksTableData, $$AgentTasksTableTableReferences),
    AgentTasksTableData,
    PrefetchHooks Function({bool recommendationPlansTableRefs})>;
typedef $$RecommendationPlansTableTableCreateCompanionBuilder
    = RecommendationPlansTableCompanion Function({
  required String id,
  required String agentTaskId,
  Value<String?> groupMemoryId,
  required String title,
  Value<String> itemsJson,
  Value<String?> itineraryNarrative,
  Value<double?> overallScore,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$RecommendationPlansTableTableUpdateCompanionBuilder
    = RecommendationPlansTableCompanion Function({
  Value<String> id,
  Value<String> agentTaskId,
  Value<String?> groupMemoryId,
  Value<String> title,
  Value<String> itemsJson,
  Value<String?> itineraryNarrative,
  Value<double?> overallScore,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$RecommendationPlansTableTableReferences extends BaseReferences<
    _$AppDatabase,
    $RecommendationPlansTableTable,
    RecommendationPlansTableData> {
  $$RecommendationPlansTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $AgentTasksTableTable _agentTaskIdTable(_$AppDatabase db) =>
      db.agentTasksTable.createAlias($_aliasNameGenerator(
          db.recommendationPlansTable.agentTaskId, db.agentTasksTable.id));

  $$AgentTasksTableTableProcessedTableManager get agentTaskId {
    final $_column = $_itemColumn<String>('agent_task_id')!;

    final manager =
        $$AgentTasksTableTableTableManager($_db, $_db.agentTasksTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_agentTaskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RecommendationPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecommendationPlansTableTable> {
  $$RecommendationPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get groupMemoryId => $composableBuilder(
      column: $table.groupMemoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemsJson => $composableBuilder(
      column: $table.itemsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itineraryNarrative => $composableBuilder(
      column: $table.itineraryNarrative,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get overallScore => $composableBuilder(
      column: $table.overallScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$AgentTasksTableTableFilterComposer get agentTaskId {
    final $$AgentTasksTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentTaskId,
        referencedTable: $db.agentTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTasksTableTableFilterComposer(
              $db: $db,
              $table: $db.agentTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecommendationPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecommendationPlansTableTable> {
  $$RecommendationPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get groupMemoryId => $composableBuilder(
      column: $table.groupMemoryId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemsJson => $composableBuilder(
      column: $table.itemsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itineraryNarrative => $composableBuilder(
      column: $table.itineraryNarrative,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get overallScore => $composableBuilder(
      column: $table.overallScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$AgentTasksTableTableOrderingComposer get agentTaskId {
    final $$AgentTasksTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentTaskId,
        referencedTable: $db.agentTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTasksTableTableOrderingComposer(
              $db: $db,
              $table: $db.agentTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecommendationPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecommendationPlansTableTable> {
  $$RecommendationPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get groupMemoryId => $composableBuilder(
      column: $table.groupMemoryId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<String> get itineraryNarrative => $composableBuilder(
      column: $table.itineraryNarrative, builder: (column) => column);

  GeneratedColumn<double> get overallScore => $composableBuilder(
      column: $table.overallScore, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$AgentTasksTableTableAnnotationComposer get agentTaskId {
    final $$AgentTasksTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.agentTaskId,
        referencedTable: $db.agentTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$AgentTasksTableTableAnnotationComposer(
              $db: $db,
              $table: $db.agentTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RecommendationPlansTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RecommendationPlansTableTable,
    RecommendationPlansTableData,
    $$RecommendationPlansTableTableFilterComposer,
    $$RecommendationPlansTableTableOrderingComposer,
    $$RecommendationPlansTableTableAnnotationComposer,
    $$RecommendationPlansTableTableCreateCompanionBuilder,
    $$RecommendationPlansTableTableUpdateCompanionBuilder,
    (RecommendationPlansTableData, $$RecommendationPlansTableTableReferences),
    RecommendationPlansTableData,
    PrefetchHooks Function({bool agentTaskId})> {
  $$RecommendationPlansTableTableTableManager(
      _$AppDatabase db, $RecommendationPlansTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecommendationPlansTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$RecommendationPlansTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecommendationPlansTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> agentTaskId = const Value.absent(),
            Value<String?> groupMemoryId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> itemsJson = const Value.absent(),
            Value<String?> itineraryNarrative = const Value.absent(),
            Value<double?> overallScore = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              RecommendationPlansTableCompanion(
            id: id,
            agentTaskId: agentTaskId,
            groupMemoryId: groupMemoryId,
            title: title,
            itemsJson: itemsJson,
            itineraryNarrative: itineraryNarrative,
            overallScore: overallScore,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String agentTaskId,
            Value<String?> groupMemoryId = const Value.absent(),
            required String title,
            Value<String> itemsJson = const Value.absent(),
            Value<String?> itineraryNarrative = const Value.absent(),
            Value<double?> overallScore = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              RecommendationPlansTableCompanion.insert(
            id: id,
            agentTaskId: agentTaskId,
            groupMemoryId: groupMemoryId,
            title: title,
            itemsJson: itemsJson,
            itineraryNarrative: itineraryNarrative,
            overallScore: overallScore,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RecommendationPlansTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({agentTaskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (agentTaskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.agentTaskId,
                    referencedTable: $$RecommendationPlansTableTableReferences
                        ._agentTaskIdTable(db),
                    referencedColumn: $$RecommendationPlansTableTableReferences
                        ._agentTaskIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RecommendationPlansTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $RecommendationPlansTableTable,
        RecommendationPlansTableData,
        $$RecommendationPlansTableTableFilterComposer,
        $$RecommendationPlansTableTableOrderingComposer,
        $$RecommendationPlansTableTableAnnotationComposer,
        $$RecommendationPlansTableTableCreateCompanionBuilder,
        $$RecommendationPlansTableTableUpdateCompanionBuilder,
        (
          RecommendationPlansTableData,
          $$RecommendationPlansTableTableReferences
        ),
        RecommendationPlansTableData,
        PrefetchHooks Function({bool agentTaskId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonsTableTableTableManager get personsTable =>
      $$PersonsTableTableTableManager(_db, _db.personsTable);
  $$PlacesTableTableTableManager get placesTable =>
      $$PlacesTableTableTableManager(_db, _db.placesTable);
  $$PreferenceTagsTableTableTableManager get preferenceTagsTable =>
      $$PreferenceTagsTableTableTableManager(_db, _db.preferenceTagsTable);
  $$SemanticDescriptorsTableTableTableManager get semanticDescriptorsTable =>
      $$SemanticDescriptorsTableTableTableManager(
          _db, _db.semanticDescriptorsTable);
  $$RelationshipEdgesTableTableTableManager get relationshipEdgesTable =>
      $$RelationshipEdgesTableTableTableManager(
          _db, _db.relationshipEdgesTable);
  $$GroupMemoriesTableTableTableManager get groupMemoriesTable =>
      $$GroupMemoriesTableTableTableManager(_db, _db.groupMemoriesTable);
  $$GroupMembersTableTableTableManager get groupMembersTable =>
      $$GroupMembersTableTableTableManager(_db, _db.groupMembersTable);
  $$AgentTasksTableTableTableManager get agentTasksTable =>
      $$AgentTasksTableTableTableManager(_db, _db.agentTasksTable);
  $$RecommendationPlansTableTableTableManager get recommendationPlansTable =>
      $$RecommendationPlansTableTableTableManager(
          _db, _db.recommendationPlansTable);
}
