require 'rails_helper'

RSpec.describe SignStandard, :type => :model do

  let(:org)                     { build_stubbed(:organization) }
  let(:test_sign_standard)      { build_stubbed(:sign_standard) }
  let(:persisted_sign_standard) { create(:sign_standard) }

  #------------------------------------------------------------------------------
  #
  # Class Methods
  #
  #------------------------------------------------------------------------------


  #------------------------------------------------------------------------------
  #
  # Instance Methods
  #
  #------------------------------------------------------------------------------

  describe '#validates' do
    it 'should have a SMO code' do
      persisted_sign_standard.smo_code = nil
      expect(persisted_sign_standard).not_to be_valid

      persisted_sign_standard.smo_code = "R-116"
      expect(persisted_sign_standard).to be_valid
    end

    it 'should have a size description' do
      persisted_sign_standard.size_description = nil
      expect(persisted_sign_standard).not_to be_valid

      persisted_sign_standard.size_description = "24 x 36"
      expect(persisted_sign_standard).to be_valid
    end

    it 'should have a sign description' do
      persisted_sign_standard.sign_description = nil
      expect(test_sign_standard).not_to be_valid

      persisted_sign_standard.sign_description = "Railroad crossing sign"
      expect(persisted_sign_standard).to be_valid
    end

    it 'should have an asset subtype' do
      persisted_sign_standard.asset_subtype = nil
      expect(persisted_sign_standard).not_to be_valid

      persisted_sign_standard.asset_subtype_id = 1
      expect(persisted_sign_standard).to be_valid
    end

  end

  describe '#description' do
    it 'should be a standard SMO description' do
      expect(test_sign_standard.description).to eq("R-116 24 x 36 Railroad crossing sign")
    end
  end

  describe '#deprecated?' do
    it 'should be false by default' do
      expect(test_sign_standard.deprecated?).to be false
    end

    it 'should be true if has superseded_by' do
      test_sign_standard.superseded_by = build_stubbed(:sign_standard)
      expect(test_sign_standard.deprecated?).to be true
    end
  end



end
