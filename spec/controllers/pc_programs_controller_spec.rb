require 'spec_helper'

describe PcProgramsController do
  include HelperMethods
  
  before(:each) do
    @controller.instance_eval { flash.extend(DisableFlashSweeping) }
    sign_in @user = Factory(:user)
    Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'editor').id)
    request.env["HTTP_REFERER"] = "/"
  end
  
  describe "GET index" do
    it "assigns all pc_programs as @pc_programs" do
      pc_program = Factory(:pc_program, :approval_status => 'A')
      get :index
      assigns(:pc_programs).should eq([pc_program])
    end
    
    it "assigns all unapproved pc_programs as @pc_programs when approval_status is passed" do
      pc_program = Factory(:pc_program)
      get :index, :approval_status => 'U'
      assigns(:pc_programs).should eq([pc_program])
    end
  end
  
  describe "GET show" do
    it "assigns the requested pc_program as @pc_program" do
      pc_program = Factory(:pc_program)
      get :show, {:id => pc_program.id}
      assigns(:pc_program).should eq(pc_program)
    end
  end
  
  describe "GET new" do
    it "assigns a new pc_program as @pc_program" do
      get :new
      assigns(:pc_program).should be_a_new(PcProgram)
    end
  end

  describe "GET edit" do
    it "assigns the requested pc_program with status 'U' as @pc_program" do
      pc_program = Factory(:pc_program, :approval_status => 'U')
      get :edit, {:id => pc_program.id}
      assigns(:pc_program).should eq(pc_program)
    end

    it "assigns the requested pc_program with status 'A' as @pc_program" do
      pc_program = Factory(:pc_program,:approval_status => 'A')
      get :edit, {:id => pc_program.id}
      assigns(:pc_program).should eq(pc_program)
    end

    it "assigns the new pc_program with requested pc_program params when status 'A' as @pc_program" do
      pc_program = Factory(:pc_program,:approval_status => 'A')
      params = (pc_program.attributes).merge({:approved_id => pc_program.id,:approved_version => pc_program.lock_version})
      get :edit, {:id => pc_program.id}
      assigns(:pc_program).should eq(PcProgram.new(params))
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new pc_program" do
        params = Factory.attributes_for(:pc_program)
        expect {
          post :create, {:pc_program => params}
        }.to change(PcProgram.unscoped, :count).by(1)
        flash[:alert].should  match(/PcProgram successfully created/)
        response.should be_redirect
      end

      it "assigns a newly created pc_program as @pc_program" do
        params = Factory.attributes_for(:pc_program)
        post :create, {:pc_program => params}
        assigns(:pc_program).should be_a(PcProgram)
        assigns(:pc_program).should be_persisted
      end

      it "redirects to the created pc_program" do
        params = Factory.attributes_for(:pc_program)
        post :create, {:pc_program => params}
        response.should redirect_to(PcProgram.unscoped.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved pc_program as @pc_program" do
        params = Factory.attributes_for(:pc_program)
        params[:mm_host] = nil
        expect {
          post :create, {:pc_program => params}
        }.to change(PcProgram, :count).by(0)
        assigns(:pc_program).should be_a(PcProgram)
        assigns(:pc_program).should_not be_persisted
      end

      it "re-renders the 'new' template when show_errors is true" do
        params = Factory.attributes_for(:pc_program)
        params[:mm_host] = nil
        post :create, {:pc_program => params}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested pc_program" do
        pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs")
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_programs"
        put :update, {:id => pc_program.id, :pc_program => params}
        pc_program.reload
        pc_program.mm_host.should == "http://localhost:3002/pc_programs"
      end

      it "assigns the requested pc_program as @pc_program" do
        pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs")
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_programs"
        put :update, {:id => pc_program.to_param, :pc_program => params}
        assigns(:pc_program).should eq(pc_program)
      end

      it "redirects to the pc_program" do
        pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs")
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_programs"
        put :update, {:id => pc_program.to_param, :pc_program => params}
        response.should redirect_to(pc_program)
      end

      it "should raise error when tried to update at same time by many" do
        pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs")
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = "http://localhost:3002/pc_programs"
        pc_program2 = pc_program
        put :update, {:id => pc_program.id, :pc_program => params}
        pc_program.reload
        pc_program.mm_host.should == "http://localhost:3002/pc_programs"
        params[:mm_host] = "http://localhost:3003/pc_programs"
        put :update, {:id => pc_program2.id, :pc_program => params}
        pc_program.reload
        pc_program.mm_host.should == "http://localhost:3002/pc_programs"
        flash[:alert].should  match(/Someone edited the pc_program the same time you did. Please re-apply your changes to the pc_program/)
      end
    end

    describe "with invalid params" do
      it "assigns the pc_program as @pc_program" do
        pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs")
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = nil
        put :update, {:id => pc_program.to_param, :pc_program => params}
        assigns(:pc_program).should eq(pc_program)
        pc_program.reload
        params[:mm_host] = nil
      end

      it "re-renders the 'edit' template when show_errors is true" do
        pc_program = Factory(:pc_program)
        params = pc_program.attributes.slice(*pc_program.class.attribute_names)
        params[:mm_host] = nil
        put :update, {:id => pc_program.id, :pc_program => params, :show_errors => "true"}
        response.should render_template("edit")
      end
    end
  end
 
  describe "GET audit_logs" do
    it "assigns the requested pc_program as @pc_program" do
      pc_program = Factory(:pc_program)
      get :audit_logs, {:id => pc_program.id, :version_id => 0}
      assigns(:pc_program).should eq(pc_program)
      assigns(:audit).should eq(pc_program.audits.first)
      get :audit_logs, {:id => 12345, :version_id => "1"}
      assigns(:pc_program).should eq(nil)
      assigns(:audit).should eq(nil)
    end
  end

  describe "PUT approve" do
    it "(edit) unapproved record can be approved and old approved record will be updated" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_program1 = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs", :approval_status => 'A')
      pc_program2 = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs", :approval_status => 'U', :mm_admin_host => '111.111.111.111', :approved_version => pc_program1.lock_version, :approved_id => pc_program1.id, :created_by => 666)
      # the following line is required for reload to get triggered (TODO)
      pc_program1.approval_status.should == 'A'
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_program2.id}
      PcUnapprovedRecord.count.should == 0
      pc_program1.reload
      pc_program1.mm_admin_host.should == '111.111.111.111'
      pc_program1.updated_by.should == "666"
      PcProgram.find_by_id(pc_program2.id).should be_nil
    end

    it "(create) unapproved record can be approved" do
      user_role = UserRole.find_by_user_id(@user.id)
      user_role.delete
      Factory(:user_role, :user_id => @user.id, :role_id => Factory(:role, :name => 'supervisor').id)
      pc_program = Factory(:pc_program, :mm_host => "http://localhost:3001/pc_programs", :approval_status => 'U', :mm_admin_host => '111.111.111.111')
      PcUnapprovedRecord.count.should == 1
      put :approve, {:id => pc_program.id}
      PcUnapprovedRecord.count.should == 0
      pc_program.reload
      pc_program.mm_admin_host.should == '111.111.111.111'
      pc_program.approval_status.should == 'A'
    end
  end
end
