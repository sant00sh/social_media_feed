// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeedModel _$FeedModelFromJson(Map<String, dynamic> json) {
  return _FeedModel.fromJson(json);
}

/// @nodoc
mixin _$FeedModel {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String get body => throw _privateConstructorUsedError;
  @HiveField(3)
  int get userId => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get userName => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get userEmail => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get userImage => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get feedImage => throw _privateConstructorUsedError;
  @HiveField(8)
  bool? get isLike => throw _privateConstructorUsedError;
  @HiveField(9)
  List<CommentModel>? get comments => throw _privateConstructorUsedError;
  @HiveField(10)
  int? get likesCount => throw _privateConstructorUsedError;
  @HiveField(11)
  DateTime? get postedDate => throw _privateConstructorUsedError;

  /// Serializes this FeedModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedModelCopyWith<FeedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedModelCopyWith<$Res> {
  factory $FeedModelCopyWith(FeedModel value, $Res Function(FeedModel) then) =
      _$FeedModelCopyWithImpl<$Res, FeedModel>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String title,
      @HiveField(2) String body,
      @HiveField(3) int userId,
      @HiveField(4) String? userName,
      @HiveField(5) String? userEmail,
      @HiveField(6) String? userImage,
      @HiveField(7) String? feedImage,
      @HiveField(8) bool? isLike,
      @HiveField(9) List<CommentModel>? comments,
      @HiveField(10) int? likesCount,
      @HiveField(11) DateTime? postedDate});
}

/// @nodoc
class _$FeedModelCopyWithImpl<$Res, $Val extends FeedModel>
    implements $FeedModelCopyWith<$Res> {
  _$FeedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? userId = null,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userImage = freezed,
    Object? feedImage = freezed,
    Object? isLike = freezed,
    Object? comments = freezed,
    Object? likesCount = freezed,
    Object? postedDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      feedImage: freezed == feedImage
          ? _value.feedImage
          : feedImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLike: freezed == isLike
          ? _value.isLike
          : isLike // ignore: cast_nullable_to_non_nullable
              as bool?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      postedDate: freezed == postedDate
          ? _value.postedDate
          : postedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedModelImplCopyWith<$Res>
    implements $FeedModelCopyWith<$Res> {
  factory _$$FeedModelImplCopyWith(
          _$FeedModelImpl value, $Res Function(_$FeedModelImpl) then) =
      __$$FeedModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String title,
      @HiveField(2) String body,
      @HiveField(3) int userId,
      @HiveField(4) String? userName,
      @HiveField(5) String? userEmail,
      @HiveField(6) String? userImage,
      @HiveField(7) String? feedImage,
      @HiveField(8) bool? isLike,
      @HiveField(9) List<CommentModel>? comments,
      @HiveField(10) int? likesCount,
      @HiveField(11) DateTime? postedDate});
}

/// @nodoc
class __$$FeedModelImplCopyWithImpl<$Res>
    extends _$FeedModelCopyWithImpl<$Res, _$FeedModelImpl>
    implements _$$FeedModelImplCopyWith<$Res> {
  __$$FeedModelImplCopyWithImpl(
      _$FeedModelImpl _value, $Res Function(_$FeedModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeedModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? userId = null,
    Object? userName = freezed,
    Object? userEmail = freezed,
    Object? userImage = freezed,
    Object? feedImage = freezed,
    Object? isLike = freezed,
    Object? comments = freezed,
    Object? likesCount = freezed,
    Object? postedDate = freezed,
  }) {
    return _then(_$FeedModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      userEmail: freezed == userEmail
          ? _value.userEmail
          : userEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      userImage: freezed == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String?,
      feedImage: freezed == feedImage
          ? _value.feedImage
          : feedImage // ignore: cast_nullable_to_non_nullable
              as String?,
      isLike: freezed == isLike
          ? _value.isLike
          : isLike // ignore: cast_nullable_to_non_nullable
              as bool?,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<CommentModel>?,
      likesCount: freezed == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int?,
      postedDate: freezed == postedDate
          ? _value.postedDate
          : postedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedModelImpl implements _FeedModel {
  const _$FeedModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.title,
      @HiveField(2) required this.body,
      @HiveField(3) required this.userId,
      @HiveField(4) this.userName,
      @HiveField(5) this.userEmail,
      @HiveField(6) this.userImage,
      @HiveField(7) this.feedImage,
      @HiveField(8) this.isLike,
      @HiveField(9) final List<CommentModel>? comments,
      @HiveField(10) this.likesCount,
      @HiveField(11) this.postedDate})
      : _comments = comments;

  factory _$FeedModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedModelImplFromJson(json);

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String title;
  @override
  @HiveField(2)
  final String body;
  @override
  @HiveField(3)
  final int userId;
  @override
  @HiveField(4)
  final String? userName;
  @override
  @HiveField(5)
  final String? userEmail;
  @override
  @HiveField(6)
  final String? userImage;
  @override
  @HiveField(7)
  final String? feedImage;
  @override
  @HiveField(8)
  final bool? isLike;
  final List<CommentModel>? _comments;
  @override
  @HiveField(9)
  List<CommentModel>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(10)
  final int? likesCount;
  @override
  @HiveField(11)
  final DateTime? postedDate;

  @override
  String toString() {
    return 'FeedModel(id: $id, title: $title, body: $body, userId: $userId, userName: $userName, userEmail: $userEmail, userImage: $userImage, feedImage: $feedImage, isLike: $isLike, comments: $comments, likesCount: $likesCount, postedDate: $postedDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userEmail, userEmail) ||
                other.userEmail == userEmail) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage) &&
            (identical(other.feedImage, feedImage) ||
                other.feedImage == feedImage) &&
            (identical(other.isLike, isLike) || other.isLike == isLike) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.postedDate, postedDate) ||
                other.postedDate == postedDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      body,
      userId,
      userName,
      userEmail,
      userImage,
      feedImage,
      isLike,
      const DeepCollectionEquality().hash(_comments),
      likesCount,
      postedDate);

  /// Create a copy of FeedModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedModelImplCopyWith<_$FeedModelImpl> get copyWith =>
      __$$FeedModelImplCopyWithImpl<_$FeedModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedModelImplToJson(
      this,
    );
  }
}

abstract class _FeedModel implements FeedModel {
  const factory _FeedModel(
      {@HiveField(0) required final int id,
      @HiveField(1) required final String title,
      @HiveField(2) required final String body,
      @HiveField(3) required final int userId,
      @HiveField(4) final String? userName,
      @HiveField(5) final String? userEmail,
      @HiveField(6) final String? userImage,
      @HiveField(7) final String? feedImage,
      @HiveField(8) final bool? isLike,
      @HiveField(9) final List<CommentModel>? comments,
      @HiveField(10) final int? likesCount,
      @HiveField(11) final DateTime? postedDate}) = _$FeedModelImpl;

  factory _FeedModel.fromJson(Map<String, dynamic> json) =
      _$FeedModelImpl.fromJson;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  String get title;
  @override
  @HiveField(2)
  String get body;
  @override
  @HiveField(3)
  int get userId;
  @override
  @HiveField(4)
  String? get userName;
  @override
  @HiveField(5)
  String? get userEmail;
  @override
  @HiveField(6)
  String? get userImage;
  @override
  @HiveField(7)
  String? get feedImage;
  @override
  @HiveField(8)
  bool? get isLike;
  @override
  @HiveField(9)
  List<CommentModel>? get comments;
  @override
  @HiveField(10)
  int? get likesCount;
  @override
  @HiveField(11)
  DateTime? get postedDate;

  /// Create a copy of FeedModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedModelImplCopyWith<_$FeedModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
