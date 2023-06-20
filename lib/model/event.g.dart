// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEventCollection on Isar {
  IsarCollection<Event> get events => this.collection();
}

const EventSchema = CollectionSchema(
  name: r'Event',
  id: 2102939193127251002,
  properties: {
    r'clickMillis': PropertySchema(
      id: 0,
      name: r'clickMillis',
      type: IsarType.long,
    ),
    r'clickTime': PropertySchema(
      id: 1,
      name: r'clickTime',
      type: IsarType.string,
    ),
    r'deleted': PropertySchema(
      id: 2,
      name: r'deleted',
      type: IsarType.bool,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'endClip': PropertySchema(
      id: 4,
      name: r'endClip',
      type: IsarType.string,
    ),
    r'endMillis': PropertySchema(
      id: 5,
      name: r'endMillis',
      type: IsarType.long,
    ),
    r'isFakeMoment': PropertySchema(
      id: 6,
      name: r'isFakeMoment',
      type: IsarType.bool,
    ),
    r'isFavourite': PropertySchema(
      id: 7,
      name: r'isFavourite',
      type: IsarType.bool,
    ),
    r'mainEventPlayer': PropertySchema(
      id: 8,
      name: r'mainEventPlayer',
      type: IsarType.string,
    ),
    r'matchTime': PropertySchema(
      id: 9,
      name: r'matchTime',
      type: IsarType.string,
    ),
    r'matchTimeMillis': PropertySchema(
      id: 10,
      name: r'matchTimeMillis',
      type: IsarType.long,
    ),
    r'partita': PropertySchema(
      id: 11,
      name: r'partita',
      type: IsarType.string,
    ),
    r'startClip': PropertySchema(
      id: 12,
      name: r'startClip',
      type: IsarType.string,
    ),
    r'startMillis': PropertySchema(
      id: 13,
      name: r'startMillis',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 14,
      name: r'status',
      type: IsarType.string,
      enumMap: _EventstatusEnumValueMap,
    ),
    r'success': PropertySchema(
      id: 15,
      name: r'success',
      type: IsarType.bool,
    ),
    r'team': PropertySchema(
      id: 16,
      name: r'team',
      type: IsarType.string,
      enumMap: _EventteamEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 17,
      name: r'type',
      type: IsarType.string,
      enumMap: _EventtypeEnumValueMap,
    )
  },
  estimateSize: _eventEstimateSize,
  serialize: _eventSerialize,
  deserialize: _eventDeserialize,
  deserializeProp: _eventDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'game': LinkSchema(
      id: 8968804212938065807,
      name: r'game',
      target: r'SportMatch',
      single: true,
      linkName: r'events',
    )
  },
  embeddedSchemas: {},
  getId: _eventGetId,
  getLinks: _eventGetLinks,
  attach: _eventAttach,
  version: '3.1.0+1',
);

int _eventEstimateSize(
  Event object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clickTime.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.endClip.length * 3;
  {
    final value = object.mainEventPlayer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.matchTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.partita.length * 3;
  bytesCount += 3 + object.startClip.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  bytesCount += 3 + object.team.name.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _eventSerialize(
  Event object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.clickMillis);
  writer.writeString(offsets[1], object.clickTime);
  writer.writeBool(offsets[2], object.deleted);
  writer.writeString(offsets[3], object.description);
  writer.writeString(offsets[4], object.endClip);
  writer.writeLong(offsets[5], object.endMillis);
  writer.writeBool(offsets[6], object.isFakeMoment);
  writer.writeBool(offsets[7], object.isFavourite);
  writer.writeString(offsets[8], object.mainEventPlayer);
  writer.writeString(offsets[9], object.matchTime);
  writer.writeLong(offsets[10], object.matchTimeMillis);
  writer.writeString(offsets[11], object.partita);
  writer.writeString(offsets[12], object.startClip);
  writer.writeLong(offsets[13], object.startMillis);
  writer.writeString(offsets[14], object.status.name);
  writer.writeBool(offsets[15], object.success);
  writer.writeString(offsets[16], object.team.name);
  writer.writeString(offsets[17], object.type.name);
}

Event _eventDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Event();
  object.clickMillis = reader.readLong(offsets[0]);
  object.clickTime = reader.readString(offsets[1]);
  object.deleted = reader.readBool(offsets[2]);
  object.description = reader.readStringOrNull(offsets[3]);
  object.endClip = reader.readString(offsets[4]);
  object.endMillis = reader.readLong(offsets[5]);
  object.id = id;
  object.isFakeMoment = reader.readBool(offsets[6]);
  object.isFavourite = reader.readBool(offsets[7]);
  object.mainEventPlayer = reader.readStringOrNull(offsets[8]);
  object.matchTime = reader.readStringOrNull(offsets[9]);
  object.matchTimeMillis = reader.readLongOrNull(offsets[10]);
  object.partita = reader.readString(offsets[11]);
  object.startClip = reader.readString(offsets[12]);
  object.startMillis = reader.readLong(offsets[13]);
  object.status =
      _EventstatusValueEnumMap[reader.readStringOrNull(offsets[14])] ??
          EventStatus.NOT_EXIST;
  object.success = reader.readBool(offsets[15]);
  object.team = _EventteamValueEnumMap[reader.readStringOrNull(offsets[16])] ??
      EventTeam.HOME;
  object.type = _EventtypeValueEnumMap[reader.readStringOrNull(offsets[17])] ??
      EventType.NONE;
  return object;
}

P _eventDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readLong(offset)) as P;
    case 14:
      return (_EventstatusValueEnumMap[reader.readStringOrNull(offset)] ??
          EventStatus.NOT_EXIST) as P;
    case 15:
      return (reader.readBool(offset)) as P;
    case 16:
      return (_EventteamValueEnumMap[reader.readStringOrNull(offset)] ??
          EventTeam.HOME) as P;
    case 17:
      return (_EventtypeValueEnumMap[reader.readStringOrNull(offset)] ??
          EventType.NONE) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _EventstatusEnumValueMap = {
  r'NOT_EXIST': r'NOT_EXIST',
  r'NOT_WATCHED': r'NOT_WATCHED',
  r'WATCHED': r'WATCHED',
};
const _EventstatusValueEnumMap = {
  r'NOT_EXIST': EventStatus.NOT_EXIST,
  r'NOT_WATCHED': EventStatus.NOT_WATCHED,
  r'WATCHED': EventStatus.WATCHED,
};
const _EventteamEnumValueMap = {
  r'HOME': r'HOME',
  r'AWAY': r'AWAY',
};
const _EventteamValueEnumMap = {
  r'HOME': EventTeam.HOME,
  r'AWAY': EventTeam.AWAY,
};
const _EventtypeEnumValueMap = {
  r'NONE': r'NONE',
  r'INIZIO_PARTITA': r'INIZIO_PARTITA',
  r'FINE_PRIMO_TEMPO': r'FINE_PRIMO_TEMPO',
  r'INIZIO_SECONDO_TEMPO': r'INIZIO_SECONDO_TEMPO',
  r'FINE_PARTITA': r'FINE_PARTITA',
  r'GOAL': r'GOAL',
  r'ASSIST': r'ASSIST',
  r'QUASI_GOAL': r'QUASI_GOAL',
  r'RIGORI': r'RIGORI',
  r'PAPERE': r'PAPERE',
  r'BOTTE': r'BOTTE',
  r'AL_BARETTO': r'AL_BARETTO',
  r'LOL_REGIA': r'LOL_REGIA',
  r'MVP': r'MVP',
  r'INTERVISTA': r'INTERVISTA',
  r'PRESENZE': r'PRESENZE',
};
const _EventtypeValueEnumMap = {
  r'NONE': EventType.NONE,
  r'INIZIO_PARTITA': EventType.INIZIO_PARTITA,
  r'FINE_PRIMO_TEMPO': EventType.FINE_PRIMO_TEMPO,
  r'INIZIO_SECONDO_TEMPO': EventType.INIZIO_SECONDO_TEMPO,
  r'FINE_PARTITA': EventType.FINE_PARTITA,
  r'GOAL': EventType.GOAL,
  r'ASSIST': EventType.ASSIST,
  r'QUASI_GOAL': EventType.QUASI_GOAL,
  r'RIGORI': EventType.RIGORI,
  r'PAPERE': EventType.PAPERE,
  r'BOTTE': EventType.BOTTE,
  r'AL_BARETTO': EventType.AL_BARETTO,
  r'LOL_REGIA': EventType.LOL_REGIA,
  r'MVP': EventType.MVP,
  r'INTERVISTA': EventType.INTERVISTA,
  r'PRESENZE': EventType.PRESENZE,
};

Id _eventGetId(Event object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _eventGetLinks(Event object) {
  return [object.game];
}

void _eventAttach(IsarCollection<dynamic> col, Id id, Event object) {
  object.id = id;
  object.game.attach(col, col.isar.collection<SportMatch>(), r'game', id);
}

extension EventQueryWhereSort on QueryBuilder<Event, Event, QWhere> {
  QueryBuilder<Event, Event, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EventQueryWhere on QueryBuilder<Event, Event, QWhereClause> {
  QueryBuilder<Event, Event, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EventQueryFilter on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> clickMillisEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clickMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickMillisGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clickMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickMillisLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clickMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickMillisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clickMillis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clickTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clickTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clickTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clickTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> clickTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clickTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> deletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'description',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endClip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'endClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'endClip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endClip',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endClipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'endClip',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endMillisEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endMillisGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endMillisLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> endMillisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endMillis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> isFakeMomentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFakeMoment',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> isFavouriteEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavourite',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainEventPlayer',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainEventPlayer',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainEventPlayer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainEventPlayer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainEventPlayer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> mainEventPlayerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainEventPlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition>
      mainEventPlayerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainEventPlayer',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'matchTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'matchTime',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'matchTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'matchTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matchTime',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'matchTimeMillis',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'matchTimeMillis',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> matchTimeMillisBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchTimeMillis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partita',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'partita',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'partita',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partita',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> partitaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partita',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startClip',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'startClip',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'startClip',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startClip',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startClipIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'startClip',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startMillisEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startMillisGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startMillisLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> startMillisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startMillis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusEqualTo(
    EventStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusGreaterThan(
    EventStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusLessThan(
    EventStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusBetween(
    EventStatus lower,
    EventStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> successEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'success',
        value: value,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamEqualTo(
    EventTeam value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamGreaterThan(
    EventTeam value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamLessThan(
    EventTeam value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamBetween(
    EventTeam lower,
    EventTeam upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'team',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'team',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'team',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'team',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> teamIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'team',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeEqualTo(
    EventType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeGreaterThan(
    EventType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeLessThan(
    EventType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeBetween(
    EventType lower,
    EventType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension EventQueryObject on QueryBuilder<Event, Event, QFilterCondition> {}

extension EventQueryLinks on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> game(
      FilterQuery<SportMatch> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'game');
    });
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> gameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'game', 0, true, 0, true);
    });
  }
}

extension EventQuerySortBy on QueryBuilder<Event, Event, QSortBy> {
  QueryBuilder<Event, Event, QAfterSortBy> sortByClickMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByClickMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByClickTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByClickTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndClip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endClip', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndClipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endClip', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByEndMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsFakeMoment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFakeMoment', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsFakeMomentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFakeMoment', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsFavourite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavourite', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIsFavouriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavourite', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMainEventPlayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainEventPlayer', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMainEventPlayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainEventPlayer', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMatchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMatchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMatchTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTimeMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByMatchTimeMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTimeMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPartita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partita', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByPartitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partita', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartClip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startClip', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartClipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startClip', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStartMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'success', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortBySuccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'success', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByTeam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByTeamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension EventQuerySortThenBy on QueryBuilder<Event, Event, QSortThenBy> {
  QueryBuilder<Event, Event, QAfterSortBy> thenByClickMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByClickMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByClickTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByClickTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clickTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deleted', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndClip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endClip', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndClipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endClip', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByEndMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsFakeMoment() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFakeMoment', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsFakeMomentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFakeMoment', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsFavourite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavourite', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIsFavouriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavourite', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMainEventPlayer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainEventPlayer', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMainEventPlayerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainEventPlayer', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMatchTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMatchTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTime', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMatchTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTimeMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByMatchTimeMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchTimeMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPartita() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partita', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByPartitaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partita', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartClip() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startClip', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartClipDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startClip', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMillis', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStartMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startMillis', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'success', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenBySuccessDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'success', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByTeam() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByTeamDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'team', Sort.desc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, Event, QDistinct> {
  QueryBuilder<Event, Event, QDistinct> distinctByClickMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clickMillis');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByClickTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clickTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deleted');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByEndClip(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endClip', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByEndMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endMillis');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIsFakeMoment() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFakeMoment');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByIsFavourite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavourite');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByMainEventPlayer(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainEventPlayer',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByMatchTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByMatchTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchTimeMillis');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByPartita(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partita', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByStartClip(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startClip', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByStartMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startMillis');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctBySuccess() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'success');
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByTeam(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'team', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Event, Event, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension EventQueryProperty on QueryBuilder<Event, Event, QQueryProperty> {
  QueryBuilder<Event, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> clickMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clickMillis');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> clickTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clickTime');
    });
  }

  QueryBuilder<Event, bool, QQueryOperations> deletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deleted');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> endClipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endClip');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> endMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endMillis');
    });
  }

  QueryBuilder<Event, bool, QQueryOperations> isFakeMomentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFakeMoment');
    });
  }

  QueryBuilder<Event, bool, QQueryOperations> isFavouriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavourite');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> mainEventPlayerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainEventPlayer');
    });
  }

  QueryBuilder<Event, String?, QQueryOperations> matchTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchTime');
    });
  }

  QueryBuilder<Event, int?, QQueryOperations> matchTimeMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchTimeMillis');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> partitaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partita');
    });
  }

  QueryBuilder<Event, String, QQueryOperations> startClipProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startClip');
    });
  }

  QueryBuilder<Event, int, QQueryOperations> startMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startMillis');
    });
  }

  QueryBuilder<Event, EventStatus, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<Event, bool, QQueryOperations> successProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'success');
    });
  }

  QueryBuilder<Event, EventTeam, QQueryOperations> teamProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'team');
    });
  }

  QueryBuilder<Event, EventType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
