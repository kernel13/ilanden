# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Notes" do
    describe "Admin" do
      describe "notes" do
        login_refinery_user

        describe "notes list" do
          before do
            FactoryGirl.create(:note, :name => "UniqueTitleOne")
            FactoryGirl.create(:note, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.notes_admin_notes_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.notes_admin_notes_path

            click_link "Add New Note"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Notes::Note.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::Notes::Note.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:note, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.notes_admin_notes_path

              click_link "Add New Note"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Notes::Note.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:note, :name => "A name") }

          it "should succeed" do
            visit refinery.notes_admin_notes_path

            within ".actions" do
              click_link "Edit this note"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:note, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.notes_admin_notes_path

            click_link "Remove this note forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Notes::Note.count.should == 0
          end
        end

      end
    end
  end
end
