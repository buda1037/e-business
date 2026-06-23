import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.grid_view_outlined),
        color: Colors.white,
        onPressed: () => {},
      ),
      title: Center(
        child: Text(
          'Welcome Back',
          style: GoogleFonts.poppins(
            fontSize: 21,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_horiz),
          color: Colors.white,
          onPressed: () => {},
        ),
      ],
    );
  }
}
