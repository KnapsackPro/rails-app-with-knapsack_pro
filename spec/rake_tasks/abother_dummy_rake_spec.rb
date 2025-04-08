require 'rake'

describe 'Another dummy rake' do
  describe "another_dummy:do_something_once" do
    let(:task_name) { "another_dummy:do_something_once" }
    let(:task) { Rake::Task[task_name] }

    context 'when Rake.load_rakefile is used to load rake task' do
      before(:all) do # :all must be used to ensure the rake task is loaded only once
        Rake.load_rakefile("tasks/another_dummy.rake")
        Rake::Task.define_task(:environment)
      end

      after do
        Rake::Task[task_name].reenable

        # reset the state that was changed by the rake task execution
        AnotherDummyOutput.count = 0
      end

      it "calls the rake task once (increases counter by one)" do
        expect { task.invoke }.to_not raise_error
        expect(AnotherDummyOutput.count).to eq(1)
      end

      it "calls the rake task once again (increases counter by one)" do
        expect { task.invoke }.to_not raise_error
        expect(AnotherDummyOutput.count).to eq(1)
      end
    end
  end
end
