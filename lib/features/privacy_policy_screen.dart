import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SelectionArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Text(
            "WaterHero Privacy Policy\n\nLast updated: July 13, 2026\n\n1. Overview\n\nWaterHero is an offline hydration tracking application. It helps users record daily water intake, monitor progress toward a personal goal, review recent history, and view simple hydration statistics.\n\n2. Information Stored on Your Device\n\nWaterHero stores only the information needed for the app to work, including daily water amounts, entry times, daily goals, default cup size, theme preference, streak calculations, and onboarding status.\n\n3. Local Storage\n\nAll application data is stored locally on your device using SharedPreferences or equivalent on-device storage. WaterHero does not operate a backend server and does not upload your hydration history to us.\n\n4. No Personal Data Collection\n\nWaterHero does not ask for or collect your name, phone number, email address, home address, account credentials, payment details, precise location, contacts, photos, microphone recordings, or health records from other services.\n\n5. No Analytics, Advertising, or Tracking\n\nWaterHero does not use Firebase, analytics SDKs, advertising SDKs, tracking technologies, personalized advertising, advertising identifiers, or third-party login providers.\n\n6. Internet Access\n\nThe main features of WaterHero work fully offline. No internet connection is required to add water entries, view progress, review history, view statistics, or change settings.\n\n7. Health-Related Information\n\nWater intake values entered into the app may be considered health-related information. This information remains stored locally on your device and is not transmitted to us.\n\n8. Data Sharing\n\nWaterHero does not sell, rent, trade, or share your locally stored information with advertisers, data brokers, analytics companies, or other third parties.\n\n9. Device Permissions\n\nWaterHero does not require access to your camera, microphone, contacts, messages, call history, precise location, or personal media files for its main features.\n\n10. Data Security\n\nYour information remains inside your device's application storage. You are responsible for protecting your device using available security options.\n\n11. Data Deletion\n\nYou can delete individual entries, reset today's data, or clear all application data from within WaterHero. Uninstalling the app or clearing its storage may permanently remove all saved information.\n\n12. Data Backup and Recovery\n\nWaterHero does not currently provide cloud backup, account synchronization, or remote recovery. Lost or deleted local data may not be recoverable.\n\n13. Children's Privacy\n\nWaterHero does not knowingly collect personal information from children or adults because the app does not request or transmit personal user information.\n\n14. Medical Disclaimer\n\nWaterHero is a habit-tracking and general wellness tool. It does not provide medical advice, diagnosis, treatment, or personalized hydration recommendations. Consult a qualified healthcare professional if you have questions about hydration, fluid restrictions, pregnancy, medication, kidney conditions, heart conditions, or other health concerns.\n\n15. Changes to This Policy\n\nThis Privacy Policy may be updated if WaterHero's features, data practices, or legal requirements change. The latest version will display a revised update date.\n\n16. Contact\n\nFor privacy questions, contact:\n\nmhasnainbilal631h@gmail.com",
            style: TextStyle(fontSize: 16, height: 1.65),
          ),
        ),
      ),
    );
  }
}
