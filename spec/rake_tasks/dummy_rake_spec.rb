require 'rake'

describe 'Dummy rake' do
  describe "dummy:do_something_once" do
    let(:task_name) { "dummy:do_something_once" }
    let(:task) { Rake::Task[task_name] }

    before do
      # clear the rake task from the memory to ensure it's not loaded multiple times
      Rake::Task[task_name].clear if Rake::Task.task_defined?(task_name)

      # loaad the rake task only once
      Rake.load_rakefile("tasks/dummy.rake")
      Rake::Task.define_task(:environment)
    end

    after do
      Rake::Task[task_name].reenable

      # reset the state that was changed by the rake task execution
      DummyOutput.count = 0
    end

    it "calls the rake task once (increases counter by one)" do
      expect { task.invoke }.to_not raise_error
      expect(DummyOutput.count).to eq(1)
    end

    it "calls the rake task once again (increases counter by one)" do
      expect { task.invoke }.to_not raise_error
      expect(DummyOutput.count).to eq(1)
    end
  end
end
