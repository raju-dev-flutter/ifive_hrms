package com.ifive.ifive_hrms.service

import android.annotation.SuppressLint
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Context.NOTIFICATION_SERVICE
import android.content.Intent
import android.os.Build
import androidx.core.app.NotificationCompat
import com.ifive.ifive_hrms.MainActivity
import com.ifive.ifive_hrms.R

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        showNotification(context)
    }
    private fun showNotification(context: Context) {
        val notificationManager =
            context.getSystemService(NOTIFICATION_SERVICE) as NotificationManager

        // CREATE A NOTIFICATION CHANNEL (FOR ANDROID 8.0 AND ABOVE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                CHANNEL_ID,NOTIFICATION_CHANNEL_NAME,
                NotificationManager.IMPORTANCE_DEFAULT
            )
            notificationManager.createNotificationChannel(channel)
        }
        val intent = Intent(context, MainActivity::class.java)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        val pendingIntent = PendingIntent.getActivity(context, NOTIFICATION_ID, intent,
            PendingIntent.FLAG_IMMUTABLE)

        // CREATE AND SHOW THE NOTIFICATION
        val notification = NotificationCompat.Builder(context, CHANNEL_ID)
            .setContentTitle(NOTIFICATION_CHANNEL_TITLE)
            .setContentText(NOTIFICATION_CHANNEL_CONTENT)
            .setSmallIcon(NOTIFICATION_ICON)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent) // SET THE PENDING INTENT
            .setAutoCancel(true)
            .build()

        notificationManager.notify(NOTIFICATION_ID, notification)
    }

    companion object {
 
        const val NOTIFICATION_CHANNEL_NAME =  "Daily Notifications"
        const val NOTIFICATION_CHANNEL_TITLE =  "Good Morning!"
        const val NOTIFICATION_CHANNEL_CONTENT =  "It's 8 AM. Have a great day!" 
         
         @SuppressLint("NonConstantResourceId")
         const val NOTIFICATION_ICON = R.drawable.notification_icon_push
 
        const val CHANNEL_ID = "DailyNotificationsChannel"
        const val NOTIFICATION_ID = 1
    }
}