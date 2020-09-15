function InstallRenv(){
  if ! [ -x "$(which rbenv)" ]; then
    Status "👾 Install Ruby"
    sudo apt install rbenv -y
  else
    Status "💀 Rbenv alredy installed - Version $(rbenv -v)... skipping"
  fi
}

function InstallRubyBuild(){
  if ! [ -x "$(which ruby-build)" ]; then
    Status "👾 Install Ruby-build"
    sudo apt install ruby-build -y
  else
    Status "💀 Ruby-build alredy installed - Version $(ruby-build --version)... skipping"
  fi
}

function InstallRuby(){
  if ! [ -x "$(command -v ruby)" ]; then
    Info "📝 Check if Rbenv alredy installed"
    if ! [ -x "$(command -v rbenv)" ]; then
      Status "👾 Install Ruby with Rbenv - Version $(rbenv -v)"
      rbenv install $RUBY_VERSION && rbenv global $RUBY_VERSION
    else
      Status "👾 Install Ruby"
      sudo apt-get install -y ruby
    fi
  else
    Status "💀 Ruby alredy installed - Version $(ruby -v)... skipping"
  fi
}

function SetupRuby(){
  Status "👾 Setup Ruby"
  sudo gem install bundler rake
}

function Ruby(){
  InstallRenv
  InstallRubyBuild
  InstallRuby
  SetupRuby
}
