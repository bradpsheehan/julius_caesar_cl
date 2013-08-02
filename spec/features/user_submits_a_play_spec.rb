require 'acceptance_helper'

describe 'Visiting app' do
  describe 'when I enter an XML endpoint' do
    context 'with the expected formatting' do

      before(:each) do
        visit '/'
      end

      def submit_play
        fill_in 'xml_url', :with => 'http://www.cafeconleche.org/examples/shakespeare/j_caesar.xml'
        click_button 'submit'
      end

      def submit_play2
        fill_in 'xml_url', :with => 'http://www.cafeconleche.org/examples/shakespeare/macbeth.xml'
        click_button 'submit'
      end

      it 'displays the correct play table' do
        submit_play
        expect( page ).to have_content('The Tragedy of Julius Caesar')
      end

      it 'displays a different play' do
        submit_play2
        expect( page ).to have_content('The Tragedy of Macbeth')
      end

      xit 'sorts a column of data on click', js: true do
        submit_play
        expect(page).to_not have_css('td', text: 'DECIUS BRUTUS')
        find(:css, '#lines_spoken').click
        expect(page).to have_css('td', text: 'DECIUS BRUTUS')
      end

      xit 'displays only 10 personas' do
      end

      xit '' do
      end

    end
  end

  context 'with incorrect formatting' do
    it 'does something else' do
      fill_in 'xml_url', :with => 'somethingwrong'
      click_button 'submit'
      expect( page ).to have_content('Sorry, url must end with .xml')
    end
  end
end
