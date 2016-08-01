return {
  CLI = {
    NGINX_CONFIG = "nginx.conf"
  },
  -- Non standard headers, specific to httptables
  HEADERS = {
    DEVICE_ID = "X-Device-ID",
    USER_ID = "X-User-ID",
  },
  RATELIMIT = {
    PERIODS = {
      "second",
      "minute",
      "hour",
      "day",
      "month",
      "year"
    }
  }
}
