// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatState {

 List<ChatMessage> get messages;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ChatState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&const DeepCollectionEquality().equals(other.messages, _this.messages));
}


@override
int get hashCode {
  final _this = this as ChatState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.messages));
}

@override
String toString() {
  final _this = this as ChatState;
  return 'ChatState(messages: ${_this.messages})';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChatInitial value)?  initial,TResult Function( ChatLoading value)?  loading,TResult Function( ChatSuccess value)?  success,TResult Function( ChatFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that);case ChatLoading() when loading != null:
return loading(_that);case ChatSuccess() when success != null:
return success(_that);case ChatFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChatInitial value)  initial,required TResult Function( ChatLoading value)  loading,required TResult Function( ChatSuccess value)  success,required TResult Function( ChatFailure value)  failure,}){
final _that = this;
switch (_that) {
case ChatInitial():
return initial(_that);case ChatLoading():
return loading(_that);case ChatSuccess():
return success(_that);case ChatFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChatInitial value)?  initial,TResult? Function( ChatLoading value)?  loading,TResult? Function( ChatSuccess value)?  success,TResult? Function( ChatFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that);case ChatLoading() when loading != null:
return loading(_that);case ChatSuccess() when success != null:
return success(_that);case ChatFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<ChatMessage> messages)?  initial,TResult Function( List<ChatMessage> messages)?  loading,TResult Function( List<ChatMessage> messages)?  success,TResult Function( List<ChatMessage> messages,  String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that.messages);case ChatLoading() when loading != null:
return loading(_that.messages);case ChatSuccess() when success != null:
return success(_that.messages);case ChatFailure() when failure != null:
return failure(_that.messages,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<ChatMessage> messages)  initial,required TResult Function( List<ChatMessage> messages)  loading,required TResult Function( List<ChatMessage> messages)  success,required TResult Function( List<ChatMessage> messages,  String message)  failure,}) {final _that = this;
switch (_that) {
case ChatInitial():
return initial(_that.messages);case ChatLoading():
return loading(_that.messages);case ChatSuccess():
return success(_that.messages);case ChatFailure():
return failure(_that.messages,_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<ChatMessage> messages)?  initial,TResult? Function( List<ChatMessage> messages)?  loading,TResult? Function( List<ChatMessage> messages)?  success,TResult? Function( List<ChatMessage> messages,  String message)?  failure,}) {final _that = this;
switch (_that) {
case ChatInitial() when initial != null:
return initial(_that.messages);case ChatLoading() when loading != null:
return loading(_that.messages);case ChatSuccess() when success != null:
return success(_that.messages);case ChatFailure() when failure != null:
return failure(_that.messages,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ChatInitial implements ChatState {
  const ChatInitial({ List<ChatMessage> messages = const <ChatMessage>[]}): _messages = messages;
  

 final  List<ChatMessage> _messages;
@override@JsonKey() List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatInitialCopyWith<ChatInitial> get copyWith => _$ChatInitialCopyWithImpl<ChatInitial>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatInitial&&const DeepCollectionEquality().equals(other.messages, _messages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'ChatState.initial(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatInitialCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatInitialCopyWith(ChatInitial value, $Res Function(ChatInitial) _then) = _$ChatInitialCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class _$ChatInitialCopyWithImpl<$Res>
    implements $ChatInitialCopyWith<$Res> {
  _$ChatInitialCopyWithImpl(this._self, this._then);

  final ChatInitial _self;
  final $Res Function(ChatInitial) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(ChatInitial(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}


}

/// @nodoc


class ChatLoading implements ChatState {
  const ChatLoading({required  List<ChatMessage> messages}): _messages = messages;
  

 final  List<ChatMessage> _messages;
@override List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLoadingCopyWith<ChatLoading> get copyWith => _$ChatLoadingCopyWithImpl<ChatLoading>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLoading&&const DeepCollectionEquality().equals(other.messages, _messages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'ChatState.loading(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatLoadingCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatLoadingCopyWith(ChatLoading value, $Res Function(ChatLoading) _then) = _$ChatLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class _$ChatLoadingCopyWithImpl<$Res>
    implements $ChatLoadingCopyWith<$Res> {
  _$ChatLoadingCopyWithImpl(this._self, this._then);

  final ChatLoading _self;
  final $Res Function(ChatLoading) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(ChatLoading(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}


}

/// @nodoc


class ChatSuccess implements ChatState {
  const ChatSuccess({required  List<ChatMessage> messages}): _messages = messages;
  

 final  List<ChatMessage> _messages;
@override List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatSuccessCopyWith<ChatSuccess> get copyWith => _$ChatSuccessCopyWithImpl<ChatSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatSuccess&&const DeepCollectionEquality().equals(other.messages, _messages));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));
}

@override
String toString() {
    return 'ChatState.success(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatSuccessCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatSuccessCopyWith(ChatSuccess value, $Res Function(ChatSuccess) _then) = _$ChatSuccessCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages
});




}
/// @nodoc
class _$ChatSuccessCopyWithImpl<$Res>
    implements $ChatSuccessCopyWith<$Res> {
  _$ChatSuccessCopyWithImpl(this._self, this._then);

  final ChatSuccess _self;
  final $Res Function(ChatSuccess) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(ChatSuccess(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,
  ));
}


}

/// @nodoc


class ChatFailure implements ChatState {
  const ChatFailure({required  List<ChatMessage> messages, required this.message}): _messages = messages;
  

 final  List<ChatMessage> _messages;
@override List<ChatMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  String message;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFailureCopyWith<ChatFailure> get copyWith => _$ChatFailureCopyWithImpl<ChatFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFailure&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),message);
}

@override
String toString() {
    return 'ChatState.failure(messages: $messages, message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatFailureCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory $ChatFailureCopyWith(ChatFailure value, $Res Function(ChatFailure) _then) = _$ChatFailureCopyWithImpl;
@override @useResult
$Res call({
 List<ChatMessage> messages, String message
});




}
/// @nodoc
class _$ChatFailureCopyWithImpl<$Res>
    implements $ChatFailureCopyWith<$Res> {
  _$ChatFailureCopyWithImpl(this._self, this._then);

  final ChatFailure _self;
  final $Res Function(ChatFailure) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? message = null,}) {
  return _then(ChatFailure(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatMessage>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
