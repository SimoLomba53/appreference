import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/card/terrarium/terrarium_garden_card.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_bloc.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/local/local_terrarium_state.dart';
import 'package:growingapp/features/terrarium/presentation/pages/terrariums_catalogue.dart';

class TerrariumsGarden extends StatefulWidget {
  const TerrariumsGarden({super.key});

  @override
  State<TerrariumsGarden> createState() => _TerrariumsGardenState();
}

class _TerrariumsGardenState extends State<TerrariumsGarden> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: _buildBody(),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x881D1617),
              blurRadius: 40,
              spreadRadius: 0.0,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Color(0xff2B874B),
              Color(0xff0EAE56),
            ],
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TerrariumsCatalogue(),
              ),
            );
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const SvgIcon(
            icon: 'add',
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'My Growing Terrariums',
      ),
    );
  }

  _searchField() {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xff7B6F72).withValues(alpha: 0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.all(15),
          hintText: 'Cerca ...',
          hintStyle: const TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(12),
            child: SvgIcon(
              icon: "search",
            ),
          ),
          suffixIcon: const SizedBox(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Color(0xffDDDADA),
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: SvgIcon(
                      icon: "filter",
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<LocalTerrariumsBloc, LocalTerrariumsState>(
        builder: (_, state) {
      if (state is LocalTerrariumsLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is LocalTerrariumsDone) {
        return Column(
          children: [
            //_searchField(),
            //const SizedBox(
            //  height: 30,
            //),
            Expanded(
              child: state.terrariums!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Padding(
                        //  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        //  child: Text(
                        //    'Risultati (${state.terrariums!.length})',
                        //    style: const TextStyle(
                        //      fontSize: 18,
                        //      fontWeight: FontWeight.w600,
                        //    ),
                        //  ),
                        //),
                        Expanded(
                          child: GridView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 30,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              mainAxisExtent: 230,
                            ),
                            itemCount: state.terrariums!.length,
                            itemBuilder: (context, index) {
                              return TerrariumGardenCard(
                                  terrarium: state.terrariums![index]);
                            },
                          ),
                        ),
                      ],
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Aggiungi un terrario alla tua libreria',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            'Premi sul + e trova il tuo terrario',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF998F92),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        );
      }
      return const SizedBox();
    });
  }
}
