class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def show
        conversation_id = params[:id]
        conversation = Conversation.find(conversation_id)
        sender_id = conversation.sender_id
        recipient_id = conversation.recipient_id
        messages = Message.where(conversation_id: conversation_id)

        respond_to do |format|
            format.html do 
                render :'messages/index.html.erb', locals: { conversation_id: conversation_id, messages: messages }
            end
        end
    
    end
end