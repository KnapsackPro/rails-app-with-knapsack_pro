require 'rake'

describe 'Dummy rake' do
  describe "dummy:do_something_once" do
    let(:task_name) { "dummy:do_something_once" }
    let(:task) { Rake::Task[task_name] }

    before do
      # Clear rake task from memory if it was already loaded.
      # This ensures rake task is loaded only once in knapsack_pro Queue Mode.
      Rake::Task[task_name].clear if Rake::Task.task_defined?(task_name)

      # loaad rake task only once here
      Rake.application.rake_require("tasks/dummy")
      Rake::Task.define_task(:environment)
    end

    it "does something once" do
      expect { task.invoke }.to_not raise_error
      expect(DummyOutput.count).to eq(1)
    end
  end
end
