package com.ifive_dev.ifive_hrms.retrofit

import com.ifive_dev.ifive_hrms.retrofit.model.LocationPostRequest
import com.ifive_dev.ifive_hrms.retrofit.model.Message
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.Header
import retrofit2.http.POST


interface ApiService {

    @POST("public/api-geo-update1")
    fun postLocation(
        @Header("token") token: String?,
        @Body locationPostRequest: LocationPostRequest?
    ): Call<Message>
}