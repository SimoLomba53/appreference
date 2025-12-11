import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growingapp/components/card/card.dart';
import 'package:growingapp/components/icons/svg_icon.dart';
import 'package:growingapp/components/img/firebase/firebase_img.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_bloc.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_event.dart';
import 'package:growingapp/features/guide/presentation/bloc/guide/remote/remote_guide_state.dart';
import 'package:growingapp/features/guide/presentation/pages/detail/guide_detail.dart';
import 'package:growingapp/features/terrarium/domain/entities/terrarium.dart';

class GuideList extends StatefulWidget {
  final TerrariumEntity? terrarium;
  const GuideList({super.key, this.terrarium});

  @override
  State<GuideList> createState() => _GuideListState();
}

class _GuideListState extends State<GuideList> {
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

    BlocProvider.of<RemoteGuidesBloc>(context)
        .add(GetGuides(terrarium: widget.terrarium));
  }

  AppBar appbar() {
    return AppBar(
      title: const Text(
        'Guide',
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
          BlocProvider.of<RemoteGuidesBloc>(context).add(
            GetGuides(
              searchText: value.isEmpty ? null : value,
              terrarium: widget.terrarium,
            ),
          );
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
          child: BlocBuilder<RemoteGuidesBloc, RemoteGuidesState>(
              builder: (_, state) {
            if (state is RemoteGuidesLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is RemoteGuidesError) {
              return const Center(child: Icon(Icons.refresh));
            }
            if (state is RemoteGuidesDone) {
              return Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Risultati (${state.guides!.length})',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
                        itemCount: state.guides!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        GuideDetail(guide: state.guides![index]),
                                  ),
                                );
                              },
                              child: CardCustom(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      clipBehavior: Clip.hardEdge,
                                      child: SizedBox(
                                        width: 120,
                                        height: 120,
                                        child: FirebaseImg(
                                          path: 'images/guides',
                                          image: state.guides![index].imgUrl!,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.guides![index].title!,
                                            textAlign: TextAlign.start,
                                            maxLines: 1,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            state.guides![index].description!,
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Color(0xFF998F92),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
