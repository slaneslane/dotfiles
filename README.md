# dotfiles
# Copy dotfiles directory into your home directory first.
# Then create symbolic link in your home directory for .bashrc, .vimrc and .tmux.conf
# using following commands:

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf

# Powerline is commented out (!) in those fiels: .super and .exports as some icons are not generated on my remote maschine correctly.
