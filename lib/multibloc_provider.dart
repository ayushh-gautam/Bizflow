import 'package:bizflow/config/themes/cubit/theme_cubit.dart';
import 'package:bizflow/features/authentication/domain/repository/auth_repository.dart';
import 'package:bizflow/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:bizflow/features/clients/data/repository/add_client_repo.dart';
import 'package:bizflow/features/clients/presentation/cubit/client_cubit.dart';

import 'package:bizflow/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MultiBlocProviderClass extends StatelessWidget {
  final Widget child;
  const MultiBlocProviderClass(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
      BlocProvider<AuthCubit>(create: (context) => AuthCubit(AuthRepository())),

      BlocProvider<InvoiceCubit>(create: (context) => InvoiceCubit()),
      BlocProvider<ClientCubit>(
          create: (context) => ClientCubit(ClientRepository())),
      //-------Cubits
    ], child: child);
  }
}
