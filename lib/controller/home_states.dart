abstract class HomeStates{}
class HomeInitialStates extends HomeStates{}
class GetImageLoadingStates extends HomeStates{}
class GetImageSuccessStates extends HomeStates{}
class GetImageErrorStates extends HomeStates{
  final String error;
  GetImageErrorStates(this.error);
}