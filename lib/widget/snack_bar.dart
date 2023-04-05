import 'package:flutter/material.dart';

snackBarWidget({required ctx, required title, required Color clr}) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      duration: const Duration(seconds: 1),
      width: 350,
      backgroundColor: clr,
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
