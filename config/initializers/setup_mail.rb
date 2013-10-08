ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "localhost",  
  :user_name            => "test05646",  
  :password             => "verysecurepassword",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  