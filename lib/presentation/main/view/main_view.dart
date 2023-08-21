import 'package:attendance/domain/model/property_model.dart';
import 'package:attendance/presentation/resources/font_manager.dart';
import 'package:attendance/presentation/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/color_manager.dart';
import '../../resources/manager_values.dart';
import '../view_model/view_cubit/view_cubit.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late ViewCubit _homeViewModel;

  String appBarTitle = 'Room';

  var searchController = TextEditingController();
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: !isDataLoaded
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: AppSize.s0,
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: AppSize.s0,
              centerTitle: true,
              title: Text(appBarTitle,
                  style: getMediumStyle(
                      color: ColorManager.textHeaderColor,
                      fontSize: FontSize.s18)),
              leading: Icon(Icons.arrow_back,
                  color: ColorManager.primary, size: AppSize.s35),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: AppSize.s18),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu,
                        color: ColorManager.primary,
                        size: AppSize.s35,
                      )),
                )
              ],
            ),
      bottomSheet: !isDataLoaded
          ? const SizedBox()
          : SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Reserve',
                      style: getRegularStyle(color: ColorManager.textColor),
                    )),
              ),
            ),
      body: BlocProvider<ViewCubit>(
        create: (context) {
          _homeViewModel = ViewCubit();

          _homeViewModel.getData();
          return _homeViewModel;
        },
        child: BlocConsumer<ViewCubit, ViewState>(
          listener: (context, state) {
            if (state is ViewStateSuccess) {
              getAppBarTitle(state.data.title);
            }
          },
          builder: (context, state) {
            return _getContentWidget(null);
          },
        ),
      ),
    );
  }

  void getAppBarTitle(String title) {
    setState(() {
      appBarTitle = title;
      isDataLoaded = true;
    });
  }

  Widget _getContentWidget(PropertyData? propertyData) {
    if (propertyData == null) {
      return Container();
    } else {
      return SizedBox();
    }
  }
}
