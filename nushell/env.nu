# Nushell Environment Config File
#
# version = "0.90.2"

# def create_left_prompt [] {
#     let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
#         null => $env.PWD
#         '' => '~'
#         $relative_pwd => ([~ $relative_pwd] | path join)
#     }
#
#     let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
#     let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
#     let path_segment = $"($path_color)($dir)"
#
#     $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
# }
#
# def create_right_prompt [] {
#     # create a right prompt in magenta with green separators and am/pm underlined
#     let time_segment = ([
#         (ansi reset)
#         (ansi magenta)
#         (date now | format date '%x %X %p') # try to respect user's locale
#     ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
#         str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")
#
#     let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
#         (ansi rb)
#         ($env.LAST_EXIT_CODE)
#     ] | str join)
#     } else { "" }
#
#     ([$last_exit_code, (char space), $time_segment] | str join)
# }

# Use nushell functions to define your right and left prompt
# $env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
# $env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "" }
$env.PROMPT_INDICATOR_VI_INSERT = {|| "" }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "" }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}
# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin:/opt/homebrew/sbin:/Users/philipp/.cargo/bin:/Users/philipp/programming/go/bin:/usr/local/bin:/Users/philipp/.local/bin:/opt/homebrew/Caskroom/miniconda/base/bin:/Users/philipp/.modular/pkg/packages.modular.com_mojo/bin')

# Modular and Mojo
$env.MODULAR_HOME = "/Users/philipp/.modular"

# GOPATH
$env.GOPATH = "/Users/philipp/programming/go"

$env.icloud = `~/Library/Mobile Documents/com~apple~CloudDocs/`
$env.EDITOR = '/opt/homebrew/bin/nvim'
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"
$env.ZELLIJ_CONFIG_FILE = $"($env.HOME)/.config/zellij/config.kdl"
$env.FZF_DEFAULT_OPTS = "--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"

mkdir ~/.cache/starship
/opt/homebrew/bin/starship init nu | save -f ~/.cache/starship/init.nu

mkdir ~/.local/share/atuin/
/opt/homebrew/bin/atuin init nu | save -f ~/.local/share/atuin/init.nu

zoxide init nushell | save -f ~/.zoxide.nu