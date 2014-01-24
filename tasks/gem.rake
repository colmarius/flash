desc "Build gem"
task 'gem:build' do
  sh 'gem build flash.gemspec'
end

desc "Release gem"
task 'gem:release' => 'gem:build' do
  sh "gem push flash-#{Flash::VERSION}.gem || echo 'error'"
end

desc "Clean gem"
task 'gem:clean' do
  sh "rm flash-#{Flash::VERSION}.gem"
end
