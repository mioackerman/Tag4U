import 'package:flutter/material.dart';
import 'package:tag4u/domain/entities/person_node.dart';

class PersonCard extends StatelessWidget {
  final PersonNode person;
  final VoidCallback onTap;

  const PersonCard({super.key, required this.person, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = avatarColor(person.name);

    return Material(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color,
                child: Text(
                  person.name.isNotEmpty ? person.name[0] : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                person.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color avatarColor(String name) {
  const palette = [
    Color(0xFF5B6FFF),
    Color(0xFF9C4FFF),
    Color(0xFF00A896),
    Color(0xFFFF6B35),
    Color(0xFFE83F6F),
    Color(0xFF2EC4B6),
    Color(0xFF3D405B),
    Color(0xFFFF9F1C),
  ];
  if (name.isEmpty) return palette[0];
  return palette[name.codeUnitAt(0) % palette.length];
}
