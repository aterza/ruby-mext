
desc 'plot all plots'
task :plot => ['plot:expon', 'plot:line']

namespace :plot do

  task :create_output_dir do
    unless Dir.exists?(Mext::Gruff::Plotter::OUTPUT_PATH)
      mkdir_p Mext::Gruff::Plotter::OUTPUT_PATH
    end
  end

end
