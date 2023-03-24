part of 'filter_cubit.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class GetFilterHotelsSuccessState extends FilterState {
  final Hotels filterResult;

  GetFilterHotelsSuccessState(this.filterResult);
}

class GetFilterHotelsLoadingState extends FilterState {}

class GetFilterHotelsFailureState extends FilterState {
  final String? errorMessage;

  GetFilterHotelsFailureState([this.errorMessage]);
}

class GetFacilitiesSuccessState extends FilterState {}

class GetFacilitiesLoadingState extends FilterState {}

class GetFacilitiesFailureState extends FilterState {
  final String? errorMessage;

  GetFacilitiesFailureState([this.errorMessage]);
}

class PickNewLocationState extends FilterState {}
