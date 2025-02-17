package com.ifive_dev.ifive_hrms.service

import android.Manifest
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.location.Geocoder
import android.os.BatteryManager
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority
import com.ifive_dev.ifive_hrms.MainActivity
import com.ifive_dev.ifive_hrms.R
import com.ifive_dev.ifive_hrms.helper.SharedHelper
import com.ifive_dev.ifive_hrms.retrofit.ApiClient
import com.ifive_dev.ifive_hrms.retrofit.model.LocationPostRequest
import com.ifive_dev.ifive_hrms.retrofit.model.Message
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import java.util.Locale

class LocationForegroundService : Service() {
    private lateinit var fusedLocationClient: FusedLocationProviderClient

    private var sharedHelper: SharedHelper? = null

    override fun onCreate() {
        super.onCreate()
        sharedHelper = SharedHelper()
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
    }


    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (!checkLocationPermissionIsGiven()) return START_NOT_STICKY
        val notification = createNotification()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            startForeground(NOTIFICATION_ID, notification, FOREGROUND_SERVICE_TYPE)
        } else {
            startForeground(NOTIFICATION_ID, notification)
        }
        requestLocationUpdates()
        return START_STICKY
    }

    private fun createNotification(): Notification {

        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, NOTIFICATION_ID, notificationIntent, PendingIntent.FLAG_IMMUTABLE
        )
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

            val importance = NotificationManager.IMPORTANCE_DEFAULT

            NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                NOTIFICATION_CHANNEL_NAME,
                importance
            ).apply {
                description = NOTIFICATION_CHANNEL_DESCRIPTION
                with((this@LocationForegroundService.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager)) {
                    createNotificationChannel(this@apply)
                }
            }
        }

        return NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setContentTitle(NOTIFICATION_CHANNEL_TITLE)
            .setContentText(NOTIFICATION_CHANNEL_CONTENT)
            .setSmallIcon(R.drawable.notification_icon_push)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .build()
    }

    private fun requestLocationUpdates() {

        val locationRequest =
            LocationRequest.Builder(DELAY) //  INTERVAL IN MILLISECONDS ---> 15 MINUTES
                .setPriority(Priority.PRIORITY_LOW_POWER) // SET PRIORITY SEPARATELY
                .build()

        val locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult) {
                val locationGPS = locationResult.lastLocation
                // SEND LOCATION TO THE SERVER HERE

                if (locationGPS != null) {
                    val lat = locationGPS.latitude
                    val long = locationGPS.longitude
                    val address = getCompleteAddressString(lat, long)

                    Log.d(
                        "LOCATION",
                        "LAT: $lat, LONG: $long, BATTERY: ${getBatteryPercentage(applicationContext)}, Address: $address"
                    )

                    locationUpdate(
                        lat.toString(),
                        long.toString(),
                        getBatteryPercentage(applicationContext).toString(),
                        address
                    )
                } else {

                    Log.i("LOCATION", "LOCATION IS NOT AVAILABLE")
                    // HANDLE THE CASE WHEN THE LOCATION IS NOT AVAILABLE
//                    locationUpdate((0).toString(), (0).toString(), getBatteryPercentage(applicationContext).toString(), "Location is not available")
                }
            }
        }

        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            return
        }

        Log.i("LOCATION", "ASKED FOR LOCATION")

        fusedLocationClient.requestLocationUpdates(locationRequest, locationCallback, null)
    }

    private fun getCompleteAddressString(lat: Double, long: Double): String {
        var strAdd = ""
        val geocoder = Geocoder(applicationContext, Locale.getDefault())

        try {
            val addresses = geocoder.getFromLocation(lat, long, 1)
            if (addresses!!.isNotEmpty()) {
                val returnedAddress = addresses[0]
                val strReturnedAddress = StringBuilder("")
                for (i in 0..returnedAddress.maxAddressLineIndex) {
                    strReturnedAddress.append(returnedAddress.getAddressLine(i)).append("\n")
                }
                strAdd = strReturnedAddress.toString().trim()
            } else {
                Log.d("EMPTY", "MY CURRENT LOCATION ADDRESS IS NOT AVAILABLE")
            }
        } catch (e: Exception) {
            Log.e("ERROR", "ERROR GETTING ADDRESS: ${e.message}")
        }
        return strAdd
    }

    private fun getBatteryPercentage(context: Context): Int {
        // USE APPLICATION CONTEXT TO AVOID POTENTIAL MEMORY LEAKS
        val iFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val batteryStatus = context.registerReceiver(null, iFilter)
        val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

        val batteryPct = if (scale != 0) (level.toFloat() / scale.toFloat()) else 0.0f

        Log.d("BATTERY", "BATTERY: ${(batteryPct * 100).toInt()}")

        return (batteryPct * 100).toInt()
    }


    private fun checkLocationPermissionIsGiven() =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_BACKGROUND_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_FINE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ) == PackageManager.PERMISSION_GRANTED
        }

    private fun locationUpdate(lat: String, long: String, battery: String, address: String) {

        val locationRequest = LocationPostRequest()

        locationRequest.setLatitude(lat)
        locationRequest.setLongitude(long)
        locationRequest.setAddress(address)
        locationRequest.setBattery(battery)

        Log.d(
            "POST",
            "POST: LAT: ${locationRequest.getLatitude()}, LONG: ${locationRequest.getLongitude()}, BATTERY: ${locationRequest.getBattery()}, TOKEN: ${
                sharedHelper?.getToken(
                    this,
                    "token"
                )
            }, ADDRESS: ${locationRequest.getAddress()}"
        )

        val callEnqueue = ApiClient.apiService.postLocation(
            sharedHelper?.getToken(this, "token"),
            locationRequest
        )
        callEnqueue.enqueue(object : Callback<Message?> {
            override fun onResponse(call: Call<Message?>, response: Response<Message?>) {
                println(response)
                if (response.body() != null) {
                    response.body()!!.let { Log.d("RESPONSE", it.toString()) }
                    if (response.body()!!.getMessage().equals("1")) {
                        response.body()!!.getMessage()?.let { Log.d("RESPONSE", it) }
                    }
                    if (response.body()!!.getMessage().equals("2")) {
                        response.body()!!.getMessage()?.let { Log.d("RESPONSE", it) }
                    }
                } else {
                    Log.e("ERROR", response.body().toString())
                }
            }

            override fun onFailure(call: Call<Message?>, t: Throwable) {
                t.message?.let { Log.e("ERROR", it) }

            }
        })

    }

    companion object {
        const val NOTIFICATION_CHANNEL_ID = "ForegroundServiceChannel"
        const val NOTIFICATION_CHANNEL_NAME = "Foreground Service Channel"
        const val NOTIFICATION_CHANNEL_TITLE = "iFive Location Service"
        const val NOTIFICATION_CHANNEL_CONTENT = "Running"
        const val NOTIFICATION_CHANNEL_DESCRIPTION = "Running service to find your location"

        const val NOTIFICATION_ID = 1


        const val DELAY = 15 * 60 * 1000L

        @RequiresApi(Build.VERSION_CODES.Q)
        const val FOREGROUND_SERVICE_TYPE = ServiceInfo.FOREGROUND_SERVICE_TYPE_LOCATION

    }
}

//class LocationService : Service(), LocationListener {
//
//    private var locationManager: LocationManager? = null
//
//    private var sharedHelper: SharedHelper? = null
// 
//    private var gpsLocationListener: LocationListener? = null
//
//
//    override fun onCreate() {
//        super.onCreate()
//        locationManager = getSystemService(LOCATION_SERVICE) as LocationManager
//        gpsLocationListener = LocationService()
//        sharedHelper = SharedHelper()
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//            return
//        }
//        locationManager?.requestLocationUpdates(LocationManager.GPS_PROVIDER, 10 * 1000L, 0f, gpsLocationListener as LocationService)
//
//    }
//    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
//        try {
//            val input = intent.getStringExtra("inputExtra")
//            createNotificationChannel() // Ensure this method is defined and called properly
//
//            val notificationIntent = Intent(this, MainActivity::class.java)
//            val pendingIntent = PendingIntent.getActivity(
//                this, 0, notificationIntent, PendingIntent.FLAG_IMMUTABLE
//            )
//
//            val notification: Notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
//                .setContentTitle("iFive Location Service")
//                .setContentText(input)
//                .setSmallIcon(R.drawable.notification_icon_push)
//                .setContentIntent(pendingIntent)
//                .build()
//
////            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
////                startForegroundService(Intent(applicationContext, LocationService::class.java))
////            } else {
////                startService(Intent(applicationContext, LocationService::class.java))
////                startForeground(NOTIFICATION_ID, notification) // Move this line here for lower SDK versions
////            }
//
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                // Specify the foreground service type if SDK version is 30 or higher
//                startForegroundService(Intent(applicationContext, LocationService::class.java))
//                // Call startForeground() immediately after startForegroundService()
//                startForeground(NOTIFICATION_ID, notification)
//            } else {
//                // For SDK versions lower than 30, start the service normally
//                startService(Intent(applicationContext, LocationService::class.java))
//                // Attach the notification to the foreground service
//                startForeground(NOTIFICATION_ID, notification)
//            }
//
//            val handler = Handler()
//            val delay = 1200000   // 20 min
//            handler.postDelayed(object : Runnable {
//                override fun run() {
//                    getLocation() // Make sure this method is implemented properly
//                    handler.postDelayed(this, delay.toLong())
//                }
//            }, delay.toLong())
//
//            return START_STICKY
//        } catch (e: Exception) {
//            e.printStackTrace()
//            return START_NOT_STICKY // Or another appropriate return value
//        }
//    }
//
////    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
////        val input = intent.getStringExtra("inputExtra")
////        createNotificationChannel()
////        val notificationIntent = Intent(this, MainActivity::class.java)
////        val pendingIntent = PendingIntent.getActivity(this,
////                0, notificationIntent, PendingIntent.FLAG_IMMUTABLE)
////
////        val notification: Notification = NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
////                .setContentTitle("iFive Location Service")
////                .setContentText(input)
////                .setSmallIcon(R.drawable.notification_icon_push)
////                .setContentIntent(pendingIntent)
////                .build()
////        
//////        startForeground(NOTIFICATION_ID, notification)
////
////        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
////            // Specify the foreground service type if SDK version is 30 or higher 
////            startForegroundService(Intent(applicationContext, LocationService::class.java))
//////            startForeground(NOTIFICATION_ID, notification)
////        } else {
////            // For SDK versions lower than 30, start the service normally
////            startService(Intent(applicationContext, LocationService::class.java))
////            // Attach the notification to the foreground service
//////            startForeground(NOTIFICATION_ID, notification)
////        }
////        startForeground(NOTIFICATION_ID, notification)
////        
////        val handler = Handler()
////        val delay = 1200000   // 20 min
//////        val delay = 60000   // 1 min
//////        val delay = 15 * 60 * 1000L  // 15 minutes in milliseconds
////        
////        handler.postDelayed(object : Runnable {
////            override fun run() {
////                getLocation()
////                handler.postDelayed(this, delay.toLong())
////            }
////        }, delay.toLong())
////
////        return START_STICKY
////    }
//
//    private fun createNotificationChannel() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            val serviceChannel = NotificationChannel(
//                    NOTIFICATION_CHANNEL_ID,
//                    "Foreground Service Channel",
//                    NotificationManager.IMPORTANCE_DEFAULT
//            )
//            val manager = getSystemService(NotificationManager::class.java)
//            manager.createNotificationChannel(serviceChannel)
//        }
//    }
//
//
//    private fun getLocation() {
//        if (ActivityCompat.checkSelfPermission(
//                        applicationContext, Manifest.permission.ACCESS_FINE_LOCATION
//                ) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(
//                        applicationContext, Manifest.permission.ACCESS_COARSE_LOCATION
//                ) != PackageManager.PERMISSION_GRANTED
//        ) {
//            locationUpdate((0).toString(), (0).toString(), getBatteryPercentage(this).toString(), "Location permissions are not granted")
//            // Handle the case when location permissions are not granted
//        } else {
//            val locationGPS: Location? =
//                    locationManager?.getLastKnownLocation(LocationManager.GPS_PROVIDER)
//            if (locationGPS != null) {
//                val lat = locationGPS.latitude
//                val long = locationGPS.longitude
//                println("Lat: $lat, Long: $long ")
//                val address = getCompleteAddressString(lat, long)
//                locationUpdate(lat.toString(), long.toString(), getBatteryPercentage(this).toString(), address)
//            } else {
//                locationUpdate((0).toString(), (0).toString(), getBatteryPercentage(this).toString(), "Location is not available")
//                // Handle the case when the location is not available
//            }
//        }
//    }
//
//    private fun getCompleteAddressString(lat: Double, long: Double): String {
//        var strAdd = ""
//        val geocoder = Geocoder(applicationContext, Locale.getDefault())
//
//        try {
//            val addresses = geocoder.getFromLocation(lat, long, 1)
//            if (addresses!!.isNotEmpty()) {
//                val returnedAddress = addresses[0]
//                val strReturnedAddress = StringBuilder("")
//                for (i in 0..returnedAddress.maxAddressLineIndex) {
//                    strReturnedAddress.append(returnedAddress.getAddressLine(i)).append("\n")
//                }
//                strAdd = strReturnedAddress.toString().trim()
//                // println("My Current location address: $strAdd")
//            } else {
//                println("My Current location address is not available")
//            }
//        } catch (e: Exception) {
//            println("Error getting address: ${e.message}")
//        }
//        return strAdd
//    }
//
//    private fun getBatteryPercentage(context: Context): Int {
//        // Use applicationContext to avoid potential memory leaks
//        val iFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
//        val batteryStatus = context.registerReceiver(null, iFilter)
//        val level = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
//        val scale = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
//
//        val batteryPct = if (scale != 0) (level.toFloat() / scale.toFloat()) else 0.0f
//
//        println("${(batteryPct * 100).toInt()}  Battery")
//        return (batteryPct * 100).toInt()
//    }
//
//    override fun onLocationChanged(location: Location) {
//        println("Location: $location")
//    }
//
//    private fun locationUpdate(lat: String, long: String, battery: String, address: String) {
//        println("POST DATA: ${sharedHelper?.getToken(this, "token")}")
//
//        val locationRequest: LocationPostRequest = LocationPostRequest()
//        locationRequest.setLatitude(lat)
//        locationRequest.setLongitude(long)
//        locationRequest.setAddress(address)
//        locationRequest.setBattery(battery)
//        println("POST DATA: ${locationRequest.getAddress()} ${sharedHelper?.getToken(this, "token")}")
//        val callEnqueue = ApiClient.apiService.postLocation(sharedHelper?.getToken(this, "token"), locationRequest)
//        callEnqueue.enqueue(object : Callback<Message?> {
//            override fun onResponse(call: Call<Message?>, response: Response<Message?>) {
//                println(response)
//                if (response.body() != null) {
//                    println(response.body())
//                    if (response.body()!!.getMessage().equals("1")) {
//                        println(response.body()!!.getMessage())
//                    }
//                    if (response.body()!!.getMessage().equals("2")) {
//                        println(response.body()!!.getMessage())
//                    }
//                } else {
//                    println(response.body()) // Handle error 
//                }
//            }
//
//            override fun onFailure(call: Call<Message?>, t: Throwable) {
//                println(t) // Handle failure  
//            }
//        })
//
//    }
//
//    override fun onBind(intent: Intent?): IBinder? {
//        return null
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        gpsLocationListener?.let { locationManager?.removeUpdates(it) }
//    }
//
//    companion object {
//        const val NOTIFICATION_CHANNEL_ID = "ForegroundServiceChannel"
//
//        const val NOTIFICATION_ID = 1
//
//    }
//
//}
 

