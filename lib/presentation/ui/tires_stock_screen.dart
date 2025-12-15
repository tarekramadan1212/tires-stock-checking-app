import 'package:flutter/material.dart';
import 'package:supreme/core/widgets/tires_item_widget.dart';

import '../../core/utilities/demo_data.dart';

class TiresStockScreen extends StatelessWidget {
  const TiresStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Center(
      child:  Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Size, Brand',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],

              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(itemBuilder: (context, index){
                return stockItem[index];
              },
                itemCount: stockItem.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
