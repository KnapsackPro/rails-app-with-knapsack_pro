require 'rake'

describe 'Dummy rake' do
  describe "dummy:do_something_once" do
    let(:task_name) { "dummy:do_something_once" }
    let(:task) { Rake::Task[task_name] }

    context 'when Rake.application.rake_require is used to load rake task' do
      before do
        Rake.application.rake_require("tasks/dummy")
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

    context 'when Rake.load_rakefile is used to load rake task' do
      before(:all) do # all must be used to ensure rake task is loaded only once
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
end
