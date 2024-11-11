import 'package:bizflow/config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
     
        BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
        BlocProvider<ClientCubit>(create: (context) => ClientCubit())

      //-------Cubits
    ], child: child);
  }
}
