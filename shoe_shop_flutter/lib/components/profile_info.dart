import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String name;

  const ProfileInfo({super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 35,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(width: 20),
              Text(
                name,
                style: const TextStyle(fontSize: 17),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Colors.black12),
        ],
      ),
    );
  }
}