require 'rails_helper'

RSpec.describe TransamFormatHelper, :type => :helper do

  it '.get_max_useful_miles_collection' do
    expect(helper.get_max_useful_miles_collection).to eq([['100,000', 100000], ['150,000', 150000], ['200,000', 200000], ['250,000', 250000], ['300,000', 300000],['350,000', 350000], ['400,000', 400000], ['450,000', 450000], ['500,000', 500000], ['550,000', 550000], ['600,000', 600000], ['650,000', 650000], ['700,000', 700000], ['750,000', 750000]])
  end
  it '.get_max_useful_years_collection' do
    expect(helper.get_max_useful_years_collection).to eq([['1 year', 12], ['2 years', 24], ['3 years', 36], ['4 years', 48], ['5 years', 60], ['6 years', 72], ['7 years', 84], ['8 years', 96], ['9 years', 108], ['10 years', 120], ['11 years', 132], ['12 years', 144], ['13 years', 156], ['14 years', 168], ['15 years', 180], ['16 years', 192], ['17 years', 204], ['18 years', 216], ['19 years', 228], ['20 years', 240], ['21 years', 252], ['22 years', 264], ['23 years', 276], ['24 years', 288], ['25 years', 300], ['26 years', 312], ['27 years', 324], ['28 years', 336], ['29 years', 348], ['30 years', 360], ['31 years', 372], ['32 years', 384], ['33 years', 396], ['34 years', 408], ['35 years', 420], ['36 years', 432], ['37 years', 444], ['38 years', 456], ['39 years', 468], ['40 years', 480]])
  end
end
