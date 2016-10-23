# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Pianos" do
    describe "Admin" do
      describe "pianos", type: :feature do
        refinery_login

        describe "pianos list" do
          before do
            FactoryGirl.create(:piano, :name => "UniqueTitleOne")
            FactoryGirl.create(:piano, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.pianos_admin_pianos_path
            expect(page).to have_content("UniqueTitleOne")
            expect(page).to have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.pianos_admin_pianos_path

            click_link "Add New Piano"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              expect { click_button "Save" }.to change(Refinery::Pianos::Piano, :count).from(0).to(1)

              expect(page).to have_content("'This is a test of the first string field' was successfully added.")
            end
          end

          context "invalid data" do
            it "should fail" do
              expect { click_button "Save" }.not_to change(Refinery::Pianos::Piano, :count)

              expect(page).to have_content("Name can't be blank")
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:piano, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.pianos_admin_pianos_path

              click_link "Add New Piano"

              fill_in "Name", :with => "UniqueTitle"
              expect { click_button "Save" }.not_to change(Refinery::Pianos::Piano, :count)

              expect(page).to have_content("There were problems")
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:piano, :name => "A name") }

          it "should succeed" do
            visit refinery.pianos_admin_pianos_path

            within ".actions" do
              click_link "Edit this piano"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            expect(page).to have_content("'A different name' was successfully updated.")
            expect(page).not_to have_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:piano, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.pianos_admin_pianos_path

            click_link "Remove this piano forever"

            expect(page).to have_content("'UniqueTitleOne' was successfully removed.")
            expect(Refinery::Pianos::Piano.count).to eq(0)
          end
        end

      end
    end
  end
end
