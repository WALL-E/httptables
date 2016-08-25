local version = setmetatable({
  major = 16,
  minor = 08,
  patch = 24,
  pre_release = "beta"
}, {
  __tostring = function(t)
    return string.format("%d.%d.%d%s", t.major, t.minor, t.patch,
                         t.pre_release and "-"..t.pre_release or "")
  end
})

return {
  _NAME = "httptables",
  _VERSION = tostring(version),
  __VERSION = version
}
