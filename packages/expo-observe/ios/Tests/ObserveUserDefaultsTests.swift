import Testing

@testable import ExpoObserve
import ExpoAppMetrics

@AppMetricsActor
@Suite("ObserveUserDefaults")
struct ObserveUserDefaultsTests {
  init() {
    // Reset to a clean slate by clearing both keys via the property setters,
    // ensuring the singleton's in-memory cache is also cleared.
    ObserveUserDefaults.dispatchingEnabled = nil
  }

  @Test
  func `dispatchingEnabled defaults to nil`() {
    // Remove the persistent domain to simulate a fresh install
    UserDefaults.standard.removePersistentDomain(forName: "dev.expo.eas.observe")
    ObserveUserDefaults.sampleRate = nil
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
  func `sampleRate defaults to nil`() {
    UserDefaults.standard.removePersistentDomain(forName: "dev.expo.observe")
    #expect(ObserveUserDefaults.sampleRate == nil)
  }

  @Test
  func `setSampleRate persists Double value`() {
    ObserveUserDefaults.sampleRate = 0.25
    #expect(ObserveUserDefaults.sampleRate == 0.25)
  }

  @Test
  func `setSampleRate 0_0 is distinct from nil`() {
    ObserveUserDefaults.sampleRate = 0.0
    #expect(ObserveUserDefaults.sampleRate == 0.0)
  }

  @Test
  func `setSampleRate nil clears previously set value`() {
    ObserveUserDefaults.sampleRate = 0.5
    #expect(ObserveUserDefaults.sampleRate == 0.5)
    ObserveUserDefaults.sampleRate = nil
    #expect(ObserveUserDefaults.sampleRate == nil)
  }
}
