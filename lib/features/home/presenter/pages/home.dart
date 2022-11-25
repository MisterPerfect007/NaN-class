import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nan_class/core/failure/failures.dart';
import 'package:nan_class/core/utils/utils.dart';
import 'package:nan_class/core/widgets/loading_widget.dart';
import 'package:nan_class/ui/colors/app_colors.dart';

import '../../../../core/package/internet_connection_checker.dart';
import '../../../../core/widgets/error/error_widget.dart';
import '../../../../ui/svg_icons/svg_icons.dart';

import '../bloc/home_bloc.dart';
import '../widgets/app_bar.dart';
import '../widgets/homeWidgets/loaded_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: buildAppBar(context),
      body: HomeBody(size: size),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with AutomaticKeepAliveClientMixin<HomeBody> {
  @override
  void initState() {
    super.initState();

    callUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //
    //
    return SizedBox(
      height: widget.size.height,
      width: double.infinity,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          // print(state);
          if (state is HomeInitial || state is HomeLoading) {
            return const LoaderWidget();
          } else if (state is HomeLoaded) {
            return LoadedWidget(
              user: state.user,
            );
          } else if (state is HomeFailure) {
            if (state.errorType == UserErrorType.noInternet) {
              return CustomErrorWidget(
                icon: SvgIcons.noWifiLine,
                onPressed: () async {
                  if (!(await InternetConnection.hasConnection)) {
                    showToast("you still offline");
                  } else {
                    callUserData(context);
                  }
                },
                msg: "No internet",
              );
            } else {
              return CustomErrorWidget(
                icon: SvgIcons.badO,
                onPressed: () {
                  callUserData(context);
                },
                msg: "Something went wrong",
              );
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///Trigger the [GetUser] event
void callUserData(BuildContext context) {
  context.read<HomeBloc>().add(const GetUser("116420318969971436809"));
}
