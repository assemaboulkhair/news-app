//TODO: version 1
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import '../../../../core/localization/app_localizations.dart';
// import '../../../../core/theme/app_settings_controller.dart';
//
// class AppDrawer extends StatelessWidget {
//   final VoidCallback? onGoHome;
//
//   const AppDrawer({super.key, this.onGoHome});
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context);
//     final settings = context.watch<AppSettingsController>();
//
//     return Drawer(
//       width: 300,
//       backgroundColor: const Color(0xFF0B132B),
//       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
//       child: Column(
//         children: [
//           // 1. الهيدر المطور احترافياً
//           Container(
//             height: 220,
//             width: double.infinity,
//             clipBehavior: Clip.antiAlias,
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color(0xFF1E2A47),
//                   Color(0xFF0B132B),
//                 ],
//               ),
//             ),
//             child: Stack(
//               children: [
//                 // خلفية الـ Lottie Animation
//                 Positioned.fill(
//                   child: Opacity(
//                     opacity: 0.4,
//                     child: Lottie.asset(
//                       'assets/json/lumen.json',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 // تدرج زجاجي سفلي لإبراز الكلام
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           const Color(0xFF0B132B).withOpacity(0.85),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // النصوص والزخرفة الاحترافية
//                 Padding(
//                   padding: const EdgeInsets.all(24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // اسم التطبيق بتدرج لوني وخط Poppins واضح جداً
//                       ShaderMask(
//                         shaderCallback: (bounds) => const LinearGradient(
//                           colors: [Colors.white, Color(0xFF70A6FF)],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ).createShader(bounds),
//                         child: Text(
//                           'Lumen',
//                           style: GoogleFonts.poppins(
//                             color: Colors.white,
//                             fontSize: 24, // الحجم المعدل
//                             fontWeight: FontWeight.w800,
//                             letterSpacing: 1.2,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       // الـ Slogan جوه Kapsule زجاجي بخط Inter
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.12),
//                           ),
//                         ),
//                         child: Text(
//                           'Stay informed, stay ahead',
//                           style: GoogleFonts.inter(
//                             color: Colors.white.withOpacity(0.85),
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500,
//                             letterSpacing: 0.3,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // 2. المحتوى والتصاميم الحديثة (Segmented Toggles)
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // زر الذهاب للرئيسية
//                   _GlassmorphicAction(
//                     icon: Icons.home_outlined,
//                     title: l10n.goToHome,
//                     onTap: () {
//                       Navigator.pop(context);
//                       onGoHome?.call();
//                     },
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // قسم الـ Theme
//                   Text(
//                     l10n.theme,
//                     style: GoogleFonts.inter(
//                         color: Colors.white.withOpacity(0.6),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 10),
//                   _SegmentedSelector<ThemeMode>(
//                     selectedValue: settings.themeMode,
//                     items: [
//                       _SelectorItem(
//                         value: ThemeMode.dark,
//                         label: l10n.dark,
//                         icon: Icons.dark_mode_outlined,
//                       ),
//                       _SelectorItem(
//                         value: ThemeMode.light,
//                         label: l10n.light,
//                         icon: Icons.light_mode_outlined,
//                       ),
//                     ],
//                     onSelected: (value) async {
//                       await settings.setTheme(value);
//                     },
//                   ),
//
//                   const SizedBox(height: 24),
//
//                   // قسم الـ Language
//                   Text(
//                     l10n.language,
//                     style: GoogleFonts.inter(
//                         color: Colors.white.withOpacity(0.6),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 10),
//                   _SegmentedSelector<Locale>(
//                     selectedValue: settings.locale,
//                     items: [
//                       _SelectorItem(
//                         value: const Locale('en'),
//                         label: l10n.english,
//                         icon: Icons.language,
//                       ),
//                       _SelectorItem(
//                         value: const Locale('ar'),
//                         label: l10n.arabic,
//                         icon: Icons.language,
//                       ),
//                     ],
//                     onSelected: (value) async {
//                       await settings.setLocale(value);
//                       if (context.mounted) Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _GlassmorphicAction extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//
//   const _GlassmorphicAction(
//       {required this.icon, required this.title, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: const Color(0xFF162238).withOpacity(0.7),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.08)),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           child: Row(
//             children: [
//               Icon(icon, color: const Color(0xFF8EA4D6), size: 22),
//               const SizedBox(width: 14),
//               Text(
//                 title,
//                 style: GoogleFonts.inter(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _SelectorItem<T> {
//   final T value;
//   final String label;
//   final IconData icon;
//
//   _SelectorItem(
//       {required this.value, required this.label, required this.icon});
// }
//
// class _SegmentedSelector<T> extends StatelessWidget {
//   final T selectedValue;
//   final List<_SelectorItem<T>> items;
//   final ValueChanged<T> onSelected;
//
//   const _SegmentedSelector({
//     required this.selectedValue,
//     required this.items,
//     required this.onSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: const Color(0xFF162238).withOpacity(0.7),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.white.withOpacity(0.08)),
//       ),
//       child: Row(
//         children: items.map((item) {
//           final isSelected = item.value == selectedValue;
//           return Expanded(
//             child: GestureDetector(
//               onTap: () => onSelected(item.value),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? const Color(0xFF3A86EF).withOpacity(0.25)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(12),
//                   border: isSelected
//                       ? Border.all(color: const Color(0xFF3A86EF).withOpacity(0.5))
//                       : null,
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       item.icon,
//                       size: 18,
//                       color: isSelected
//                           ? Colors.white
//                           : Colors.white.withOpacity(0.5),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       item.label,
//                       style: GoogleFonts.inter(
//                         color: isSelected
//                             ? Colors.white
//                             : Colors.white.withOpacity(0.6),
//                         fontWeight:
//                         isSelected ? FontWeight.w600 : FontWeight.normal,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
//
//
//
//




//TODO: Version 2


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_settings_controller.dart';

class AppDrawer extends StatelessWidget {
  final VoidCallback? onGoHome;

  const AppDrawer({super.key, this.onGoHome});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final settings = context.watch<AppSettingsController>();

    return Drawer(
      width: 300,
      backgroundColor: const Color(0xFF0B132B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          // 1. الهيدر بالتدرج الرمادي اللؤلؤي الفاخر والهادئ لكلمة Lumen
          Container(
            height: 220,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF162544),
                  Color(0xFF0F1B38),
                ],
              ),
            ),
            child: Stack(
              children: [
                // خلفية الـ Lottie Animation
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.75,
                    child: Lottie.asset(
                      'assets/json/lumen.json',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // تدرج زجاجي سفلي ناعم
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          const Color(0xFF0B132B).withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
                // النصوص
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // اسم التطبيق بالتدرج الرمادي اللؤلؤي (Warm Silver / Pearl Platinum)
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color(0xFFFFFFFF), // أبيض ناصع
                            Color(0xFFE5E7EB), // رمادي لؤلؤي فاتح
                            Color(0xFF9CA3AF), // فضي هادئ
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Lumen',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      // الجملة التوضيحية بنقطة إشارة لؤلؤية متناسقة
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD1D5DB), // لون لؤلؤي هادئ
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Stay informed, stay ahead',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 2. المحتوى والخيارات
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _GlassmorphicAction(
                    icon: Icons.home_outlined,
                    title: l10n.goToHome,
                    onTap: () {
                      Navigator.pop(context);
                      onGoHome?.call();
                    },
                  ),

                  const SizedBox(height: 24),

                  Text(
                    l10n.theme,
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  _SegmentedSelector<ThemeMode>(
                    selectedValue: settings.themeMode,
                    items: [
                      _SelectorItem(
                        value: ThemeMode.dark,
                        label: l10n.dark,
                        icon: Icons.dark_mode_outlined,
                      ),
                      _SelectorItem(
                        value: ThemeMode.light,
                        label: l10n.light,
                        icon: Icons.light_mode_outlined,
                      ),
                    ],
                    onSelected: (value) async {
                      await settings.setTheme(value);
                    },
                  ),

                  const SizedBox(height: 24),

                  Text(
                    l10n.language,
                    style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  _SegmentedSelector<Locale>(
                    selectedValue: settings.locale,
                    items: [
                      _SelectorItem(
                        value: const Locale('en'),
                        label: l10n.english,
                        icon: Icons.language,
                      ),
                      _SelectorItem(
                        value: const Locale('ar'),
                        label: l10n.arabic,
                        icon: Icons.language,
                      ),
                    ],
                    onSelected: (value) async {
                      await settings.setLocale(value);
                      if (context.mounted) Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassmorphicAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _GlassmorphicAction(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF162238).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF8EA4D6), size: 22),
              const SizedBox(width: 14),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectorItem<T> {
  final T value;
  final String label;
  final IconData icon;

  _SelectorItem(
      {required this.value, required this.label, required this.icon});
}

class _SegmentedSelector<T> extends StatelessWidget {
  final T selectedValue;
  final List<_SelectorItem<T>> items;
  final ValueChanged<T> onSelected;

  const _SegmentedSelector({
    required this.selectedValue,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF162238).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = item.value == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(item.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3A86EF).withOpacity(0.25)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: const Color(0xFF3A86EF).withOpacity(0.5))
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      size: 18,
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? Colors.white
                            : Colors.white.withOpacity(0.6),
                        fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}