import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supreme/business_logic/stock_cubit/stock_cubit.dart';
import 'package:supreme/core/widgets/custom_text_field.dart';
import 'package:supreme/core/widgets/tires_item_widget.dart';
import '../../business_logic/stock_cubit/stock_states.dart';
import '../../core/services/service_locator.dart';

class TiresStockScreen extends StatelessWidget {
  const TiresStockScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: BlocProvider.value(
          value: sl<StockCubit>(),
          child: Builder(
            builder: (secondContext) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 20,
                          offset: const Offset(0, -4),
                        ),
                      ]
                    ),
                    child: CustomTextField(
                      fillColor: Colors.transparent,
                      onFieldSubmitted: (value) {
                        secondContext.read<StockCubit>().searchSize(size: value);
                      },
                      keyboardType: TextInputType.datetime,
                      hintText: 'Search Size, Brand',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: BlocBuilder<StockCubit, StockState>(
                      builder: (context, state) {

                        if(state.getTiresStatus == CubitStatus.initial)
                          {
                            return const InitialSearchState();
                          }
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


class InitialSearchState extends StatelessWidget {
  const InitialSearchState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'Ready to roll?',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter a tire size above to start searching.',
            style: TextStyle(color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}