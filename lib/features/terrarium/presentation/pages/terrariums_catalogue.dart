import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/card/terrarium/terrarium_catalogue_card.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_bloc.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_event.dart';
import 'package:growingapp/features/terrarium/presentation/bloc/terrarium/remote/remote_terrarium_state.dart';

class TerrariumsCatalogue extends StatefulWidget {
  const TerrariumsCatalogue({super.key});

  @override
  State<TerrariumsCatalogue> createState() => _TerrariumsCatalogueState();
}

class _TerrariumsCatalogueState extends State<TerrariumsCatalogue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: _buildBody(),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RemoteTerrariumsBloc>(context).add(const GetTerrariums());
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Aggiungi il tuo Terrario',
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgIcon(
            icon: "arrow-left",
            color: Theme.of(context).textTheme.headlineMedium!.color,
          ),
        ),
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
        onChanged: (value) {
          BlocProvider.of<RemoteTerrariumsBloc>(context)
              .add(GetTerrariums(searchText: value.isEmpty ? null : value));
        },
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
          suffixIcon: true
              ? null
              : const SizedBox(
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
    return Column(
      children: [
        _searchField(),
        const SizedBox(
          height: 30,
        ),
        Expanded(
          child: BlocBuilder<RemoteTerrariumsBloc, RemoteTerrariumsState>(
              builder: (_, state) {
            if (state is RemoteTerrariumsLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is RemoteTerrariumsError) {
              return const Center(child: Icon(Icons.refresh));
            }
            if (state is RemoteTerrariumsDone) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Risultati (${state.terrariums!.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: state.terrariums!.isNotEmpty
                          ? GridView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 30,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                mainAxisExtent: 240,
                              ),
                              itemCount: state.terrariums!.length,
                              itemBuilder: (context, index) {
                                return TerrariumCatalogueCard(
                                  terrarium: state.terrariums![index],
                                );
                              },
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    'Nessun terrario trovato',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Center(
                                  child: Text(
                                    'Prova a fare una ricerca diversa',
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
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ],
    );
  }
}
