import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: const SelectionArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Text(
            "WaterHero Terms & Conditions\n\nLast updated: July 13, 2026\n\n1. Acceptance of Terms\n\nBy downloading, installing, or using WaterHero, you agree to these Terms & Conditions. If you do not agree, do not use the application.\n\n2. Purpose of WaterHero\n\nWaterHero is an offline hydration habit tracker. It allows users to record water intake, set a daily target, review local history, and view simple statistics.\n\n3. No Medical Advice\n\nWaterHero does not provide medical advice, diagnosis, treatment, emergency services, or professional healthcare recommendations. Information shown in the app is for general wellness and personal tracking purposes only.\n\n4. Personal Hydration Decisions\n\nYou are responsible for deciding how much water to drink. Individual hydration needs can vary based on age, health, climate, medication, diet, pregnancy, activity level, and medical conditions.\n\n5. Accuracy of Entries and Statistics\n\nWaterHero calculates totals, progress, averages, and streaks from values entered by the user. Results may be inaccurate if entries, device dates, goals, or settings are incorrect.\n\n6. Offline Local Storage\n\nWaterHero stores app information locally on your device. It does not currently provide cloud accounts, automatic synchronization, or remote backups.\n\n7. Risk of Data Loss\n\nData may be lost if you uninstall the application, clear its storage, reset or replace your device, lose access to the device, or experience storage failure.\n\n8. User Responsibility\n\nYou are responsible for using WaterHero safely, entering information accurately, protecting your device, and seeking professional medical advice when appropriate.\n\n9. Application Availability\n\nWaterHero is provided on an \"as is\" and \"as available\" basis. We do not guarantee uninterrupted operation, compatibility with every device, or freedom from errors.\n\n10. Updates and Changes\n\nThe app may receive updates, design changes, bug fixes, new features, or removed features. Continued use after an update means you accept the revised terms.\n\n11. Intellectual Property\n\nThe WaterHero name, logo, interface, text, graphics, source code, and original content are protected by applicable intellectual property laws.\n\n12. Prohibited Use\n\nYou may not misuse, unlawfully redistribute, sell, sublicense, impersonate, damage, interfere with, or create unauthorized copies of the application.\n\n13. Limitation of Liability\n\nTo the maximum extent permitted by law, the developer is not responsible for health decisions, excessive or insufficient fluid intake, medical outcomes, data loss, device issues, or indirect losses resulting from use of WaterHero.\n\n14. Third-Party Platforms\n\nWaterHero may be distributed through platforms such as Google Play. Your use of those services may also be governed by their own terms and policies.\n\n15. Privacy\n\nUse of WaterHero is also governed by the WaterHero Privacy Policy.\n\n16. Changes to These Terms\n\nThese terms may be updated when the application, distribution method, or legal requirements change.\n\n17. Severability\n\nIf any part of these terms is found invalid or unenforceable, the remaining sections will continue to apply.\n\n18. Contact\n\nFor questions about these terms, contact:\n\nmhasnainbilal631h@gmail.com",
            style: TextStyle(fontSize: 16, height: 1.65),
          ),
        ),
      ),
    );
  }
}
