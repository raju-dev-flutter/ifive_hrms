package com.ifive_dev.ifive_hrms.service

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.ifive_dev.ifive_hrms.service.LocationForegroundService

class BootReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_BOOT_COMPLETED) {

            // ALARM SERVICE 
            val notificationScheduler = NotificationScheduler(context)
            notificationScheduler.scheduleDailyNotification()

            // LOCATION SERVICE
            val serviceIntent = Intent(context, LocationForegroundService::class.java)
            context.startService(serviceIntent)
        }
    }
}