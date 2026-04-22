import Testing

@testable import ExpoObserve
import ExpoAppMetrics

@AppMetricsActor
@Suite("ObserveUserDefaults")
struct ObserveUserDefaultsTests {
  init() {
    // Reset by explicitly clearing the key via the property itself,
    // ensuring the singleton's in-memory cache is also cleared.
    ObserveUserDefaults.dispatchingEnabled = nil
  }

  @Test
  func `dispatchingEnabled defaults to nil`() {
    // Remove the persistent domain to simulate a fresh install
    UserDefaults.standard.removePersistentDomain(forName: "dev.expo.eas.observe")
    #expect(ObserveUserDefaults.dispatchingEnabled == nil)
  }

  @Test
  func `setDispatchingEnabled false persists false`() {
    ObserveUserDefaults.dispatchingEnabled = false
    #expect(ObserveUserDefaults.dispatchingEnabled == false)
  }

  @Test
  func `setDispatchingEnabled true persists true`() {
    ObserveUserDefaults.dispatchingEnabled = false
    #expect(ObserveUserDefaults.dispatchingEnabled == false)
    ObserveUserDefaults.dispatchingEnabled = true
    #expect(ObserveUserDefaults.dispatchingEnabled == true)
  }

  @Test
  func `setDispatchingEnabled nil clears previously set false`() {
    ObserveUserDefaults.dispatchingEnabled = false
    #expect(ObserveUserDefaults.dispatchingEnabled == false)
    ObserveUserDefaults.dispatchingEnabled = nil
    #expect(ObserveUserDefaults.dispatchingEnabled == nil)
  }
}
