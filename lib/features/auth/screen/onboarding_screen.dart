import 'package:etutor/features/auth/screen/phone_number_auth.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<_OnboardingItem> _items = [
    _OnboardingItem(
      image: 'assets/images/astrokid1.png',
      title: 'Video Tutorials',
      subtitle: 'Learn from expert instructors with engaging video lessons.',
    ),
    _OnboardingItem(
      image: 'assets/images/astrokid2.png',
      title: 'PDF Materials',
      subtitle: 'Access comprehensive study materials and notes in PDF format.',
    ),
    _OnboardingItem(
      image: 'assets/images/astrokid3.png',
      title: 'Practice Tests',
      subtitle: 'Test your knowledge with interactive practice exams.',
    ),
    _OnboardingItem(
      image: 'assets/images/astrokid4.png',
      title: 'Olympiads & Competitions',
      subtitle: 'Participate in multiple olympiads and boost your skills.',
    ),
    _OnboardingItem(
      image: 'assets/images/astrokid5.png',
      title: 'AI Doubt Clearing',
      subtitle:
          'Get instant answers to your questions with AI-powered support.',
    ),
    _OnboardingItem(
      image: 'assets/images/astrokid6.png',
      title: 'Performance Index',
      subtitle: 'Track your progress and see your performance grow over time.',
    ),
  ];

  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _next() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 350), curve: Curves.ease);
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 350), curve: Curves.ease);
    }
  }

  void _skip() {
    // TODO: Navigate to main app or login screen

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PhoneNumberAuth()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skip,
                  child: const Text('Skip', style: TextStyle(fontSize: 16)),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _items.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          item.image,
                          height: media.size.height * 0.25,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          item.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          item.subtitle,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_items.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.blueAccent
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _currentIndex > 0 ? _previous : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Previous'),
                  ),
                  ElevatedButton(
                    onPressed:
                        _currentIndex < _items.length - 1 ? _next : _skip,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                        _currentIndex < _items.length - 1 ? 'Next' : 'Finish'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String image;
  final String title;
  final String subtitle;
  const _OnboardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
