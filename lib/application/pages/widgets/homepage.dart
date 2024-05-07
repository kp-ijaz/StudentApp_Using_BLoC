import 'dart:developer';

import 'package:blocapp/application/core/common_widgets/common_widgets.dart';
import 'package:blocapp/application/pages/posts/itemsbloc/items_bloc.dart';
import 'package:blocapp/application/pages/widgets/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsWrapper extends StatelessWidget {
  const ItemsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final itemb = context.watch<ItemsBloc>();
    return Scaffold(
      floatingActionButton: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          log("keriyo");
          if (state is ItemsStateLoaded || state is ItemsUpdated) {
            // int uniqueItemCount = itemb.updatedCart.keys.length;

            int totalCount = itemb.updatedCart.values
                .fold(0, (prev, element) => prev + element);
            return CircleAvatar(
              backgroundColor: Colors.black,
              radius: 32,
              child: GestureDetector(
                onTap: () {},
                child: Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartItemsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: Colors.amber,
                      ),
                    ),
                    if (totalCount > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                          child: Text(
                            itemb.updatedCart.keys.length.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          } else {
            log("keri");
            return CircleAvatar(
              backgroundColor: Colors.black,
              radius: 32,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.amber,
                ),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: const Text("BloC App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ItemsBloc, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsInitial) {
                    return const Text("Items are waiting to be loaded");
                  } else if (state is ItemsStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                      ),
                    );
                  } else if (state is ItemsStateLoaded ||
                      state is ItemsUpdated) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 0.6),
                      itemCount: itemb.items.length,
                      itemBuilder: (context, index) {
                        final item = itemb.items[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.category,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 101, 8, 97),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  sized,
                                  Image(
                                    image: NetworkImage(
                                      item.image,
                                    ),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  sized,
                                  Text(
                                    item.title,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                  sized,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${item.price}",
                                        style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                          onPressed: () {},
                                          icon:
                                              const Icon(Icons.favorite_border))
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // log("keriyo");

                                        BlocProvider.of<ItemsBloc>(context)
                                            .add(AddToCartEvent(item));
                                      },
                                      child: const Text('ADD CART'))
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ItemsStateError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const Center(
                    child: Text('Some error occurred'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
