require 'rspec/core/rake_task'
require 'rake/packagetask'

$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'cookbook/version'

GEMS_DIR = 'vendor/gems'
GH_PAGES_DIR = 'gh-pages'
HOMEBREW_FORMULAE_DIR = 'homebrew-formulae'

namespace :gems do
  desc 'Vendorize dependencies'
  task :vendorize do
    system('vendor/vendorize', GEMS_DIR)
  end

  desc 'Remove vendorized dependencies'
  task :clean do
    if Dir.exists?(GEMS_DIR)
      FileUtils.rm_r(GEMS_DIR)
    end
  end
end

desc 'Push new release'
task :release => ['release:build', 'release:push', 'release:clean']

namespace :release do
  desc 'Build a new release'
  task :build => ['tarball:build', 'homebrew:build']

  desc 'Push sub-repositories'
  task :push => ['tarball:push', 'homebrew:push']

  desc 'Clean all build artifacts'
  task :clean => ['gems:clean', 'tarball:clean', 'homebrew:clean']
end

namespace :homebrew do
  desc 'Generate homebrew formula and add it to the repo'
  task :build => ['checkout', 'formula:build', 'commit']

  desc 'Checkout homebrew repo locally'
  task :checkout do
    `git clone git@github.com:thoughtbot/homebrew-formulae.git #{HOMEBREW_FORMULAE_DIR}`
  end

  desc 'Check in the new Homebrew formula'
  task :commit do
    Dir.chdir(HOMEBREW_FORMULAE_DIR) do
      `git add Formula/liftoff.rb`
      `git commit -m "liftoff: Release version #{Cookbook::VERSION}"`
    end
  end

  desc 'Push homebrew repo'
  task :push do
    Dir.chdir(HOMEBREW_FORMULAE_DIR) do
      `git push`
    end
  end

  desc 'Remove Homebrew repo'
  task :clean do
    if Dir.exists?(HOMEBREW_FORMULAE_DIR)
      FileUtils.rm_rf(HOMEBREW_FORMULAE_DIR)
    end
  end

  namespace :formula do
    desc 'Build homebrew formula'
    task :build do
      formula = File.read('homebrew/liftoff.rb')
      formula.gsub!('__VERSION__', Cookbook::VERSION)
      formula.gsub!('__SHA__', `shasum #{GH_PAGES_DIR}/Cookbook-#{Cookbook::VERSION}.tar.gz`.split.first)
      File.write("#{HOMEBREW_FORMULAE_DIR}/Formula/cookbook.rb", formula)
    end
  end
end

namespace :tarball do
  desc 'Build the tarball'
  task :build => ['checkout', 'package', 'move', 'commit']

  desc 'Checkout gh-pages'
  task :checkout do
    `git clone --branch gh-pages git@github.com:maschall/cookbook.git #{GH_PAGES_DIR}`
  end

  desc 'Move tarball into gh-pages'
  task :move do
    FileUtils.mv("pkg/Cookbook-#{Cookbook::VERSION}.tar.gz", GH_PAGES_DIR)
  end

  desc 'Check in the new tarball'
  task :commit do
    Dir.chdir(GH_PAGES_DIR) do
      `git add Cookbook-#{Cookbook::VERSION}.tar.gz`
      `git commit -m "Release version #{Cookbook::VERSION}"`
    end
  end

  desc 'Push the gh-pages branch'
  task :push do
    Dir.chdir(GH_PAGES_DIR) do
      `git push`
    end
  end

  desc 'Remove gh-pages and pkg directories'
  task :clean do
    if Dir.exists?(GH_PAGES_DIR)
      FileUtils.rm_rf(GH_PAGES_DIR)
    end

    if Dir.exists?('pkg')
      FileUtils.rm_rf('pkg')
    end
  end

  Rake::PackageTask.new('Cookbook', Cookbook::VERSION) do |p|
    p.need_tar_gz = true
    p.package_files.include('src/**/*')
    p.package_files.include('defaults/**/*')
    p.package_files.include('lib/**/*')
    p.package_files.include('vendor/**/*')
    p.package_files.include('man/**/*')
    p.package_files.include('LICENSE.txt')
  end
end

desc 'Run tests'
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
