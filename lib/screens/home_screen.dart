import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_search/screens/view_image.dart';

import '../controller/home_cubit.dart';
import '../controller/home_states.dart';
import '../shared/component.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Search Image'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: searchController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Image Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          cubit.getImages(imageName: searchController.text);
                        },
                        child: const Text('Search'),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  state is GetImageLoadingStates
                      ? const Center(child: CircularProgressIndicator())
                      : cubit.result.isEmpty
                          ? const Center(child: Text('NO Images'))
                          : Flexible(
                              child: GridView.builder(
                                itemCount: cubit.result.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 4.0,
                                        mainAxisSpacing: 4.0),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ImageViewScreen(
                                                        cubit.result[index])));
                                      },
                                      child: Hero(
                                          tag: cubit.result[index],
                                          child: defaultCachedNetworkImage(
                                              imageUrl: cubit.result[index])));
                                },
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
