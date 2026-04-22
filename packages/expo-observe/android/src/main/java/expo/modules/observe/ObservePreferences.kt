package expo.modules.observe

import android.content.Context
import androidx.core.content.edit

private const val PREFS_NAME = "dev.expo.observe"
private const val KEY_DISPATCHING_ENABLED = "dispatchingEnabled"
private const val KEY_SAMPLE_RATE = "sampleRate"

object ObservePreferences {
  fun getDispatchingEnabled(context: Context): Boolean {
    val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    return prefs.getBoolean(KEY_DISPATCHING_ENABLED, true)
  }

  fun setDispatchingEnabled(
    context: Context,
    enabled: Boolean?
  ) {
    setNullableBoolean(context, KEY_DISPATCHING_ENABLED, enabled)
  }

  fun getSampleRate(context: Context): Double? {
    val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    if (!prefs.contains(KEY_SAMPLE_RATE)) {
      return null
    }
    return prefs.getFloat(KEY_SAMPLE_RATE, 0f).toDouble()
  }

  fun setSampleRate(
    context: Context,
    rate: Double?
  ) {
    setNullableFloat(context, KEY_SAMPLE_RATE, rate?.toFloat())
  }

  private fun setNullableBoolean(
    context: Context,
    key: String,
    value: Boolean?
  ) {
    val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    prefs.edit(commit = true) {
      if (value == null) {
        remove(key)
      } else {
        putBoolean(key, value)
      }
    }
  }

  private fun setNullableFloat(
    context: Context,
    key: String,
    value: Float?
  ) {
    val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    prefs.edit(commit = true) {
      if (value == null) {
        remove(key)
      } else {
        putFloat(key, value)
      }
    }
  }
}
