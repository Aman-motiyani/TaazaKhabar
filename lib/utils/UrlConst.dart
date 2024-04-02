class URLConst{
  static const newsApi = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=b3c093eb64a040708058d0733a4a511a';

  static const weatherApi = 'https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=5d7b702e382e8bcdd650db6eebf78fc1';
}

// "2024-02-19T12:30:00Z",

// val newsJsonArray = it.getJSONArray("articles")
// val newsArray = ArrayList<News>()
// for(i in 0 until newsJsonArray.length()) {
// val newsJsonObject = newsJsonArray.getJSONObject(i)
// val news = News(
// newsJsonObject.getString("title"),
// newsJsonObject.getString("author"),
// newsJsonObject.getString("url"),
// newsJsonObject.getString("urlToImage")



// @GET("data/2.5/weather?&units=metric&appid=5d7b702e382e8bcdd650db6eebf78fc1")
// suspend fun getCityData(
// @Query("q") cityName: String
// ) : Response<WeatherData>
//
// @GET("data/2.5/weather?&units=metric&appid=5d7b702e382e8bcdd650db6eebf78fc1")
// suspend fun getCurrentWeatherData(
// @Query("lat") lat: String?,
// @Query("lon") lon: String?,
// ) : Response<WeatherData>
//




//https://api.openweathermap.org/data/2.5/weather?q=bengaluru&appid=5d7b702e382e8bcdd650db6eebf78fc1