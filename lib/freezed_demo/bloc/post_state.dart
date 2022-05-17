part of 'post_bloc.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = Initial;

  const factory PostState.loading() = Loading;

  const factory PostState.loaded({
    required List<Post> list,
  }) = Loaded;
}
