import 'package:blocapp/application/pages/posts/itemsbloc/items_bloc.dart';
import 'package:blocapp/domain/entities/post_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemsScreen extends StatelessWidget {
  const CartItemsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemb = context.watch<ItemsBloc>();
    final Map<ItemsEntity, int> cartItems = itemb.updatedCart;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("No Items Are In The Cart"))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems.keys.elementAt(index);
                final quantity = cartItems[item];
                return ListTile(
                  leading:
                      CircleAvatar(backgroundImage: NetworkImage(item.image)),
                  title: Text(
                    item.title,
                    maxLines: 2,
                  ),
                  subtitle: Row(
                    children: [
                      const Text('Quantity: '),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<ItemsBloc>(context)
                              .add(RemoveFromCartEvent(item));
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      BlocBuilder<ItemsBloc, ItemsState>(
                        builder: (context, state) {
                          return Text('$quantity');
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<ItemsBloc>(context)
                              .add(AddToCartEvent(item));
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
