import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/stock_cubit/stock_cubit.dart';
import 'package:supreme/core/widgets/custom_text_field.dart';
import 'package:supreme/core/widgets/tires_item_widget.dart';
import '../business_logic/stock_cubit/stock_states.dart';
import '../core/services/service_locator.dart';

class TiresStockScreen extends StatelessWidget {
  const TiresStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: BlocProvider(
          create: (_) => sl<StockCubit>(),
          child: Builder(
            builder: (secondContext) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    onFieldSubmitted: (value) {
                      secondContext.read<StockCubit>().searchSize(size: value);
                    },
                    keyboardType: TextInputType.datetime,
                    hintText: 'Search Size, Brand',
                    prefixIcon: Icon(Icons.search),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<StockCubit, StockState>(
                      builder: (context, state) {
                        if (state.getTiresStatus == CubitStatus.loading)
                        {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state.getTiresStatus == CubitStatus.error) {
                          return Center(child: Text(state.message));
                        }
                        return state.tires.isEmpty
                            ? const Center(child: Text('No Tires Found'))
                            : ListView.builder(
                                itemBuilder: (context, index) {
                                  return TiresItemWidget(model: state.tires[index]);
                                },
                                itemCount: state.tires.length,
                              );
                      },
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
