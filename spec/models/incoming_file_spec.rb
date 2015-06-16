require 'spec_helper'

describe IncomingFile do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_many(:incoming_file_records) }
    it { should have_many(:ecol_remitters)}
    it { should belong_to(:sc_service) }
    it { should belong_to(:incoming_file_type) }
  end

  context 'validation' do

    it { should validate_presence_of(:file) }

    it "throws error for file if it is in black list" do
      file = File.open('Test2.exe', "w")
      incoming_file = Factory.build(:incoming_file,:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)))
      incoming_file.save.should be_false
      incoming_file.errors.messages.should == {:file=>["You are not allowed to upload \"exe\" files, allowed types: txt", "can't be blank"]}
      incoming_file.errors.messages.should_not be_blank
      FileUtils.rm_f 'Test2.exe'
    end

    it "should throw error if file has invalid extension" do
      file = File.open('Test2.exe.txt', "w")
      incoming_file = Factory.build(:incoming_file,:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)))
      incoming_file.save.should be_false
      incoming_file.errors.messages.should == { :file => ["Invalid file extension"] }
      incoming_file.errors.messages.should_not be_blank
      FileUtils.rm_f 'Test2.exe.txt'
    end

    it "should not throw error if file has correct extension" do
      file = File.open('Test2.txt', "w")
      incoming_file = Factory.build(:incoming_file, :file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)))
      incoming_file.save.should be_true
      incoming_file.errors.messages.should be_empty
      FileUtils.rm_f 'Test2.txt'
    end

    it "should not allow same file to be uploaded again" do 
      file = Factory(:incoming_file, :file_name => nil)
      file2 = Factory.build(:incoming_file, :file_name => nil)
      file2.save.should be_false
      file2.errors.messages.should == { :file => ["'#{file.file.file.original_filename}' already exists"] }
      file2.errors.messages.should_not be_blank
    end
  end

  context "update_size_and_file_name" do
    it "should update size and file_name" do
      file = Factory(:incoming_file, :file_name => nil)
      file.size_in_bytes.should == file.file.size
      file.file_name.should == file.file.filename
    end
  end

  context "Job Status" do 
    it "should return values according to the status" do
      file = Factory.build(:incoming_file, :status => 'N')
      file.job_status.should == 'Not Started'
      file = Factory.build(:incoming_file, :status => 'I')
      file.job_status.should == 'In Progress'
      file = Factory.build(:incoming_file, :status => 'C')
      file.job_status.should == 'Completed'
      file = Factory.build(:incoming_file, :status => 'F')
      file.job_status.should == 'Failed'
    end
  end

  context "upload_time" do 
    it "should equal to the difference between ended_at and started_at" do 
      incoming_file = Factory(:incoming_file, :started_at => Time.zone.now, :completed_at => Time.zone.now.advance(:minutes => 3))
      incoming_file.upload_time.should == (incoming_file.ended_at - incoming_file.started_at).round(2)
    end
  end
end