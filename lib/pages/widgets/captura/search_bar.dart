import 'package:dowload_page_apk/theme/theme.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    super.key,
    required this.controller,
    required this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final void Function(dynamic) onFieldSubmitted;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppTheme.of(context).primaryColor,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
            child: Icon(
              Icons.search,
              color: AppTheme.of(context).primaryColor,
              size: MediaQuery.of(context).size.width * 24 / 1920,
            ),
          ),
          SizedBox(
            width: 150,
            height: 45,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: TextFormField(
                controller: widget.controller,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Buscar',
                  hintStyle: AppTheme.of(context).hintText.override(
                        useGoogleFonts: false,
                        fontFamily: 'Gotham-Light',
                        color: AppTheme.of(context).secondaryText,
                      ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                style: AppTheme.of(context).textoSimple.override(
                      useGoogleFonts: false,
                      fontFamily: 'Gotham-Light',
                      color: AppTheme.of(context).primaryText,
                    ),
                onFieldSubmitted: widget.onFieldSubmitted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
