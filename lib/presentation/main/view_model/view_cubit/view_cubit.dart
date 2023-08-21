import 'package:attendance/app/dit.dart';
import 'package:attendance/domain/model/property_model.dart';
import 'package:attendance/domain/useCase/property_useCase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_state.dart';

class ViewCubit extends Cubit<ViewState>
     {
  ViewCubit() : super(ViewStateInitial());

  final PropertyUseCase _propertyUseCase = instance<PropertyUseCase>();


 


  getData() async {

  }
}


