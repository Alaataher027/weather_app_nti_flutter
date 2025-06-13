String getWeatherIcon(String condition, dynamic isDay) {
  String normalizedCondition = condition.trim().toLowerCase();

  switch (isDay) {
    case 1:
      switch (normalizedCondition) {
        case "sunny":
          return "assets/images/sunny.svg";
        case "partly cloudy":
          return "assets/images/cloudy_partly.svg";
        case "fog":
        case "mist":
          return "assets/images/cloudy_fog.svg";
        case "cloudy":
        case "overcast":
          return "assets/images/cloudy.svg";
        case "patchy rain possible":
        case "light rain":
        case "light drizzle":
        case "moderate rain":
        case "patchy rain nearby":
        case "heavy rain":
          return "assets/images/rain.svg";
        case "patchy snow possible":
        case "light snow":
        case "moderate snow":
        case "heavy snow":
          return "assets/images/snowy.svg";
        case "thundery outbreaks possible":
          return "assets/images/thunder.svg";
        default:
          return "assets/images/cloudy.svg"; 
      }
    case 0:
      switch (normalizedCondition) {
        case "clear":
          return "assets/images/night.svg";
        case "partly cloudy":
          return "assets/images/cloudy_fog.svg";
        case "fog":
        case "mist":
          return "assets/images/cloudy_fog.svg";
        case "cloudy":
        case "overcast":
          return "assets/images/cloudy_fog.svg";
        case "patchy rain possible":
        case "light rain":
        case "light drizzle":
        case "moderate rain":
        case "patchy rain nearby":
        case "heavy rain":
          return "assets/images/rain.svg";
        case "patchy snow possible":
        case "light snow":
        case "moderate snow":
        case "heavy snow":
          return "assets/images/snowy.svg";
        case "thundery outbreaks possible":
          return "assets/images/thunder.svg";
        default:
          return "assets/images/night.svg"; 
      }
    default:
      return "assets/images/cloudy.svg";
  }
}

String getHourlyWeatherIcon(String condition) {
  String normalizedCondition = condition.trim().toLowerCase();

  switch (normalizedCondition) {
    case "clear":
      return "assets/images/night.svg";
    case "sunny":
      return "assets/images/sunny.svg";
    case "partly cloudy":
      return "assets/images/cloudy_partly.svg";
    case "fog":
    case "mist":
      return "assets/images/cloudy_fog.svg";
    case "cloudy":
    case "overcast":
      return "assets/images/cloudy.svg";
    case "patchy rain possible":
    case "light rain":
    case "light drizzle":
    case "moderate rain":
    case "patchy rain nearby":
    case "heavy rain":
      return "assets/images/rain.svg";
    case "patchy snow possible":
    case "light snow":
    case "moderate snow":
    case "heavy snow":
      return "assets/images/snowy.svg";
    case "thundery outbreaks possible":
      return "assets/images/thunder.svg";
    default:
      return "assets/images/cloudy.svg";
  }
}
