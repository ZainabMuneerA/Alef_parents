import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/loading_widget.dart';
import '../../domain/entity/guardianType.dart';
import '../bloc/GuardianType/bloc/guardian_type_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReusableDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedValue;
  final String Function(T) displayFunction;
  final void Function(T?) onChanged;
  final String hintText;

  ReusableDropdown({
    required this.items,
    required this.selectedValue,
    required this.displayFunction,
    required this.onChanged,
    required this.hintText,
  });

  @override
  _ReusableDropdownState<T> createState() => _ReusableDropdownState<T>();
}

class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      constraints: BoxConstraints(minHeight: 58),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color.fromARGB(255, 87, 77, 205), // Set your border color here
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isDropdownOpen = !_isDropdownOpen;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectedValue != null
                        ? widget.displayFunction(widget.selectedValue!)
                        : widget.hintText,
                    style: TextStyle(
                      fontSize: 16.0,
                      
                      color: Color.fromARGB(255, 87, 77, 205),
                    ),
                  ),
                  Icon(
                    _isDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24.0,
                    color: Color.fromARGB(255, 87, 77, 205),
                  ),
                ],
              ),
            ),
          ),
          if (_isDropdownOpen)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white60,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2.0,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: widget.items.map((item) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isDropdownOpen = false;
                      });
                      widget.onChanged?.call(item);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        widget.displayFunction(item),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 87, 77, 205),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

enum Gender { male, female }
