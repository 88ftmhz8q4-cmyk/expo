import Testing

@testable import ExpoObserve
import ExpoAppMetrics

@AppMetricsActor
@Suite("ObserveUserDefaults")
struct ObserveUserDefaultsTests {
  init() {
    // Reset by explicitly clearing the keys via the properties/setters themselves,
    // ensuring the singleton's in-memory cache is also cleared.
    ObserveUserDefaults.dispatchingEnabled = nil
    ObserveUserDefaults.dispatchInDebug = nil
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

  @Test
  func `dispatchInDebug defaults to nil`() {
    // Remove the persistent domain to simulate a fresh install
    UserDefaults.standard.removePersistentDomain(forName: "dev.expo.eas.observe")
    #expect(ObserveUserDefaults.dispatchInDebug == nil)
  }

  @Test
  func `setDispatchInDebug true persists true`() {
    ObserveUserDefaults.dispatchInDebug = true
    #expect(ObserveUserDefaults.dispatchInDebug == true)
  }

  @Test
  func `setDispatchInDebug false persists false`() {
    ObserveUserDefaults.dispatchInDebug = true
    #expect(ObserveUserDefaults.dispatchInDebug == true)
    ObserveUserDefaults.dispatchInDebug = false
    #expect(ObserveUserDefaults.dispatchInDebug == false)
  }

  @Test
  func `setDispatchInDebug nil clears previously set true`() {
    ObserveUserDefaults.dispatchInDebug = true
    #expect(ObserveUserDefaults.dispatchInDebug == true)
    ObserveUserDefaults.dispatchInDebug = nil
    #expect(ObserveUserDefaults.dispatchInDebug == nil)
  }
}
