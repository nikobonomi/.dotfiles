local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
    "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⢿⡤⠤⠬⣉⣉⣿⣿⣆⣀⣠⣤⡀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣶⣦⡄⢠⡄⠀⠀⠀⠀⠀⣤⢶⡿⣾⣿⣿⡿⡷⢦⣾⠿⠿⠛⠻⣿⡿⠆⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣎⡒⠁⢠⢊⠕⠛⠭⣑⠶⠶⣭⣠⠍⣓⠉⠀⠀⣩⣴⠟⠁⠀⠀⠀⠀⠈⠃⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⢲⣒⣄⡀⠀⠀⠀⠀⠀⠀⠀⢇⣇⣀⡏⠜⠂⠤⡰⠁⣰⡿⣿⣿⣽⡔⠁⣠⡾⠋⠁⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡞⡰⠁⡠⢒⡭⢕⡢⢄⣠⣤⠒⣭⣵⣞⢶⣯⣝⣒⣤⡥⢤⣿⣿⣿⣿⡿⣿⣿⢿⡻⣽⢿⣿⣽⢲⡦⣤⣀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢯⣇⢰⢡⠧⡀⣠⠞⣩⣭⣶⣭⡒⢭⡿⣿⣞⠛⣯⣷⣾⣿⣿⣿⣟⣿⣿⣽⡞⣿⡱⣏⣻⣭⣷⡻⠾⣿⣿⣷⣄⣴⣤⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠟⢼⡀⢠⠃⣼⣿⣿⣿⣿⣷⠀⠳⡻⡟⣾⣮⡻⢿⣯⣿⣿⣿⠳⣿⣿⣿⣯⠟⠛⠉⠉⠀⠀⠀⠈⠉⠁⠉⢿⡿⠂  ",
    "⠀⠀⡀⠀⠀⠀⠀⢀⣀⠤⡔⡲⠽⢦⣀⠏⠺⣄⣿⣷⣾⣷⣷⣿⣧⣀⠙⠤⣟⣛⣛⣶⣙⣛⡭⠕⠊⠋⢻⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⢰⣽⠿⣷⡴⣶⣭⣷⣾⣭⡿⠈⢦⣀⣷⣄⢠⣾⣿⣿⣿⣿⣿⣿⣷⣽⣯⣶⣦⣄⡀⠀⠉⠹⢦⣴⣠⡀⡀⡅⠹⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠘⠷⡀⢈⣣⡻⣜⣫⡁⠀⠀⢀⣀⣩⣭⣼⣾⡿⣟⢿⡯⢿⣳⣟⣾⡽⣏⢿⡼⣝⣳⢖⡤⣀⠀⠈⠑⠧⣁⢀⠂⠙⠱⣤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠹⣳⣿⣿⣮⣽⠶⠾⠛⠛⣩⣟⣟⡳⣭⢛⡿⢾⣹⢟⣽⣯⣿⣽⢾⠧⢟⣭⢯⢟⡾⣽⣫⢶⢤⣄⡀⠙⢣⡦⠖⢋⡥⢭⡓⢄⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠉⠉⣮⣒⡶⡄⢀⣴⡺⣭⠷⣎⢷⣱⠯⠚⣁⣼⡾⣿⣿⣷⣿⣿⠀⠀⠀⠉⠙⠚⠵⢏⣯⡷⡾⣽⠛⠉⠑⠢⣌⠛⢏⠈⠳⠙⢆⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⢿⠟⢯⣵⣿⣳⣽⢲⡏⠟⠚⣁⣴⠾⠛⠛⠿⣿⣷⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⢿⣶⣤⣀⠀⠑⢄⠃⠀⠀⡠⠃⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⢠⡞⠉⢷⣯⠞⡺⠕⣀⣴⠾⠋⠁⠀⠀⠀⠀⠈⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠛⠷⠦⠵⠖⠋⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠈⠳⡀⠈⢯⣩⣴⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠙⣖⣭⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠻⢿⡿⡇⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣜⣽⣾⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠋⠙⠀⠀⠀"
}


-- Set menu
dashboard.section.buttons.val = {
    dashboard.button("f", "󰈞  > Find file", ":Telescope find_files<CR>"),
    dashboard.button("g", "󰷊  > Find in files", ":Telescope live_grep<CR>"),
    dashboard.button("e", "󰙅  > File explorer", ":NvimTreeToggle<CR>"),
    dashboard.button("s", "󰚰  > Update plugins", ":PackerSync<CR>"),
    dashboard.button("q", "󰣙  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)
alpha.setup(dashboard.config)