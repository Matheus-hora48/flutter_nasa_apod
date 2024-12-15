import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nasa_apod/src/features/apod/presentation/widgets/apod_item.dart';

import 'bloc/apod/apod_bloc.dart';
import 'widgets/custom_erro_widget.dart';
import 'widgets/loading_indicator.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nasa APOD'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: BlocBuilder<ApodBloc, ApodState>(
        builder: (context, state) {
          if (state is ApodLoading) {
            return const LoadingIndicator();
          } else if (state is ApodError) {
            return CustomErroWidget(
              message: state.message,
            );
          } else if (state is ApodLoaded) {
            return ApodItem(apod: state.apod);
          }
          return const Center(
            child: Text('Selecione uma data para visualizar.'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bloc = context.read<ApodBloc>();

          final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );

          if (date != null) {
            bloc.add(GetApodEvent(date: date));
          }
        },
        child: const Icon(Icons.calendar_today),
      ),
    );
  }
}
