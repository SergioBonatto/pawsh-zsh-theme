# ᓚᘏᗢ Pawsh ZSH Theme

Konnichiwa, terminal-tomodachi! Pawsh is a super kawaii zsh theme inspired by Japanese neko culture. Your prompt becomes a cute cat face (`ᓚᘏᗢ`) that changes color depending on your command's mood.

![Pawsh Theme Example](https://github.com/SergioBonatto/pawsh-zsh-theme/blob/main/assets/example.png?raw=true)

---

# Features (Kawaii pointo!)

* Cat face prompt (`ᓚᘏᗢ`) changes color: green for success, red for failure.
* Root user indicator: magenta `#` when running as root.
* Current directory displayed in cyan.
* Python virtualenv name shown when active.
* Vi mode indicator `[N]` when in normal mode.
* Git branch and repository status information.
* Clean and minimal prompt layout.
* ZLE hooks for instant vi-mode updates.

---

# Installation (Setsumei time!)

Clone the repository:

```bash
git clone https://github.com/SergioBonatto/pawsh-zsh-theme.git
```

Move the theme file somewhere in your zsh configuration:

```bash
mkdir -p ~/.zsh/themes
cp pawsh-zsh-theme/pawsh.zsh-theme ~/.zsh/themes/
```

Load the theme in your `~/.zshrc`:

```bash
source ~/.zsh/themes/pawsh.zsh-theme
```

Reload the shell configuration:

```bash
source ~/.zshrc
```

---

# Requirements

* `zsh`
* Terminal with Unicode support (for the cat face)
* `git` for repository information

---

# Customization (Omakase!)

Color scheme used by default:

* Green cat: last command succeeded
* Red cat: last command failed
* Cyan: current directory
* Blue / Red: git branch information
* Yellow: git dirty status
* Magenta: root user indicator
* Blue bold: Python virtualenv
* Red bold: vi normal mode indicator

To customize colors or prompt layout, edit the `pawsh.zsh-theme` file.

---

# Contributing

Suggestions, improvements, and pull requests are welcome.

---

# License

MIT

---

Made with neko energy for terminal users who like minimal prompts with a bit of personality.
