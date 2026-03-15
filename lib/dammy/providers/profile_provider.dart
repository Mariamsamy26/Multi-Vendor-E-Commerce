import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import '../../services/shared_prefs_service.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profile;
  final SharedPrefsService _prefsService = SharedPrefsService();
  bool _isLoading = true;

  ProfileProvider() {
    _loadProfile();
  }

  ProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;

  Future<void> _loadProfile() async {
    final savedProfile = await _prefsService.loadProfile();
    if (savedProfile != null) {
      _profile = savedProfile;
    } else {
      // Create a default profile if none exists
      _profile = ProfileModel(
        id: 'user_1',
        fullName: 'Alex Johnson',
        email: 'alex.johnson@example.com',
        phoneNumber: '+1 (555) 987-6543',
        dateOfBirth: 'March 15, 1992',
        avatarUrl: '',
        addresses: [
          AddressModel(
            id: 'addr_1',
            label: 'Home',
            addressDetails: '123 Market St. Apt 4B\nSan Francisco, CA 94103',
            isDefault: true,
          ),
          AddressModel(
            id: 'addr_2',
            label: 'Work',
            addressDetails:
                '456 Tech Plaza, 5th Floor\nSan Francisco, CA 94105',
            isDefault: false,
          ),
        ],
      );
    }
    _isLoading = false;
    notifyListeners();
  }

  void updateProfile(ProfileModel updatedProfile) {
    _profile = updatedProfile;
    _saveProfile();
    notifyListeners();
  }

  Future<void> _saveProfile() async {
    if (_profile != null) {
      await _prefsService.saveProfile(_profile!);
    }
  }
}
