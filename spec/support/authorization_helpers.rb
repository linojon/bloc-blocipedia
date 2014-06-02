def sign_in(user)
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'secretsecret'
  click_button 'Sign in'
end