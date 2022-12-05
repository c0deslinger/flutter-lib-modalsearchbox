library modal_searchbox;

// ignore_for_file: library_private_types_in_public_api, no_logic_in_create_state, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModalSearchbox extends StatefulWidget {
  const ModalSearchbox(
      {Key? key,
      required this.label,
      required this.onChanged,
      this.isMultipleSelect = false,
      this.selectedValue,
      this.selectedMutipleValue = const [],
      this.showLabel = true,
      this.addSearch = true,
      this.borderRadius,
      this.padding,
      this.labelTextstyle,
      this.decoration,
      this.contentPadding,
      this.modalShape,
      this.modalBackgroundColor,
      this.searchInputDecoration,
      this.selectedItemBackgroundColor,
      this.selectedItemColor = const Color.fromARGB(255, 226, 236, 255),
      required this.list})
      : super(key: key);

  final bool showLabel;
  final bool addSearch;
  final bool isMultipleSelect;
  final String label;
  final TextStyle? labelTextstyle;
  final Decoration? decoration;
  final EdgeInsetsGeometry? contentPadding;
  final Function(dynamic value) onChanged;
  final List<dynamic> list;
  final String? selectedValue;
  final List<String> selectedMutipleValue;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final ShapeBorder? modalShape;
  final Color? modalBackgroundColor;
  final Color? selectedItemColor;
  final Color? selectedItemBackgroundColor;
  final InputDecoration? searchInputDecoration;

  @override
  _ModalSearchboxState createState() => _ModalSearchboxState(
      selectedMutipleValue: selectedMutipleValue, selectedValue: selectedValue);
}

class _ModalSearchboxState extends State<ModalSearchbox> {
  List<dynamic> listData = [];
  String? selectedValue;
  List<String> selectedMutipleValue = [];

  _ModalSearchboxState(
      {required List<String> selectedMutipleValue, this.selectedValue}) {
    this.selectedMutipleValue.addAll(selectedMutipleValue);
  }

  void _showList(String title, List<dynamic> data, BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: widget.modalShape ??
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(15.0)),
            ),
        backgroundColor: widget.modalBackgroundColor ?? const Color(0xFFF5F7FB),
        builder: (bottomSheetContext) {
          return _SearchItem(
            isMultipleSelect: widget.isMultipleSelect,
            multipleSelectedValue: selectedMutipleValue,
            title: title,
            data: data,
            selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
            useSearch: widget.addSearch,
            selectedValue: selectedValue,
            onSelected: (v, isAlreadySelected) {
              if (widget.isMultipleSelect) {
                setState(() {
                  if (isAlreadySelected) {
                    selectedMutipleValue.remove(v);
                  } else {
                    selectedMutipleValue.add(v);
                  }
                  widget.onChanged(selectedMutipleValue);
                });
              } else {
                setState(() {
                  selectedValue = v;
                });
                widget.onChanged(v);
              }
            },
            searchInputDecoration: widget.searchInputDecoration,
          );
        });
  }

  @override
  void initState() {
    listData = widget.list;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          !widget.showLabel
              ? Container()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.label,
                      style: widget.labelTextstyle ??
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
          InkWell(
              onTap: () {
                _showList(widget.label, listData, context);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: widget.decoration ??
                      BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              widget.borderRadius ?? BorderRadius.circular(8),
                          border: Border.all(
                              color: const Color.fromARGB(255, 226, 229, 235))),
                  child: Container(
                    margin: widget.contentPadding,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: widget.isMultipleSelect
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: selectedMutipleValue.map((e) {
                                      var index =
                                          selectedMutipleValue.indexOf(e);
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(.2),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        margin: EdgeInsets.only(
                                            right: 8,
                                            bottom: (index <
                                                    (selectedMutipleValue
                                                            .length -
                                                        1))
                                                ? 10
                                                : 0),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(e,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      height: 1.4,
                                                      color: Colors.black)),
                                            ),
                                            GestureDetector(
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey
                                                          .withOpacity(.5)),
                                                  child: const Center(
                                                      child: Icon(
                                                          Icons.close_rounded,
                                                          size: 15)),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    selectedMutipleValue
                                                        .remove(e);
                                                    widget.onChanged(
                                                        selectedMutipleValue);
                                                  });
                                                })
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  )
                                : Text(selectedValue ?? "",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, height: 1.4)),
                          ),
                          GestureDetector(
                              onTap: () {
                                _showList(widget.label, listData, context);
                              },
                              child:
                                  const Icon(Icons.arrow_drop_down, size: 15))
                        ]),
                  ),
                ),
              )),
          //
        ],
      ),
    );
  }
}

class _SearchItem extends StatefulWidget {
  String title;
  List<dynamic> data;
  final String? selectedValue;
  List<String> multipleSelectedValue;
  Function onSelected;
  bool useSearch;
  bool isMultipleSelect;
  InputDecoration? searchInputDecoration;
  Color? selectedItemBackgroundColor;

  _SearchItem(
      {required this.title,
      this.multipleSelectedValue = const [],
      this.isMultipleSelect = false,
      required this.data,
      this.searchInputDecoration,
      this.selectedItemBackgroundColor,
      required this.useSearch,
      required this.selectedValue,
      required this.onSelected});

  @override
  State<_SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<_SearchItem> {
  List<dynamic> filteredData = [];

  @override
  void initState() {
    filteredData.clear();
    filteredData.addAll(widget.data);
    super.initState();
  }

  void search(String keyword) {
    var filtered = [];
    for (var data in widget.data) {
      if (data.toString().toLowerCase().contains(keyword.toLowerCase())) {
        filtered.add(data);
      }
    }
    setState(() {
      filteredData = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
            minHeight: widget.useSearch ? 50 : 30,
            maxHeight: filteredData.length < 10
                ? ((widget.useSearch ? 200 : 100) + (filteredData.length * 40))
                : 400),
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            !widget.useSearch
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      onChanged: (value) async {
                        search(value);
                      },
                      decoration: widget.searchInputDecoration ??
                          InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade300,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 12)),
                    ),
                  ),
            Expanded(
                child: ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      var isAlreadySelected = widget.isMultipleSelect
                          ? widget.multipleSelectedValue
                              .contains(filteredData[index])
                          : widget.selectedValue == filteredData[index];
                      return InkWell(
                          onTap: () {
                            widget.onSelected(
                                filteredData[index], isAlreadySelected);
                            Navigator.pop(context);
                          },
                          child: Container(
                            color: isAlreadySelected
                                ? widget.selectedItemBackgroundColor
                                : Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: Text(filteredData[index],
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      height: 1.4,
                                      fontWeight: isAlreadySelected
                                          ? FontWeight.bold
                                          : FontWeight.w500)),
                            ),
                          ));
                    }))
          ],
        ),
      ),
    );
  }
}
