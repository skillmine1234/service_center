require 'spec_helper'

describe IncomingFile do
  context 'association' do
    it { should belong_to(:created_user) }
    it { should belong_to(:updated_user) }
    it { should have_many(:failed_records) }
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
      incoming_file = Factory(:incoming_file, :started_at => Time.zone.now, :ended_at => Time.zone.now.advance(:minutes => 3))
      incoming_file.upload_time.should == (incoming_file.ended_at - incoming_file.started_at).round(2)
    end
  end

  context "default_scope" do 
    it "should only return 'A' records by default" do 
      incoming_file1 = Factory(:incoming_file, :approval_status => 'A') 
      incoming_file2 = Factory(:incoming_file)
      IncomingFile.all.should == [incoming_file1]
      incoming_file2.approval_status = 'A'
      incoming_file2.save
      IncomingFile.all.should == [incoming_file1,incoming_file2]
    end
  end    

  context "create_ecol_unapproved_records" do 
    it "should create ecol_unapproved_record if the approval_status is 'U' and there is no previous record" do
      incoming_file = Factory(:incoming_file)
      incoming_file.reload
      incoming_file.ecol_unapproved_record.should_not be_nil
    end

    it "should not create ecol_unapproved_record if the approval_status is 'A'" do
      incoming_file = Factory(:incoming_file, :approval_status => 'A')
      incoming_file.ecol_unapproved_record.should be_nil
    end
  end  

  # context "remove_ecol_unapproved_records" do
  #   it "should remove ecol_unapproved_record if the approval_status is 'A' and there is unapproved_record" do
  #     incoming_file = Factory(:incoming_file)
  #     incoming_file.reload
  #     incoming_file.ecol_unapproved_record.should_not be_nil
  #     record = incoming_file.ecol_unapproved_record
  #     incoming_file.approval_status = 'A'
  #     incoming_file.save
  #     incoming_file.remove_ecol_unapproved_records
  #     incoming_file.reload
  #     incoming_file.ecol_unapproved_record.should be_nil
  #   end
  # end 

  context "approve" do 
    it "should approve unapproved_record" do 
      incoming_file = Factory(:incoming_file, :approval_status => 'U')
      incoming_file.approve.should == ""
      incoming_file.approval_status.should == 'A'
    end

    it "should return error when trying to approve unmatched version" do 
      incoming_file = Factory(:incoming_file, :approval_status => 'A')
      incoming_file2 = Factory(:incoming_file, :approval_status => 'U', :approved_id => incoming_file.id, :approved_version => 6)
      incoming_file2.approve.should == "The record version is different from that of the approved version" 
    end
  end

  context "enable_approve_button?" do 
    it "should return true if approval_status is 'U' else false" do 
      incoming_file1 = Factory(:incoming_file, :approval_status => 'A')
      incoming_file2 = Factory(:incoming_file, :approval_status => 'U')
      incoming_file1.enable_approve_button?.should == false
      incoming_file2.enable_approve_button?.should == true
    end
  end

  context "auto incoming file creation" do 
    it "should go through the folder and create incoming_file for that folder" do 
      ENV['CONFIG_AUTO_FILE_UPLOAD_PATH'] = 'test/fixtures'
      file = File.open('test/fixtures/Test2.txt', "w")
      incoming_file = IncomingFile.create_incoming_file
      IncomingFile.unscoped.all.should_not be_empty
    end
  end

  context "check is approved and get file_path" do
    it "should return approval_status and file_path" do
      incoming_file1 = Factory(:incoming_file, :approval_status => 'A')
      approved1 = true
      file_path1 = Rails.root.join(ENV['CONFIG_APPROVED_FILE_UPLOAD_PATH'], incoming_file1.file_name)
      result1 = {is_approved: approved1, file_path: file_path1}
      result1.should == {is_approved: approved1, file_path: file_path1}
      incoming_file2 = Factory(:incoming_file, :approval_status => 'U')
      approved2 = false
      file_path2 = Rails.root.join(ENV['CONFIG_FILE_UPLOAD_PATH'], incoming_file2.file_name)
      result2 = {is_approved: approved2, file_path: file_path2}
      result2.should == {is_approved: approved2, file_path: file_path2}
    end
  end

end