# Ressources :
# https://ruby-doc.org/core-2.5.1/Dir.html
# https://ruby-doc.org/core-2.3.0/IO.html

# Placer dans le fichier .bashprofile : 
# alias init_repo="ruby /home/julien/THP/09_discovering_ruby/lib/init_repo.rb"


def init_repo( repo_name )
  # Dossier de travail 
  project_path = "./" 
  git_account = "140ch204"

  $repo_name = repo_name.downcase
  
  # Ajustement du project_path
  (project_path[-1] != "/")? project_path += project_path + "/" : ""

  # Chemin complet du repository
  $repo_full_path = project_path + $repo_name + "/"

  # Création du dossier du repository
  mkdir("")

  # Création du Gemfile
  new_file("Gemfile","source 'https://rubygems.org'
ruby '2.5.1'
gem 'rspec'
gem 'pry'
gem 'rubocop', '~> 0.57.2'
gem 'nokogiri'
gem 'rest-client'
gem 'dotenv'")

  # Création du .env
  new_file(".env","FIRST_KEY='mykey'")

  # Création du gitignore
  new_file(".gitignore",".env")

  # Création du app.rb
  new_file("app.rb","
require 'pry'   
require_relative './lib/app'
class Event
  def perform
  end
end
binding.pry
  ")

  # Création du dossier lib du repo
  mkdir("lib")
  
  # Création du readme.md
  new_file("readme.md","Fichier Readme du Projet #{$repo_name}")

 # Rentrer dans le projet
  Dir.chdir(repo_name)

  system("rspec --init")

  # Gestion GitHub :
  system("git init")
  system("git remote add origin https://github.com/#{git_account}/#{repo_name}.git")
  system("git push --set-upstream origin master")
  system("git add .")
  system("git commit -m 'init'")
  puts("Connexion à Github pour le push :"  )
  system("git push")
  puts("Initialisation terminée :-) "  )
  
end

def mkdir(dir_name)
  # Créé un nouveau dossier
  begin
    dir_full_path = $repo_full_path + dir_name
    Dir.mkdir(dir_full_path)
    puts  dir_full_path + " : dossier créé"
  rescue => e
    puts dir_full_path + " : ! dossier déjà existant"
  end
end

def new_file(file_name,content)
  # Créé un nouveau fichier et son contenu
  begin
    file_full_path = $repo_full_path + file_name
    file = File.open(file_full_path, "a")
    file.puts(content)
    file.close
    puts file_full_path + " : fichier créé"
  rescue => e
    puts file_full_path + " : ! fichier non créé"
  end

end

def get_repository_name
  # Récupère le nom du répository dans le terminal 
  abort("mkdir: missing input") if ARGV.empty?
  ARGV.first
end

puts init_repo(get_repository_name)

