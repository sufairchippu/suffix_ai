import 'package:clean_architutre_learn/core/constants/models/models.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  static const List<AttachmentItemInscreen> listOfAttachment = [
    AttachmentItemInscreen(
      icon: CupertinoIcons.camera,
      name: 'Camera',
      route: '/camera',
    ),

    AttachmentItemInscreen(
      icon: CupertinoIcons.photo,
      name: 'Gallery',
      route: '/gallery',
    ),
    AttachmentItemInscreen(
      icon: CupertinoIcons.doc_text_viewfinder,
      name: 'Documents',
      route: '/documents',
    ),
  ];

  static String mapSupabaseError(AuthApiException e) {
    switch (e.code) {
      case 'email_address_invalid':
        return 'Invalid email address. Please enter a valid one.';
      case 'invalid_credentials':
        return 'Incorrect email or password.';
      case 'user_not_found':
        return 'User not found. Please sign up first.';
      case 'user_already_exists':
        return 'An account with this email already exists.';
      case 'email_not_confirmed':
        return 'Please verify your email address before logging in.';
      case 'password_too_short':
        return 'Password must be at least 6 characters.';
      case 'invalid_grant':
        return 'Invalid email or password.';
      default:
        return e.message.isNotEmpty
            ? e.message
            : 'Authentication failed. Please try again.';
    }
  }

  static const List<String> qustionText = [
    'Multiple Choice Question',
    'One Word',
    'TASC',
    'University type',
    'University type (1 Qn exception)',
    // '',
  ];
}

enum Diffculty { easy, medium, hard }

enum QuestionPaperTYpe { mcq, normal, oneWord, tasc, universityException }
