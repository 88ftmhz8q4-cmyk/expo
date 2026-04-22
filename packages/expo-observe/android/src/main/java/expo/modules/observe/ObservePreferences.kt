package expo.modules.observe

import android.content.Context
import androidx.core.content.edit

private const val PREFS_NAME = "dev.expo.observe"
private const val KEY_DISPATCHING_ENABLED = "dispatchingEnabled"
private const val KEY_DISPATCH_IN_DEBUG = "dispatchInDebug"

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

  fun getDispatchInDebug(context: Context): Boolean {
    val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    return prefs.getBoolean(KEY_DISPATCH_IN_DEBUG, false)
  }

  fun setDispatchInDebug(
    context: Context,
    enabled: Boolean?
  ) {
    setNullableBoolean(context, KEY_DISPATCH_IN_DEBUG, enabled)
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
}
