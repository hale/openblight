require 'spec_helper'

describe CasesController do
  before do
    @case = FactoryGirl.create(:case)
  end

  describe "GET Index" do
    it "assigns all cases as @cases" do
      get :index
      assigns(:cases).should eq([@case])
    end
  end

  describe "GET Show" do
    it "assigns the requested case as @case" do
      get :show, :id => @case.id
      assigns(:case).should eq(@case)
    end
  end
end
