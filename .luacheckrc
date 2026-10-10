-- Every port in this repo targets Neovim, which supplies `vim` as a runtime global.
-- Declaring it here keeps the repo-wide luacheck gate clean instead of reporting
-- it as an undefined global in each port.
globals = { "vim" }
