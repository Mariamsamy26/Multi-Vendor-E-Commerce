class AddressModel {
  final String id;
  final String label;
  final String addressDetails;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.addressDetails,
    required this.isDefault,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      addressDetails: json['addressDetails'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'addressDetails': addressDetails,
      'isDefault': isDefault,
    };
  }

  AddressModel copyWith({
    String? id,
    String? label,
    String? addressDetails,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      addressDetails: addressDetails ?? this.addressDetails,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class ProfileModel {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String avatarUrl;
  final List<AddressModel> addresses;

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.avatarUrl,
    required this.addresses,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      avatarUrl: json['avatarUrl'] as String,
      addresses:
          (json['addresses'] as List<dynamic>?)
              ?.map(
                (item) => AddressModel.fromJson(item as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'avatarUrl': avatarUrl,
      'addresses': addresses.map((a) => a.toJson()).toList(),
    };
  }

  // Helper copyWith method for easier updates
  ProfileModel copyWith({
    String? fullName,
    String? email,
    String? phoneNumber,
    String? dateOfBirth,
    String? avatarUrl,
    List<AddressModel>? addresses,
  }) {
    return ProfileModel(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      addresses: addresses ?? this.addresses,
    );
  }
}
