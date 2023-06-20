// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_match.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSportMatchCollection on Isar {
  IsarCollection<SportMatch> get sportMatchs => this.collection();
}

const SportMatchSchema = CollectionSchema(
  name: r'SportMatch',
  id: -4730353655701018245,
  properties: {
    r'away': PropertySchema(
      id: 0,
      name: r'away',
      type: IsarType.string,
    ),
    r'awayResult': PropertySchema(
      id: 1,
      name: r'awayResult',
      type: IsarType.long,
    ),
    r'dateTime': PropertySchema(
      id: 2,
      name: r'dateTime',
      type: IsarType.string,
    ),
    r'home': PropertySchema(
      id: 3,
      name: r'home',
      type: IsarType.string,
    ),
    r'homeResult': PropertySchema(
      id: 4,
      name: r'homeResult',
      type: IsarType.long,
    ),
    r'isCurrent': PropertySchema(
      id: 5,
      name: r'isCurrent',
      type: IsarType.bool,
    ),
    r'isFF': PropertySchema(
      id: 6,
      name: r'isFF',
      type: IsarType.bool,
    ),
    r'pausedTimeMillis': PropertySchema(
      id: 7,
      name: r'pausedTimeMillis',
      type: IsarType.long,
    ),
    r'state': PropertySchema(
      id: 8,
      name: r'state',
      type: IsarType.string,
      enumMap: _SportMatchstateEnumValueMap,
    )
  },
  estimateSize: _sportMatchEstimateSize,
  serialize: _sportMatchSerialize,
  deserialize: _sportMatchDeserialize,
  deserializeProp: _sportMatchDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'events': LinkSchema(
      id: 1100818548105840135,
      name: r'events',
      target: r'Event',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _sportMatchGetId,
  getLinks: _sportMatchGetLinks,
  attach: _sportMatchAttach,
  version: '3.1.0+1',
);

int _sportMatchEstimateSize(
  SportMatch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.away.length * 3;
  {
    final value = object.dateTime;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.home.length * 3;
  bytesCount += 3 + object.state.name.length * 3;
  return bytesCount;
}

void _sportMatchSerialize(
  SportMatch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.away);
  writer.writeLong(offsets[1], object.awayResult);
  writer.writeString(offsets[2], object.dateTime);
  writer.writeString(offsets[3], object.home);
  writer.writeLong(offsets[4], object.homeResult);
  writer.writeBool(offsets[5], object.isCurrent);
  writer.writeBool(offsets[6], object.isFF);
  writer.writeLong(offsets[7], object.pausedTimeMillis);
  writer.writeString(offsets[8], object.state.name);
}

SportMatch _sportMatchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SportMatch();
  object.away = reader.readString(offsets[0]);
  object.awayResult = reader.readLong(offsets[1]);
  object.dateTime = reader.readStringOrNull(offsets[2]);
  object.home = reader.readString(offsets[3]);
  object.homeResult = reader.readLong(offsets[4]);
  object.id = id;
  object.isCurrent = reader.readBool(offsets[5]);
  object.isFF = reader.readBool(offsets[6]);
  object.pausedTimeMillis = reader.readLongOrNull(offsets[7]);
  object.state =
      _SportMatchstateValueEnumMap[reader.readStringOrNull(offsets[8])] ??
          MatchState.NONE;
  return object;
}

P _sportMatchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (_SportMatchstateValueEnumMap[reader.readStringOrNull(offset)] ??
          MatchState.NONE) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _SportMatchstateEnumValueMap = {
  r'NONE': r'NONE',
  r'INIZIO_PARTITA': r'INIZIO_PARTITA',
  r'FINE_PRIMO_TEMPO': r'FINE_PRIMO_TEMPO',
  r'INIZIO_SECONDO_TEMPO': r'INIZIO_SECONDO_TEMPO',
  r'FINE_PARTITA': r'FINE_PARTITA',
};
const _SportMatchstateValueEnumMap = {
  r'NONE': MatchState.NONE,
  r'INIZIO_PARTITA': MatchState.INIZIO_PARTITA,
  r'FINE_PRIMO_TEMPO': MatchState.FINE_PRIMO_TEMPO,
  r'INIZIO_SECONDO_TEMPO': MatchState.INIZIO_SECONDO_TEMPO,
  r'FINE_PARTITA': MatchState.FINE_PARTITA,
};

Id _sportMatchGetId(SportMatch object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sportMatchGetLinks(SportMatch object) {
  return [object.events];
}

void _sportMatchAttach(IsarCollection<dynamic> col, Id id, SportMatch object) {
  object.id = id;
  object.events.attach(col, col.isar.collection<Event>(), r'events', id);
}

extension SportMatchQueryWhereSort
    on QueryBuilder<SportMatch, SportMatch, QWhere> {
  QueryBuilder<SportMatch, SportMatch, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SportMatchQueryWhere
    on QueryBuilder<SportMatch, SportMatch, QWhereClause> {
  QueryBuilder<SportMatch, SportMatch, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<SportMatch, SportMatch, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterWhereClause> idBetween(
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

extension SportMatchQueryFilter
    on QueryBuilder<SportMatch, SportMatch, QFilterCondition> {
  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'away',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'away',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'away',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'away',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'away',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayResultEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'awayResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      awayResultGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'awayResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      awayResultLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'awayResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> awayResultBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'awayResult',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      dateTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTime',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      dateTimeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      dateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> dateTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      dateTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      dateTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'home',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'home',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'home',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'home',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'home',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeResultEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'homeResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      homeResultGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'homeResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      homeResultLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'homeResult',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> homeResultBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'homeResult',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> isCurrentEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCurrent',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> isFFEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFF',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pausedTimeMillis',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pausedTimeMillis',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pausedTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pausedTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pausedTimeMillis',
        value: value,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      pausedTimeMillisBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pausedTimeMillis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateEqualTo(
    MatchState value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateGreaterThan(
    MatchState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateLessThan(
    MatchState value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateBetween(
    MatchState lower,
    MatchState upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }
}

extension SportMatchQueryObject
    on QueryBuilder<SportMatch, SportMatch, QFilterCondition> {}

extension SportMatchQueryLinks
    on QueryBuilder<SportMatch, SportMatch, QFilterCondition> {
  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> events(
      FilterQuery<Event> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'events');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      eventsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', length, true, length, true);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition> eventsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, true, 0, true);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      eventsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, false, 999999, true);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      eventsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', 0, true, length, include);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      eventsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'events', length, include, 999999, true);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterFilterCondition>
      eventsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'events', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SportMatchQuerySortBy
    on QueryBuilder<SportMatch, SportMatch, QSortBy> {
  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByAway() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'away', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByAwayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'away', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByAwayResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayResult', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByAwayResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayResult', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByHome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'home', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByHomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'home', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByHomeResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeResult', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByHomeResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeResult', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByIsFF() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFF', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByIsFFDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFF', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByPausedTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedTimeMillis', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy>
      sortByPausedTimeMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedTimeMillis', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension SportMatchQuerySortThenBy
    on QueryBuilder<SportMatch, SportMatch, QSortThenBy> {
  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByAway() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'away', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByAwayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'away', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByAwayResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayResult', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByAwayResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'awayResult', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByDateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByDateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTime', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByHome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'home', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByHomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'home', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByHomeResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeResult', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByHomeResultDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'homeResult', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByIsCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCurrent', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByIsFF() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFF', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByIsFFDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFF', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByPausedTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedTimeMillis', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy>
      thenByPausedTimeMillisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pausedTimeMillis', Sort.desc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }
}

extension SportMatchQueryWhereDistinct
    on QueryBuilder<SportMatch, SportMatch, QDistinct> {
  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByAway(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'away', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByAwayResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'awayResult');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByDateTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTime', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByHome(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'home', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByHomeResult() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'homeResult');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByIsCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCurrent');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByIsFF() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFF');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByPausedTimeMillis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pausedTimeMillis');
    });
  }

  QueryBuilder<SportMatch, SportMatch, QDistinct> distinctByState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }
}

extension SportMatchQueryProperty
    on QueryBuilder<SportMatch, SportMatch, QQueryProperty> {
  QueryBuilder<SportMatch, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SportMatch, String, QQueryOperations> awayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'away');
    });
  }

  QueryBuilder<SportMatch, int, QQueryOperations> awayResultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'awayResult');
    });
  }

  QueryBuilder<SportMatch, String?, QQueryOperations> dateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTime');
    });
  }

  QueryBuilder<SportMatch, String, QQueryOperations> homeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'home');
    });
  }

  QueryBuilder<SportMatch, int, QQueryOperations> homeResultProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'homeResult');
    });
  }

  QueryBuilder<SportMatch, bool, QQueryOperations> isCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCurrent');
    });
  }

  QueryBuilder<SportMatch, bool, QQueryOperations> isFFProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFF');
    });
  }

  QueryBuilder<SportMatch, int?, QQueryOperations> pausedTimeMillisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pausedTimeMillis');
    });
  }

  QueryBuilder<SportMatch, MatchState, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }
}
