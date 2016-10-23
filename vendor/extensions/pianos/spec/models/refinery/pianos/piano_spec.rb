require 'spec_helper'

module Refinery
  module Pianos
    describe Piano do
      describe "validations", type: :model do
        subject do
          FactoryGirl.create(:piano,
          :name => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:name) { should == "Refinery CMS" }
      end
    end
  end
end
