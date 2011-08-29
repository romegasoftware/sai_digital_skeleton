#Which version of Ruby do we want to use with rvm?
RVM_RUBY_VERSION = 'ree'

#Change this if your RVM is in a different location
RVM_SCRIPT_LOCATION = '~/.rvm/scripts/rvm'

namespace :sai do

  desc 'Initialize project.'
  task :initialize do
    #This task requires a UNIX-like operating system to run. So, if you're running this
    #inside Windows, you'd better be using Cygwin or this won't work.
    #Some of this can be re-written to work across *all* platforms, but since I want to
    #run RVM, I figured there was really no point. Sed is faster than Ruby anyway.


    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # COMMAND SEQUENCE ORDER IS EXTREMELY IMPORTANT!
    # DO NOT MOVE STUFF AROUND UNLESS YOU KNOW WHAT YOU ARE DOING!
    #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! 


    puts "What do you want to call your project?"
    puts "Use a name like you would when starting a new rails project (e.g. new_app)"
    puts "Camelcase (e.g. NewApp) will do as well:"
    
    #TODO: Make transliteration work for our international friends.
    project_name = STDIN.gets.underscore.gsub(/\s+/,'')

    puts ""
    puts "Creating RVM project file."
    %x{cd #{Rails.root.to_s}}
    %x{#{RVM_SCRIPT_LOCATION} --rvmrc --create #{RVM_RUBY_VERSION}@#{project_name}}
    

    #TODO: Figure out a safe way to implement the following
    #puts ""
    #puts "Renaming project directory."
    #new_project_dir = ::Rails.root.to_s.split('/')
    #new_project_dir[-1] = project_name
    #%x{mv #{::Rails.root.to_s} #{::Rails.root.to_s.join('/')}}

    puts ""
    puts "Replacing skeleton defaults with your project's name."

     
    %x{find #{::Rails.root.to_s}/./ -type f -print0 | xargs -0 sed -i 's/sai_digital_skeleton/#{project_name}/'}
    %x{find #{::Rails.root.to_s}/./ -type f -print0 | xargs -0 sed -i 's/SaiDigitalSkeleton/#{project_name.classify}/'}
   
    
    puts ""
    puts "If you didn't see any errors, you should be good to go."
    puts "You will need to rename your project folder to #{project_name}."
    puts "Then, you will need to run bundle install rails (probably)."
  end

end
