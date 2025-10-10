import 'package:flutter/material.dart';
import 'package:streak/screens/home_screen.dart';
import 'package:streak/screens/search_screen.dart';


class NavScreen extends StatefulWidget {
  const NavScreen({super.key, required this.userName});
  final String userName;

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _idx = 0;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final screens = [
      HomeScreen(userName: widget.userName),
      const SearchScreen(),
      const Scaffold(body: Center(child: Text('Chat'))),
      const Scaffold(body: Center(child: Text('Profile'))),
    ];

    return Scaffold(
      body: screens[_idx],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: cs.surface,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavIcon(
                icon: Icons.home_filled,
                active: _idx == 0, 
                onTap: () => setState(() => _idx = 0)),
              _NavIcon(
                icon: Icons.search,
                active: _idx == 1,
                onTap: () => setState(() => _idx = 1)),
              const SizedBox(width: 40),
              Container(
                width: 60,
                height: 60,
                decoration : BoxDecoration(
                  color:cs.primary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:cs.primary.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0,4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed:() => setState(() => _idx=1), 
                  icon: const Icon(Icons.add,color:Colors.white, size:32))
                  ),
              
              _NavIcon(
                icon: Icons.chat_bubble_outline,
                active: _idx == 2, 
                onTap: () => setState(() => _idx = 2)),
              _NavIcon(
                icon: Icons.person_outline, 
                active: _idx == 3, 
                onTap: () => setState(() => _idx = 3)),
            ],
          ),
        ),
      ),
      
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({
    required this.icon,
    this.active = false,
    this.onTap,
  });
  final IconData icon;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: active ? cs.primary : cs.onSurfaceVariant),
      ),
    );
  }
}
