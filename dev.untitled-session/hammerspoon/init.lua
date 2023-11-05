local hyper = {"cmd", "alt", "ctrl","shift"}

local alt = {"alt"}

local applicationHotkeys = {
  c = 'Google Chrome',
  t = 'iTerm',
  s = 'Signal',
}
for key, app in pairs(applicationHotkeys) do
  hs.hotkey.bind(alt, key, function()
    hs.application.launchOrFocus(app)
  end)
end
