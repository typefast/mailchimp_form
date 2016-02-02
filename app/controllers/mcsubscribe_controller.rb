class McsubscribeController < ApplicationController
  
  def index 
  end
  
  def subscribe 
    email = params[:email][:address] 
    
    if !email.blank
      
      begin
        @mc.lists.subscribe(@list_id, {'email' => email})
        
        respond_to do |format|
          format.json{render :json => {:message => "Success! Check your email to confirm your signup."}}
        end
        
      rescue Mailchimp::ListAlreadySubscribedError
        
        respond_to do |format|
          format.json{render :json => {:message => "#{email} is already subscribed to the list."}}
        end
      
      rescue Mailchimp::ListDoesNotExistError
      
        respond_to do |format|
          format.json{render :json => {:message => "Sorry the list could not be found!"}}
        end
        
      rescue Mailchimp::Error => ex
      
        if ex.message
          
          respond_to do |format|
            format.json{render :json => {:message => "There is an error, please enter a valid email."}}
          end
          
        else
          
          respond_to do |format|
            format.json{render :json => {:message => "An unknown error has occurres."}}
          end
        end
        
      end
      
    else
      
      respond_to do |format|        
        format.json{render :json => {:message => "Email Address Cannot be blank. Please enter valid email."}}
      end
      
    end
  end
end
