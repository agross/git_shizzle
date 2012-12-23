require File.join(File.dirname(__FILE__), '../spec_helper')
require 'git_shizzle'

describe "Indexes specified on the CLI" do

  let(:git) { GitShizzle::Git::Git.new(repo) }
  subject { GitShizzle::QuickGit.new(git) }
  let(:number_of_untracked_files) { 10 }

  before (:each) do
    number_of_untracked_files.times.each do |i|
      create "untracked-%02d" % (i + 1)
    end
  end

  def assert_index_status(*status)
    number_of_untracked_files.times.each do |i|
      expected_status = status[i] || status[-1]
      git.status[i].index_status.should == expected_status
    end
  end

  describe "indexes" do
    context "when no index is specified" do
      it "should fail" do
        expect { subject.track }.to raise_error(GitShizzle::IndexSpecifications::NoFilesError, "No files for action track.")
      end
    end

    context "when specifying an index" do
      it "should operate on the file mapped to the index" do
        subject.track 1

        assert_index_status :added, :untracked
      end
    end

    context "when specifying a string index" do
      it "should operate on the file mapped to the index" do
        subject.track "1"

        assert_index_status :added, :untracked
      end
    end

    context "when specifying a non-numeric index" do
      it "should fail" do
        expect { subject.track "a" }.to raise_error(GitShizzle::IndexSpecifications::IndexParserError, /Could not parse index 'a'/)

        assert_index_status :untracked
      end
    end

    context "when specifying an index outside of the range of available indexes" do
      it "should fail" do
        expect { subject.track 42 }.to raise_error(GitShizzle::IndexSpecifications::IndexSpecificationError, 'Could not determine files for indexes: 42')

        assert_index_status :untracked
      end
    end

    context "when specifying the same index twice" do
      it "should operate on the file mapped to the index once" do
        subject.track 1, 1

        assert_index_status :added, :untracked
      end
    end
  end

  describe "ranges" do
    context "when a specifying an inclusive range" do
      it "should operate on each file in the range" do
        subject.track "1..3"

        assert_index_status :added, :added, :added, :untracked
      end
    end

    context "when a specifying an exclusive range" do
      it "should operate on each file in the range" do
        subject.track "1...3"

        assert_index_status :added, :added, :untracked
      end
    end

    context "when specifying a non-numeric range" do
      it "should fail" do
        expect { subject.track "a..z" }.to raise_error(GitShizzle::IndexSpecifications::IndexParserError, /Could not parse index 'a\.\.z'/)

        assert_index_status :untracked
      end
    end

    context "when specifying a non-numeric exclusive range" do
      it "should fail" do
        expect { subject.track "a...z" }.to raise_error(GitShizzle::IndexSpecifications::IndexParserError, /Could not parse index 'a\.\.\.z'/)

        assert_index_status :untracked
      end
    end

    context "when specifying a range outside of the range of available indexes" do
      it "should fail" do
        expect { subject.track "11..15" }.to raise_error(GitShizzle::IndexSpecifications::IndexSpecificationError, 'Could not determine files for indexes: 11, 12, 13, 14, 15')

        assert_index_status :untracked
      end
    end

    context "when specifying a range partly outside of the range of available indexes" do
      it "should fail" do
        expect { subject.track "9..15" }.to raise_error(GitShizzle::IndexSpecifications::IndexSpecificationError, 'Could not determine files for indexes: 11, 12, 13, 14, 15')

        assert_index_status :untracked
      end
    end

    context "when specifying overlapping index and range" do
      it "should operate on each file in the range once" do
        subject.track 1, 2, 3, "1..3", "1...3"

        assert_index_status :added, :added, :added, :untracked
      end
    end
  end

  describe "current directory" do
    context "when a specifying the current directory" do
      it "should operate on each file" do
        subject.track "."

        assert_index_status :added
      end
    end

    context "when a specifying the current directory and a file index" do
      it "should operate on each file" do
        subject.track 1, "."

        assert_index_status :added
      end
    end

    context "when a specifying the current directory and a file index outside of the range of available indexes" do
      it "should operate on each file" do
        expect { subject.track 42, "." }.to raise_error(GitShizzle::IndexSpecifications::IndexSpecificationError, 'Could not determine files for indexes: 42')

        assert_index_status :untracked
      end
    end
  end
end
