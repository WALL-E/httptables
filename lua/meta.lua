local version = setmetatable({
  major = 0,
  minor = 1,
  patch = 12,
  pre_release = "alpha"
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
