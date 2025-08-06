# ᓚᘏᗢ Pawsh ZSH Theme

Konnichiwa, terminal-tomodachi! Pawsh is a super kawaii zsh theme for oh-my-zsh, inspired by Japanese neko culture. Your prompt becomes a cute cat face (`ᓚᘏᗢ`) that changes color depending on your command's mood. Make your terminal more genki and stylish, ne!

## Features (Kawaii pointo!)

- Cat face prompt (`ᓚᘏᗢ`) changes color: green for happy (success), red for sad (fail). Cat-chan always watching your code, desu!
- Root user indicator: magenta `#` appears if you are root, so you feel like a real system sensei.
- Current directory always in cool cyan, so you never get lost, senpai.
- Python virtualenv name shown in blue bold if active, for your data science dojo.
- Vi mode indicator: `[N]` in red bold when in normal mode, for vim-ninja moves.
- Git branch and status: blue/red for branch, yellow for dirty status, so you know if your code is sugoi or needs fixing.
- Time displayed on the right (white bold), so you never miss your next anime episode.
- Color feedback for command status, like a real transformation scene!
- Minimalist and clean, but full of kawaii spirit.
- Hooks for instant vi mode updates (using ZLE), so your prompt is always in sync with your ninja moves.

## Installation (Setsumei time!)

1. Clone this repo, onegai:
   ```bash
   git clone https://github.com/SergioBonatto/pawsh-zsh-theme.git
   ```
2. Copy the theme to your oh-my-zsh custom themes folder:
   ```bash
   cp pawsh-zsh-theme/pawsh.zsh-theme $ZSH_CUSTOM/themes/
   # or
   # cp pawsh-zsh-theme/pawsh.zsh-theme ~/.oh-my-zsh/themes/
   ```
3. Open your `~/.zshrc` and set the theme:
   ```bash
   ZSH_THEME="pawsh"
   ```
4. Reload your zsh config, ganbatte:
   ```bash
   source ~/.zshrc
   ```

## Requirements (Daijoubu?)

- Oh My Zsh framework
- Terminal with Unicode support (for neko face, of course)
- Git (for git status, sugoi!)

## Customization (Omakase!)

Color scheme:
- Green cat: Command success, cat is happy! Sugoi!
- Red cat: Command fail, cat is a bit sad. Ganbatte!
- Cyan: Current directory, always cool.
- Blue/Red: Git branch, for your code ninja moves.
- Yellow: Git dirty status, like a warning from sensei.
- Magenta: Root user, for system master mode.
- Blue bold: Python virtualenv, for your data science journey.
- Red bold: Vi mode, for vim warriors.

Want to change colors? Edit `pawsh.zsh-theme` and make your own kawaii style, ne!

## Contributing (Tomodachi welcome!)

Sugoi! If you have ideas, issues, or want to help, open an issue or PR. Let's make Pawsh even more kawaii together, minna-san!

## License (Free as a stray cat)

MIT

---

*Made with neko love for all code sensei and kawaii enthusiasts! Pawsh brings neko power and genki vibes to every command. Happy coding, nya~!*
