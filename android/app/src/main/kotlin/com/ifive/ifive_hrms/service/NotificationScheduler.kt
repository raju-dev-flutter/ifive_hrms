package com.ifive.ifive_hrms.service

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.ServiceInfo
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import androidx.annotation.RequiresApi
import java.util.Calendar

class NotificationScheduler(private val context: Context) {

    fun scheduleDailyNotification() {

        val calendar = Calendar.getInstance().apply {
            timeInMillis = System.currentTimeMillis()
            set(Calendar.HOUR_OF_DAY, HOUR)
            set(Calendar.MINUTE, MINUTE)
            set(Calendar.SECOND, SECOND)
        }
        
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
//        val alarmIntent = Intent(context, AlarmReceiver::class.java).let { intent ->
//            PendingIntent.getBroadcast(context, REQUEST_CODE, intent, PendingIntent.FLAG_IMMUTABLE)
//            
//        }

        // SET THE CUSTOM RINGTONE FOR THE ALARM
//        alarmIntent.putExtra(RingtoneManager.EXTRA_RINGTONE_TYPE, RingtoneManager.TYPE_ALARM)
//        alarmIntent.putExtra(RingtoneManager.EXTRA_RINGTONE_EXISTING_URI, RINGTONE_URL)
        
        val alarmIntent = Intent(context, AlarmReceiver::class.java).apply {
            // SET THE CUSTOM RINGTONE URI AS AN EXTRA
            putExtra(RingtoneManager.EXTRA_RINGTONE_TYPE, RingtoneManager.TYPE_ALARM)
            putExtra(RingtoneManager.EXTRA_RINGTONE_EXISTING_URI, RINGTONE_URL)
        }

        val pendingIntent = PendingIntent.getBroadcast(context, REQUEST_CODE, alarmIntent, PendingIntent.FLAG_IMMUTABLE)
 
        // SET THE ALARM TO START AT 9:30 AM AND REPEAT EVERY DAY
        alarmManager.setRepeating(TYPE, calendar.timeInMillis, INTERVAL, pendingIntent)
    }

    fun cancelDailyNotification() {
        val alarmManager = context.getSystemService(Context.ALARM_SERVICE) as AlarmManager
        val alarmIntent = Intent(context, AlarmReceiver::class.java).let { intent ->
            PendingIntent.getBroadcast(context, REQUEST_CODE, intent, PendingIntent.FLAG_IMMUTABLE)
        }

        // CANCEL THE ALARM
        alarmManager.cancel(alarmIntent)
    }


    companion object { 
        val RINGTONE_URL: Uri = Uri.parse("android.resource://com.ifive.ifive_hrms/raw/food")

        const val REQUEST_CODE = 1
 
        const val HOUR = 9
        const val MINUTE = 30
        const val SECOND = 0  
        
        const val TYPE = AlarmManager.RTC_WAKEUP 
        const val INTERVAL = AlarmManager.INTERVAL_DAY 
          
    }
}