# ref: http://blog.sorryapp.com/2013/03/22/request-and-controller-specs-with-devise.html
# This support package contains modules for authenticaiting
# devise users for request specs.

# This module authenticates users for request specs.#
module ValidUserRequestHelper
    # Define a method which signs in as a valid user.
    def sign_in_as_a_valid_user
        # ASk factory girl to generate a valid user for us.
        @user ||= FactoryGirl.create :user

        # # We action the login request using the parameters before we begin.
        # # The login requests will match these to the user we just created in the factory, and authenticate us.
        # post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
        visit '/'
        click_link 'Sign in'
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: 'secretsecret'
        click_button 'Sign in'
    end
end

# Configure these to modules as helpers in the appropriate tests.
RSpec.configure do |config|
    # Include the help for the request specs.
    config.include ValidUserRequestHelper #, :type => :request
end
