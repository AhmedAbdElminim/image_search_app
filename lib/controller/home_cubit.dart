import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialStates());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<dynamic> result = [];
  Future getImages({required String imageName}) async {
    emit(GetImageLoadingStates());
    result = [];
    Dio dio = Dio();

    await dio
        .get('https://imsea.herokuapp.com/api/1?q=$imageName')
        .then((value) {
      result = value.data['results'].toSet().toList();

      emit(GetImageSuccessStates());
    }).catchError((error) {
      print('the error is ${error.toString()}');
      emit(GetImageErrorStates(error.toString()));
    });
  }
}
