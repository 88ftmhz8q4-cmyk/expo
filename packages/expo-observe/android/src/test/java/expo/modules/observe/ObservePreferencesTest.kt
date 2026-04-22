package expo.modules.observe

import android.content.Context
import androidx.test.core.app.ApplicationProvider
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(manifest = Config.NONE, sdk = [28])
class ObservePreferencesTest {
  private lateinit var context: Context

  @Before
  fun setUp() {
    context = ApplicationProvider.getApplicationContext()
    // Clear preferences before each test
    context
      .getSharedPreferences("dev.expo.observe", Context.MODE_PRIVATE)
      .edit()
      .clear()
      .commit()
  }

  @Test
  fun `getDispatchingEnabled returns true by default`() {
    assertTrue(ObservePreferences.getDispatchingEnabled(context))
  }

  @Test
  fun `setDispatchingEnabled false persists`() {
    ObservePreferences.setDispatchingEnabled(context, false)
    assertFalse(ObservePreferences.getDispatchingEnabled(context))
  }

  @Test
  fun `setDispatchingEnabled true after false persists`() {
    ObservePreferences.setDispatchingEnabled(context, false)
    assertFalse(ObservePreferences.getDispatchingEnabled(context))
    ObservePreferences.setDispatchingEnabled(context, true)
    assertTrue(ObservePreferences.getDispatchingEnabled(context))
  }

  @Test
  fun `setDispatchingEnabled null clears previously set false`() {
    ObservePreferences.setDispatchingEnabled(context, false)
    assertFalse(ObservePreferences.getDispatchingEnabled(context))
    ObservePreferences.setDispatchingEnabled(context, null)
    assertTrue(ObservePreferences.getDispatchingEnabled(context))
  }

  @Test
  fun `getSampleRate returns null by default`() {
    assertNull(ObservePreferences.getSampleRate(context))
  }

  @Test
  fun `setSampleRate persists value`() {
    ObservePreferences.setSampleRate(context, 0.25)
    assertEquals(0.25, ObservePreferences.getSampleRate(context)!!, 0.0001)
  }

  @Test
  fun `setSampleRate 0_0 is distinct from null`() {
    ObservePreferences.setSampleRate(context, 0.0)
    assertEquals(0.0, ObservePreferences.getSampleRate(context)!!, 0.0001)
  }

  @Test
  fun `setSampleRate null clears previously set value`() {
    ObservePreferences.setSampleRate(context, 0.5)
    assertEquals(0.5, ObservePreferences.getSampleRate(context)!!, 0.0001)
    ObservePreferences.setSampleRate(context, null)
    assertNull(ObservePreferences.getSampleRate(context))
  }
}
