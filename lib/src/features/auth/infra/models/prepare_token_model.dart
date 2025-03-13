import 'dart:convert';

class PrepareTokenModel {
  final String clientId;
  final String installationId;
  final String pushDeviceToken;
  final String timestamp;
  final String deviceInformation;
  final String userDevicePairingId;
  final String deviceLanguage;
  final String? lastToken;

  PrepareTokenModel({
    required this.clientId,
    required this.installationId,
    required this.pushDeviceToken,
    required this.timestamp,
    required this.deviceInformation,
    required this.userDevicePairingId,
    required this.deviceLanguage,
    this.lastToken,
  });

  PrepareTokenModel copyWith({
    String? clientId,
    String? installationId,
    String? pushDeviceToken,
    String? timestamp,
    String? deviceInformation,
    String? userDevicePairingId,
    String? deviceLanguage,
    String? lastToken,
  }) {
    return PrepareTokenModel(
      clientId: clientId ?? this.clientId,
      installationId: installationId ?? this.installationId,
      pushDeviceToken: pushDeviceToken ?? this.pushDeviceToken,
      timestamp: timestamp ?? this.timestamp,
      deviceInformation: deviceInformation ?? this.deviceInformation,
      userDevicePairingId: userDevicePairingId ?? this.userDevicePairingId,
      deviceLanguage: deviceLanguage ?? this.deviceLanguage,
      lastToken: lastToken ?? this.lastToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientId': clientId,
      'installationId': installationId,
      'pushDeviceToken': pushDeviceToken,
      'timestamp': timestamp,
      'deviceInformation': deviceInformation,
      'userDevicePairingId': userDevicePairingId,
      'deviceLanguage': deviceLanguage,
      'lastToken': lastToken,
      'aditionalInfo': {},
    };
  }

  factory PrepareTokenModel.fromMap(Map<String, dynamic> map) {
    return PrepareTokenModel(
      clientId: map['clientId'] as String,
      installationId: map['installationId'] as String,
      pushDeviceToken: map['pushDeviceToken'] as String,
      timestamp: map['timestamp'] as String,
      deviceInformation: map['deviceInformation'] as String,
      userDevicePairingId: map['userDevicePairingId'] as String,
      deviceLanguage: map['deviceLanguage'] as String,
      lastToken: map['lastToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrepareTokenModel.fromJson(String source) =>
      PrepareTokenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
