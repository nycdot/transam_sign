require 'rails_helper'

describe "asset_events/_mileage_update_event_form.html.haml", :type => :view do
  it 'fields' do
    ServiceVehicle.destroy_all
    test_vehicle = create(:service_vehicle)
    assign(:asset, test_vehicle)
    assign(:asset_event, test_vehicle.build_typed_event('MileageUpdateEvent'.constantize))
    render

    expect(rendered).to have_field('asset_event_current_mileage')
    expect(rendered).to have_field('asset_event_event_date')
    expect(rendered).to have_field('asset_event_comments')
  end
end
