package com.ifive.ifive_hrms.retrofit.model

import com.google.gson.annotations.SerializedName

class LocationPostRequest {

    @SerializedName("latitude")
    private var latitude: String? = null

    @SerializedName("longtitude")
    private var longitude: String? = null

    @SerializedName("adders")
    private var address: String? = null

    @SerializedName("battery")
    private var battery: String? = null

    @SerializedName("times")
    private var time: Long? = null

    fun getLatitude(): String? {
        return latitude
    }

    fun setLatitude(lat: String?) {
        this.latitude = lat
    }

    fun getLongitude(): String? {
        return longitude
    }

    fun setLongitude(long: String?) {
        this.longitude = long
    }

    fun getAddress(): String? {
        return address
    }

    fun setAddress(add: String?) {
        this.address = add
    }

    fun getBattery(): String? {
        return battery
    }

    fun setBattery(btr: String?) {
        this.battery = btr
    }

    fun getTime(): Long? {
        return time
    }

    fun setTime(t: Long?) {
        this.time = t
    }

}