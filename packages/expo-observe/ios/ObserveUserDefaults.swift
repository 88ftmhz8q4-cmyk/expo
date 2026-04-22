// Copyright 2025-present 650 Industries. All rights reserved.

import ExpoAppMetrics

/**
 Class that manages a custom `UserDefaults` database with `"dev.expo.observe"` suite name.
 */
@AppMetricsActor
internal final class ObserveUserDefaults: UserDefaults {
  /**
   Singleton instance of the user defaults for EAS Observe.
   */
  private static let defaults = ObserveUserDefaults()

  /**
   Enum with keys used within this user defaults database.
   */
  private enum Keys: String {
    case lastDispatchedEntryId
    case lastDispatchDate
    case dispatchingEnabled
    case sampleRate
  }

  private init() {
    // It's safe to force-unwrap as `init?(suiteName:)` fails only if `suiteName`
    // is the same as the app's main bundle identifier or the global domain.
    super.init(suiteName: "dev.expo.observe")!
  }

  /**
   Date when events with metrics were last sent and received by the backend.
   */
  static var lastDispatchDate: Date? {
    get {
      if let dateString = defaults.string(forKey: Keys.lastDispatchDate.rawValue) {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: dateString)
      }
      return nil
    }
    set {
      defaults.set(newValue?.ISO8601Format(), forKey: Keys.lastDispatchDate.rawValue)
    }
  }

  /**
   Id of the last dispatched entry. It is used to prevent dispatching entries multiple times. The ids reflect the order of creation.
   Using the creation date is not the best idea as the device's date can be changed by the user or shift along with the timezone.
   */
  static var lastDispatchedEntryId: Int {
    get {
      return defaults.object(forKey: Keys.lastDispatchedEntryId.rawValue) as? Int ?? -1
    }
    set {
      defaults.set(newValue, forKey: Keys.lastDispatchedEntryId.rawValue)
    }
  }

  /**
   Whether observability dispatching is enabled. `nil` when unset; read sites default to `true`.
   */
  static var dispatchingEnabled: Bool? {
    get { getNullableBool(Keys.dispatchingEnabled) }
    set { setNullable(Keys.dispatchingEnabled, newValue) }
  }

  /**
   Sampling rate for dispatching metrics, in `[0, 1]`. `nil` when unset (no sampling applied).
   Stored explicitly so that `0.0` is distinguishable from "absent".
   */
  static var sampleRate: Double? {
    get { getNullableDouble(Keys.sampleRate) }
    set { setNullable(Keys.sampleRate, newValue) }
  }

  // UserDefaults returns `false` for unset bools, so we check `object(forKey:)` first
  // to distinguish "absent" from an explicit stored value.
  private static func getNullableBool(_ key: Keys) -> Bool? {
    guard defaults.object(forKey: key.rawValue) != nil else { return nil }
    return defaults.bool(forKey: key.rawValue)
  }

  private static func getNullableDouble(_ key: Keys) -> Double? {
    guard defaults.object(forKey: key.rawValue) != nil else { return nil }
    return defaults.double(forKey: key.rawValue)
  }

  private static func setNullable(_ key: Keys, _ value: Any?) {
    if let value {
      defaults.set(value, forKey: key.rawValue)
    } else {
      defaults.removeObject(forKey: key.rawValue)
    }
  }
}
