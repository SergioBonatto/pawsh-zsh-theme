# ᓚᘏᗢ Pawsh ZSH Theme

A kawaii zsh theme for oh-my-zsh featuring an adorable cat prompt (`ᓚᘏᗢ`) that changes color based on the last command's exit status. Perfect for adding some cuteness to your terminal experience!

![Pawsh Theme Example](https://github.com/SergioBonatto/pawsh-zsh-theme/blob/main/assets/example.png?raw=true)

## Features

- 🐱 **Kawaii cat prompt** - Shows a green cat (`ᓚᘏᗢ`) for successful commands and red for failed ones
- 📁 **Current directory display** - Shows the current working directory in cyan
- 🌿 **Git integration** - Displays git branch and status information
- 🎨 **Color-coded status** - Visual feedback for command success/failure
- ✨ **Minimalist design** - Clean and simple interface

## Installation

### Method 1: Using Oh My Zsh Custom Themes

1. Clone this repository:
   ```bash
   git clone https://github.com/SergioBonatto/pawsh-zsh-theme.git
   ```

2. Copy the theme file to your oh-my-zsh custom themes directory:
   ```bash
   cp pawsh-zsh-theme/pawsh.zsh-theme $ZSH_CUSTOM/themes/
   # or alternatively
   # cp pawsh-zsh-theme/pawsh.zsh-theme ~/.oh-my-zsh/themes/
   ```

3. Set pawsh as your default theme by editing `~/.zshrc`:
   ```bash
   ZSH_THEME="pawsh"
   ```

4. Reload your zsh configuration:
   ```bash
   source ~/.zshrc
   ```

### Method 2: Direct Download

1. Download the `pawsh.zsh-theme` file directly
2. Place it in your oh-my-zsh themes directory (`~/.oh-my-zsh/themes/` or `$ZSH_CUSTOM/themes/`)
3. Update your `~/.zshrc` file to use the theme
4. Restart your terminal or run `source ~/.zshrc`

## Requirements

- [Oh My Zsh](https://ohmyz.sh/) framework
- A terminal that supports Unicode characters
- Git (for git status features)

## Customization

The theme uses the following color scheme:
- **Green cat** (`ᓚᘏᗢ`) - Successful command execution
- **Red cat** (`ᓚᘏᗢ`) - Failed command execution
- **Cyan** - Current directory
- **Blue/Red** - Git branch information
- **Yellow** - Git dirty status indicator

You can modify these colors by editing the `pawsh.zsh-theme` file.

## Contributing

Feel free to submit issues, feature requests, and pull requests to make this theme even more kawaii!

## License

[MIT](LICENSE)

---

*Made with ♥ for all the cat lovers and kawaii enthusiasts out there!*
