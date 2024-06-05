import 'package:flutter/material.dart';
import 'package:finalversion/models/package2.dart'; // Ensure this model class includes address, email, and Instagram.
import 'package:finalversion/pages/help_page.dart';
import 'package:finalversion/utils/styles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ContactCard extends StatelessWidget {
  final Package2 contact;
  const ContactCard(this.contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpPage()));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Styles.bgColor,
          borderRadius: BorderRadius.circular(15)
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.email, style: TextStyle(color: Styles.blackColor, fontWeight: FontWeight.bold, fontSize: 17)),
            Text('Email: ${contact.email}', style: TextStyle(color: Styles.blackColor, fontSize: 14)),
            Text('Address: ${contact.address}', style: TextStyle(color: Styles.blackColor, fontSize: 14)),
            Text('Number: ${contact.number}', style: TextStyle(color: Styles.blackColor, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

