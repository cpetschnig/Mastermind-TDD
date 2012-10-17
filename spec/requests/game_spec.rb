require 'spec_helper'

describe "The game" do
  it "should be solvable within one step" do
    Game.should_receive(:generate_puzzle).and_return(mock(:game, :puzzle => [1, 2, 4, 5]))

    visit index_path

    fill_in '0', :with => '1'
    fill_in '1', :with => '2'
    fill_in '2', :with => '4'
    fill_in '3', :with => '5'
    click_button 'Go'

    page.should have_content 'You won!'
  end

  it "should be playable again and again" do
    Game.stub(:generate_puzzle).and_return(mock(:game, :puzzle => [1, 2, 4, 5]))

    visit index_path

    fill_in '0', :with => '1'
    fill_in '1', :with => '2'
    fill_in '2', :with => '4'
    fill_in '3', :with => '5'
    click_button 'Go'

    click_link 'Again'

    page.should have_selector "input[@name='0']"
    page.should have_selector "input[@name='1']"
    page.should have_selector "input[@name='2']"
    page.should have_selector "input[@name='3']"
  end

  it "should print the last bet with a hint" do
    visit index_path

    fill_in '0', :with => '1'
    fill_in '1', :with => '2'
    fill_in '2', :with => '4'
    fill_in '3', :with => '5'
    click_button 'Go'

    within 'table tbody tr' do
      find('td[1]').text.should == '1'
      find('td[2]').text.should == '2'
      find('td[3]').text.should == '4'
      find('td[4]').text.should == '5'
      find('td[5]').text.should match %r|\[[0-4], [0-4]\]|
    end
  end

  it "should give a hint" do
    Game.stub(:generate_puzzle).and_return(mock(:game, :puzzle => [1, 2, 4, 5]))

    visit index_path

    fill_in '0', :with => '1'
    fill_in '1', :with => '4'
    fill_in '2', :with => '5'
    fill_in '3', :with => '2'
    click_button 'Go'

    page.should have_content '[1, 3]'

    fill_in '0', :with => '1'
    fill_in '1', :with => '2'
    fill_in '2', :with => '4'
    fill_in '3', :with => '6'
    click_button 'Go'

    page.should have_content '[3, 0]'
  end
end
