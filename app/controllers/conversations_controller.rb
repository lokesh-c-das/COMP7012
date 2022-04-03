class ConversationsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        users = User.all 
        conversations = Conversation.all
        respond_to do |format|
            format.html do
                render :index, locals: {users: users, conversations: conversations}
            end
        end
    end

    def conversation_with_authority
        conversation = nil
        #Person.where(["user_name = :u", { u: user_name }]).fifth
        authority = User.select(:id).where(["email = 'report@memphis.edu'"]).first
        authority_id = authority.id
        sender_id = current_user.id

        respond_to do |format|
            format.html do
                conversation = Conversation.between(sender_id, authority_id)
                if !conversation.present?
                    conversation = Conversation.new()
                    conversation.sender_id = sender_id
                    conversation.recipient_id = authority_id

                    if conversation.save
                        conversation = Conversation.between(sender_id, authority_id)
                    else
                        flash[:warning] = "Conversation with authority cannot be created"
                    end
                else
                    redirect_to report_message_url(conversation[0].id)
                end
            end
        end
    end


    def new_conversation
        messages = nil
        sender_id = current_user.id
        recipient_id = Car.select(:user_id).where(id: params[:id])
        recipient_id = recipient_id[0].user_id

        respond_to do |format|
            format.html do
                if sender_id == recipient_id
                    flash[:warning] = "You cannot message yourself!"
                    redirect_to car_details_url
                else
                    conversation = Conversation.between(sender_id, recipient_id)

                    if !conversation.present?
                        conversation = Conversation.new()
                        conversation.sender_id = sender_id
                        conversation.recipient_id = recipient_id

                        if conversation.save
                            conversation = Conversation.between(sender_id, recipient_id)
                        else
                            flash[:warning] = "Conversation cannot be created"
                        end
                    else
                        messages = Message.where(conversation_id: conversation[0].id)
                    end
                    render :'messages/index.html.erb', locals: { conversation_id: conversation[0].id, messages: messages }
                end
            end
        end     
    end
end




