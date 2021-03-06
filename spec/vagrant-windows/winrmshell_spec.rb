require 'spec_helper'

describe VagrantWindows::Communication::WinRMShell, :integration => true do
  
  before(:all) do
    # This test requires you already have a running Windows Server 2008 R2 Vagrant VM
    # Not ideal, but you have to start somewhere
    @shell = VagrantWindows::Communication::WinRMShell.new("localhost", "vagrant", "vagrant")
  end
  
  describe "powershell" do
    it "should return exit code of 0" do
      expect(@shell.powershell("exit 0")[:exitcode]).to eq(0)
    end
    
    it "should return exit code greater than 0" do
      expect(@shell.powershell("exit 1")[:exitcode]).to eq(1)
    end
    
    it "should return stdout" do
      result = @shell.powershell("dir") do |type, line|
        expect(type).to eq(:stdout)
        expect(line.length).to be > 1  
      end
      expect(result[:exitcode]).to eq(0)
    end
  end
  
  describe "cmd" do
    it "should return stdout" do
      result = @shell.cmd("dir") do |type, line|
        expect(type).to eq(:stdout)
        expect(line.length).to be > 1  
      end
      expect(result[:exitcode]).to eq(0)
    end
  end
 
end
