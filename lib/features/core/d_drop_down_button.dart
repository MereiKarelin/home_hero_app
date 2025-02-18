import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_text_style.dart';

class DDropdownButtonWidget extends StatefulWidget {
  final List<Map<String, String>> items;
  final String? selectedValue;
  final Function(String country) onSelectCountry;
  final LayerLink layerLink;
  final String text;
  final bool readOnly;

  const DDropdownButtonWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onSelectCountry,
    required this.layerLink,
    required this.text,
    required this.readOnly,
  });

  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DDropdownButtonWidget> {
  OverlayEntry? _overlayEntry;

  void toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context)!.insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width - 20,
          child: CompositedTransformFollower(
            link: widget.layerLink,
            offset: const Offset(0, 50), // Offset the dropdown below the button
            child: Material(
              color: Colors.white, // Set the background to white
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: widget.items.map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: DColor.greyUnselectedColor, width: 0.5), // Border color
                      color: Colors.white, // White color for the dropdown
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              widget.onSelectCountry(item['value'] ?? '');
                            });
                            toggleDropdown();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                            child: SizedBox(
                              height: 15,
                              child: Row(
                                children: [
                                  // const SizedBox(width: 8),
                                  Text(
                                    item['label']!,
                                    style: DTextStyle.primaryText.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: widget.layerLink,
      child: GestureDetector(
        onTap: widget.readOnly ? () {} : toggleDropdown,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
          decoration: BoxDecoration(
            color: DColor.unselectedColor, // Цвет фона, аналогичный DCustomTextField
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: DColor.unselectedColor, // Цвет границы
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.selectedValue != null
                  ? Text(
                      widget.text,
                      style: DTextStyle.primaryText.copyWith(color: DColor.greyUnselectedColor, fontWeight: FontWeight.w700, fontSize: 11),
                    )
                  : const SizedBox(
                      height: 6,
                    ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.selectedValue != null)
                    Row(
                      children: [
                        // const SizedBox(width: 8),
                        Text(
                          widget.items.firstWhere((item) => item['value'] == widget.selectedValue)['label']!,
                          style: DTextStyle.primaryText.copyWith(fontSize: 14),
                        ),
                      ],
                    )
                  else
                    Text(
                      widget.text,
                      style: DTextStyle.primaryText.copyWith(color: DColor.greyColor, fontSize: 14),
                    ),
                  widget.readOnly ? const SizedBox() : const Icon(Icons.keyboard_arrow_down),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
