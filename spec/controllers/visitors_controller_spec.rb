require 'rails_helper'

describe VisitorsController do

  describe 'index action' do

    it "renders index template" do
      get :index
      expect(response).to render_template('index')
    end

  end

end
