# Runs the command and prints a notification
def execute(cmd)
  if system(cmd)
    n 'Build succeeded', 'stack', :success
  else
    n 'Build failed', 'stack', :failed
  end
end

def run_all_tests
  execute %{
    stack test
  }
end

guard :shell do
  watch(%r{.*\.cabal$})          { run_all_tests }
  watch(%r{.*\.hs$})             { run_all_tests }
end
