package com.ifive_dev.ifive_hrms

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.BatteryManager
import android.os.Build
import android.widget.Toast
import androidx.activity.result.ActivityResultLauncher
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.ifive_dev.ifive_hrms.helper.SharedHelper
import com.ifive_dev.ifive_hrms.service.BootReceiver
import com.ifive_dev.ifive_hrms.service.LocationForegroundService
import com.ifive_dev.ifive_hrms.service.NotificationScheduler
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private var sharedHelper: SharedHelper? = SharedHelper()

    private lateinit var requestPermissionLauncher: ActivityResultLauncher<String>

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val receiver = ComponentName(this, BootReceiver::class.java)
        packageManager.setComponentEnabledSetting(
            receiver,
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
            PackageManager.DONT_KILL_APP
        )

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler(::onMethodCall)

    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {

        try {
            when (call.method) {
                ALARM_RUN -> {
                    val argument: Map<String, Any>? = call.arguments()!!

                    if (shouldRequestNotificationPermission()) {
                        requestNotificationPermission()
                    } else {
                        setDailyNotification()
                    }
                    result.success(SUCCESS)
                }

                ALARM_STOP -> {
                    val argument: Map<String, Any>? = call.arguments()!!
                    closeDailyNotification()
                    result.success(SUCCESS)
                }

                LOCATION_RUN -> {
                    val argument: Map<String, Any>? = call.arguments()!!

                    val token = argument?.get(TOKEN) as String
                    sharedHelper?.setToken(context, TOKEN, token)

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                        checkNotificationPermission()
                    } else {
                        checkAndRequestLocationPermissions()
                    }

                    result.success(SUCCESS)
                    showToast(context, LOCATION_RUN_MESSAGE)
                }

                LOCATION_STOP -> {
                    val argument: Map<String, Any>? = call.arguments()!!

                    stopLocationService()
                    result.success(SUCCESS)
                    showToast(context, LOCATION_STOP_MESSAGE)
                }

                BATTERY -> {
                    val argument: Map<String, Any>? = call.arguments()!!

                    val batteryLevel = getBatteryLevel()
                    if (batteryLevel != -1) {
                        result.success(batteryLevel)
                    } else {
                        result.error(UNAVAILABLE, BATTERY_ERROR_MESSAGE, null)
                    }
                }

                else -> result.notImplemented()
            }
        } catch (_: Exception) {

        }
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)

        return batteryLevel
    }


    private fun checkBackGroundLocationPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            (ContextCompat.checkSelfPermission(
                this,
                android.Manifest.permission.ACCESS_BACKGROUND_LOCATION
            ) == PackageManager.PERMISSION_GRANTED)
        } else {
            return true
        }

    }

    private fun requestBackGroundLocationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(android.Manifest.permission.ACCESS_BACKGROUND_LOCATION),
                BACKGROUND_LOCATION_PERMISSION_REQUEST_CODE
            )
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        when (requestCode) {
            BACKGROUND_LOCATION_PERMISSION_REQUEST_CODE -> {
                if (grantResults.isNotEmpty() &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED
                ) {
                    startLocationService()
                } else {
                    // HANDLE THE CASE WHERE THE USER DENIES THE FOREGROUND SERVICE PERMISSION
                }
            }

            LOCATION_PERMISSION_REQUEST_CODE -> {
                if (grantResults.isNotEmpty() &&
                    grantResults[0] == PackageManager.PERMISSION_GRANTED &&
                    grantResults[1] == PackageManager.PERMISSION_GRANTED
                ) {
                    checkAndRequestLocationPermissions()
                } else {
                    // HANDLE THE CASE WHERE THE USER DENIES THE LOCATION PERMISSION
                }
            }
        }
    }

    private fun checkAndRequestLocationPermissions() {
        if (checkLocationPermission()) {
            if (checkBackGroundLocationPermission()) {
                startLocationService()
            } else {
                requestBackGroundLocationPermission()
            }

        } else {
            requestLocationPermission()
        }
    }

    private fun checkLocationPermission(): Boolean {
        return (ContextCompat.checkSelfPermission(
            this,
            android.Manifest.permission.ACCESS_FINE_LOCATION
        ) == PackageManager.PERMISSION_GRANTED &&
                ContextCompat.checkSelfPermission(
                    this,
                    android.Manifest.permission.ACCESS_COARSE_LOCATION
                ) == PackageManager.PERMISSION_GRANTED)
    }

    private fun requestLocationPermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(
                android.Manifest.permission.ACCESS_FINE_LOCATION,
                android.Manifest.permission.ACCESS_COARSE_LOCATION
            ),
            LOCATION_PERMISSION_REQUEST_CODE
        )
    }

    @RequiresApi(Build.VERSION_CODES.TIRAMISU)
    fun checkNotificationPermission() {
        val permission = android.Manifest.permission.POST_NOTIFICATIONS
        when {
            ContextCompat.checkSelfPermission(
                this,
                permission
            ) == PackageManager.PERMISSION_GRANTED -> {
                // MAKE YOUR ACTION HERE
                checkAndRequestLocationPermissions()
            }

            shouldShowRequestPermissionRationale(permission) -> {
                // PERMISSION DENIED PERMANENTLY
            }

            else -> {
                /* requestNotificationPermission.launch(permission) */
            }
        }
    }

    /*
        private val requestNotificationPermission =
            registerForActivityResult(ActivityResultContracts.RequestPermission()) { isGranted->
                if (isGranted) // make your action here
                    checkAndRequestLocationPermissions()
            }
    */

    private fun startLocationService() {
        val serviceIntent = Intent(this, LocationForegroundService::class.java)
        startService(serviceIntent)
    }

    private fun stopLocationService() {
        val serviceIntent = Intent(this, LocationForegroundService::class.java)
        stopService(serviceIntent)

    }

    private fun shouldRequestNotificationPermission(): Boolean {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
                ContextCompat.checkSelfPermission(
                    this,
                    android.Manifest.permission.POST_NOTIFICATIONS
                ) != PackageManager.PERMISSION_GRANTED
    }

    private fun requestNotificationPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            requestPermissionLauncher.launch(android.Manifest.permission.POST_NOTIFICATIONS)
        }
    }

    /*
        private fun showPermissionSnackBar() {
            Snackbar.make(
                findViewById<View>(android.R.id.content).rootView,
                "Please grant Notification permission from App Settings",
                Snackbar.LENGTH_LONG
            ).show()
        }
    */

    private fun setDailyNotification() {
        val notificationScheduler = NotificationScheduler(this)
        notificationScheduler.scheduleDailyNotification()
        showToast(context, DAILY_NOTIFICATION_START)
    }

    private fun closeDailyNotification() {
        val notificationScheduler = NotificationScheduler(this)
        notificationScheduler.cancelDailyNotification()
        showToast(context, DAILY_NOTIFICATION_CLOSE)
    }

    private fun showToast(context: Context, message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }

    companion object {
        const val BACKGROUND_LOCATION_PERMISSION_REQUEST_CODE = 456
        const val LOCATION_PERMISSION_REQUEST_CODE = 123

        const val ALARM_RUN = "alarm_run"
        const val ALARM_STOP = "alarm_stop"

        const val LOCATION_RUN = "run"
        const val LOCATION_STOP = "stop"

        const val BATTERY = "battery"

        const val SUCCESS = "Success"
        const val TOKEN = "token"
        const val UNAVAILABLE = "UNAVAILABLE"
        const val BATTERY_ERROR_MESSAGE = "Battery level not available"

        const val LOCATION_RUN_MESSAGE = "Have a nice day"
        const val LOCATION_STOP_MESSAGE = "Good Job...!"

        const val DAILY_NOTIFICATION_START = "Daily notification set for 9.30 AM started"
        const val DAILY_NOTIFICATION_CLOSE = "Daily notification set for 9.30 AM stopped"

        const val CHANNEL = "com.ifive_dev.ifive_hrms/service"
    }

}
 