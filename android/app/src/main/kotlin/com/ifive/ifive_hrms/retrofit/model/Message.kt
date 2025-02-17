package com.ifive_dev.ifive_hrms.retrofit.model

import com.google.gson.annotations.SerializedName

class Message {

    @SerializedName("message")
    private var message: String? = null

    @SerializedName("created_at")
    private var createdAt: String? = null

    fun getMessage(): String? {
        return message
    }

    fun setMessage(msg: String?) {
        this.message = msg
    }

    fun getCreatedAt(): String? {
        return createdAt
    }

    fun setCreatedAt(crtAt: String?) {
        this.createdAt = crtAt
    }

}