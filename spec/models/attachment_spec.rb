require 'spec_helper'

describe Attachment do
  include HelperMethods
  
  before(:each) do
    mock_ldap
  end

  context 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:attachable) }
  end

  context "constant" do
    it "should check for constant" do
      Attachment::BlackList.should == %w(exe vbs rb sh jar html msi bat com bin vb)
    end
  end

  context "save" do
    it "should set the name when name is blank" do
      whitelisted_identity = Factory(:whitelisted_identity)
      file = File.new(Rails.root + 'spec/fixtures/rails.png')
      attachment = Factory(:attachment, :note => '',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => whitelisted_identity)
      attachment.note.should == attachment.file.filename
    end

    it "throws error for file size" do
      whitelisted_identity = Factory(:whitelisted_identity)
      file = File.new(Rails.root + 'spec/fixtures/pigeon.JPG')
      attachment = Factory.build(:attachment, :note => '',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => whitelisted_identity)
      attachment.save.should be_false
      attachment.errors.messages.should_not be_blank
    end

    it "throws error for file if it is in black list" do
      whitelisted_identity = Factory(:whitelisted_identity)
      file = File.open('Test2.exe', "w")
      attachment = Factory.build(:attachment, :note => '',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => whitelisted_identity)
      attachment.save.should be_false
      attachment.errors.messages.should == { :file=>["You are not allowed to upload \"exe\" files, prohibited types: exe, vbs, rb, sh, jar, html, msi, bat, com, bin, vb"] }
      attachment.errors.messages.should_not be_blank
      FileUtils.rm_f 'Test2.exe'
    end

    it "should throw error if file has invalid extension" do
      whitelisted_identity = Factory(:whitelisted_identity)
      file = File.open('Test2.exe.txt', "w")
      attachment = Factory.build(:attachment, :note => '',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => whitelisted_identity)
      attachment.save.should be_false
      attachment.errors.messages.should == { :base => ["Invalid file extension"] }
      attachment.errors.messages.should_not be_blank
      FileUtils.rm_f 'Test2.exe.txt'
    end

    it "should not throw error if file has correct extension" do
      whitelisted_identity = Factory(:whitelisted_identity)
      file = File.open('Test2.png.txt', "w")
      attachment = Factory.build(:attachment, :note => '',:file => ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file)), :attachable => whitelisted_identity)
      attachment.save.should be_true
      attachment.errors.messages.should be_empty
      FileUtils.rm_f 'Test2.png.txt'
    end
  end
end
