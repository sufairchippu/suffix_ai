import 'package:clean_architutre_learn/core/constants/models/models.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
import 'package:flutter/cupertino.dart';

class CoreConstants {
  static const List<String> infoTexts = [
    "Let’s get started — choose your question paper type below.",
    "Pick a paper type to begin creating your question set.",
    "Select how your question paper should look — MCQs, one-word, or custom.",
    "Start by selecting your preferred question paper format below.",
    "Customize your paper the way you want — easy, quick, and smart.",
    "Choose your paper style and we’ll handle the rest.",
    "Ready to create? Select your paper type to begin.",
    "Design your own question paper in just a few taps.",
    "Pick a format that best fits your exam style.",
    "Select your paper type and move to the next step.",
  ];
  static List<NanoSelectionModels> listofnanBananaSelction = [
    NanoSelectionModels(
      title: 'Glow Up',
      description:
          'Transform your look with a refreshing new style that radiates confidence.',
      cardColor: AppColors.dynamicColor1, // Soft mint / fresh tone
      image: '',
      specifications: [
        'Personalized Makeover Plan',
        'Wardrobe Refresh',
        'Skin & Hair Care Tips',
        'Confidence Boosting Routine',
        'Before & After Showcase',
      ],
    ),
    NanoSelectionModels(
      title: 'Strike a Better Pose',
      description:
          'Master the art of posture and posing for confident, camera-ready moments.',
      cardColor: AppColors.dynamicColor2, // Cool cyan / energetic tone
      image: '',
      specifications: [
        'Body Posture Correction',
        'Facial Angle Training',
        'Lighting Awareness',
        'Outfit-Pose Match Guide',
        'Expressive Posing Practice',
      ],
    ),
    NanoSelectionModels(
      title: 'Professional Styling',
      description:
          'Refine your appearance with expert styling tips that highlight your best features.',
      cardColor: AppColors.blue, // Deep, confident tone
      image: '',
      specifications: [
        'Stylist-Curated Outfits',
        'Color Coordination Guide',
        'Accessorizing Essentials',
        'Formal & Casual Mix',
        'Seasonal Style Checklist',
      ],
    ),
    NanoSelectionModels(
      title: 'Social Media Profile',
      description:
          'Build a stunning profile that captures your authentic self and attracts engagement.',
      cardColor: AppColors.yellow, // Bright, attention-grabbing tone
      image: '',
      specifications: [
        'Bio & Caption Optimization',
        'Profile Photo Enhancement',
        'Consistent Feed Aesthetics',
        'Brand Tone & Theme Setup',
        'Content Calendar Basics',
      ],
    ),
    NanoSelectionModels(
      title: 'Trending Now',
      description:
          'Stay ahead of the curve with styles and trends defining the moment.',
      cardColor: AppColors.green, // Vibrant and modern tone
      image: '',
      specifications: [
        'Viral Style Boards',
        'Reel & Short Inspirations',
        'Streetwear Highlights',
        'Color of the Season Picks',
        'Influencer Collaboration Ideas',
      ],
    ),
  ];
  static const List<Attachment> listOfAttachment = [

  
    Attachment(icon: CupertinoIcons.camera, name: 'Camera', route: '/camera'),

    Attachment(icon: CupertinoIcons.photo, name: 'Gallery', route: '/gallery'),
  Attachment(
      icon: CupertinoIcons.doc_text_viewfinder,
      name: 'Documents',
      route: '/documents',
    ),
  ];
}
