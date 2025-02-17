package com.ifive_dev.ifive_hrms.helper

import android.content.Context
import android.content.SharedPreferences

class SharedHelper {
    private var sharedPreferences: SharedPreferences? = null
    private var editor: SharedPreferences.Editor? = null
 

    fun getToken(context: Context, key: String?): String? {
        sharedPreferences = context.getSharedPreferences("Cache", Context.MODE_PRIVATE)
        return sharedPreferences!!.getString(key, "")
    }


    fun setToken(context: Context, key: String?, value: String?) {
        sharedPreferences = context.getSharedPreferences("Cache", Context.MODE_PRIVATE)
        editor = sharedPreferences!!.edit()
        editor?.putString(key, value)
        editor?.commit()
    }
}