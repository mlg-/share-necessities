class Users::InvitationsController < Devise::InvitationsController
  def create
    if User.where(email: params[:user][:email]).length >= 1
        id = User.where(email: params[:user][:email]).first.id
        inviting_organization = params[:user][:invited_by_organization_id].to_i
        Organizer.create(user_id: id, organization_id:
                         inviting_organization)
        flash[:notice] = "This organizer has been added."
        redirect_to edit_organization_path(id: inviting_organization)
    else
      super
    end
  end

  def after_invite_path_for(resource)
    org = params[:user][:invited_by_organization_id].to_i
    inviting_organizer = resource.id
    organizer_affiliations = Organizer.where(user_id: inviting_organizer)
    if organizer_affiliations.any? { |o| o[:organization_id] == org }
      edit_organization_path(id: org)
    else
      flash[:error] = "You do not have permission to invite this user."
      edit_organization_path(id: org)
    end
  end

  def after_accept_path_for(resource)
    inviting_organization = resource.invited_by_organization_id.to_i
    Organizer.create(user_id: resource.id, organization_id:
                     inviting_organization)
    organization_path(id: inviting_organization)
  end
end