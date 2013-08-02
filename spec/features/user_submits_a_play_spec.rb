require 'acceptance_helper'

describe 'Visiting app' do
  describe 'when I enter an XML endpoint' do
    context 'with the expected formatting' do
      it 'displays all the play statistics' do
        visit '/'
        expect(page).to have_content('Welcome!')
      end
    end
  end

  context 'with incorrect formatting' do
    it 'does something else' do
    end
  end
end
