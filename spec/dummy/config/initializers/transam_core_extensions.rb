
# Defines services to use
Rails.application.config.new_user_service = "NewUserService"
Rails.application.config.policy_analyzer = "PolicyAnalyzer"

# Set the image to use if a sign standard image is missing
Rails.application.config.missing_sign_image = 'missing_sign_placeholder'
