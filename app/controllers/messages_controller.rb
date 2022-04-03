class MessagesController <ApplicationController
    before_action :authenticate_user!

    def new_message
        message = Message.new(params.require(:new_message).permit(:body, :user_id, :conversation_id))
        conversation_id = message.conversation_id
        messages = Message.where(conversation_id: conversation_id)
        
        if message.save
            create_notification(message)
            respond_to do |format|
                format.html do
                    render :'messages/index.html.erb', locals: { conversation_id: conversation_id, messages: messages }
                end
            end
        end
    end

    def create_notification(message)
        #return if Conversation.find(message.conversation_id).recipient_id == current_user.id
        conversation = Conversation.find(message.conversation_id)
        if conversation.sender_id != message.user_id
            notified_to = conversation.sender_id
        else
            notified_to = conversation.recipient_id
        end

        Notification.create(user_id: notified_to,
                            notified_by_id: message.user_id,
                            conversation: conversation.id,
                            identifier: message.id,
                            notice_type: 'comment')
    end
end
