require 'rails_helper'

describe "asset_events/_mileage_update_event_view.html.haml", :type => :view do
  it 'info' do
    test_event = create(:mileage_update_event, :current_mileage => 1111)
    assign(:asset_event, test_event)
    render

    expect(rendered).to have_content('1,111')
  end
end
